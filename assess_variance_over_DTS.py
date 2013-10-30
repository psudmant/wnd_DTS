import sys, os, tempfile, tables, pysam, glob
from optparse import OptionParser
from collections import defaultdict

import numpy as np
import Bio.Statistics.lowess as biostats
import ml_get_cpn as ml_methods

from wssd_pw_common import *
from kitz_wssd.wssd_common_v2 import *
from math import *
from sys import stderr

from wnd_cp_data import wnd_cp_indiv, dCGH
from ssf_caller import ssf_caller, callset
from plot import line_plot, plot

from null_distribution import null_distribution
from null_distribution import plot_density

from get_windowed_variance import get_windowed_variance

def plot_GC(chr,tbx_gc,cp_vect,starts,ends):
    F=open("GC.txt",'w')
    cp_vect = cp_vect.astype(np.float64) 
    var = get_windowed_variance(cp_vect,50)
    F.write("var\tgc\n") 
    for i in xrange(50,starts.shape[0],101):
        s = starts[i-50]
        e = ends[i+50]
        gc = np.mean(np.array([float(l[3]) for l in tbx_gc.fetch(chr,s,e,parser=pysam.asTuple())]))
        if var[i] != 0:
            print >>F,"%f\t%f"%( var[i],gc )
        



    exit(1)
        
def file_exists(ls,file):
  for f in ls:
    if(f==file):
      return 1
  return 0

if __name__=='__main__':

    opts = OptionParser()
    opts.add_option('','--in_DTSs',dest='fn_in_DTS')
    opts.add_option('','--GC_DTS',dest='fn_GC_DTS')
    opts.add_option('','--contigs',dest='fn_contigs')
    opts.add_option('','--out_total',dest='fn_out_total')
    opts.add_option('','--out_by_GC',dest='fn_out_by_GC')
    opts.add_option('','--dup_tabix',dest='fn_dup_tabix')
    opts.add_option('','--GC_tabix',dest='fn_GC_tabix')
    opts.add_option('','--window_size',dest='window_size',default=None)
    opts.add_option('','--mask_contigs',dest='mask_contigs')
    opts.add_option('','--gaps',dest='fn_gaps',default=None)
    opts.add_option('','--segdups',dest='fn_dups',default=None)
    #opts.add_option('','--fdr',dest='fdr',default=0.00,type=float)

    (o, args) = opts.parse_args()
        
    #chunk_len=o.chunk_len
    #bp_cutoff_scale = o.cutoff_scale
    g_to_group = lambda  g: g.split("-")[0]
    
    tbx_gaps = pysam.Tabixfile(o.fn_gaps)
    tbx_dups = pysam.Tabixfile(o.fn_dups)
    tbx_gc   = pysam.Tabixfile(o.fn_GC_tabix)
    
    chrs = []
    for c in tbx_gc.contigs:
        if (not "random" in c) and (not "X" in c) and (not "Y" in c):
            chrs.append(c)
    
    fn_contigs = o.fn_contigs
    wnd =  int(o.window_size)

    ##
    #cutoff_scale=float(bp_cutoff_scale/wnd)
    #max_merge = o.max_merge_dif 
    #cp_data = dCGH(o.fn_in_DTS,o.fn_ref_DTS,o.fn_contigs,wnd)    
    #segment_callset = callset()
    #caller_by_chr = {}
    #dCGH(o.fn_in_DTS,o.fn_ref_DTS,o.fn_contigs,wnd)    
    cp_data = wnd_cp_indiv(o.fn_in_DTS,o.fn_contigs,wnd)
    
    GC_DTS = DenseTrackSet(o.fn_contigs,o.fn_GC_DTS,overwrite=False,openMode='r')
    null_dist = null_distribution(tbx_gc)
    
    for chr in chrs:
        print >>stderr,"%s..."%chr
        magnitude_vect = cp_data.get_cps_by_chr(chr)
        starts_vect,ends_vect = cp_data.get_wnds_by_chr(chr) 

        #plot_GC(chr,tbx_gc,magnitude_vect,starts_vect,ends_vect)
        #print magnitude_vect[0:1000] 
        gapped_wnds = cp_data.get_overlapping_wnds(chr,tbx_gaps) 
        segdup_wnds = cp_data.get_overlapping_wnds(chr,tbx_dups) 
        null_dist.add(magnitude_vect,[gapped_wnds,segdup_wnds])
        
        GC_vect = GC_DTS["GC"][chr][:]
        null_dist.add_to_GC(GC_vect,[gapped_wnds,segdup_wnds])
    
    cps = null_dist.all_cps[null_dist.all_cps<10]
    gcs = null_dist.all_gc[null_dist.all_cps<10]
    #print gcs[0:1000]
    #print cps.shape
    #print gcs.shape
    FOUT = open(o.fn_out_by_GC,'w')
    print >>FOUT, "GC var"
    for i in xrange(0,100):
        lower = i/100.0
        upper = (i+1)/100.0
        where = np.where((gcs>=lower)&(gcs<upper))
        v = np.var(cps[where])
        print >>FOUT, i+1, v
    FOUT.close()
    FOUT = open(o.fn_out_total,'w')
    print >>FOUT, "%f %f"%(np.mean(cps),np.var(cps))
    #d,es = np.histogram2d(cps,gcs,bins=100,range=(-5,10))#(#,density=True) 
    #d,es = np.histogram(cps,bins=100,range=(-5,10))#(#,density=True) 
    #plot_density(d,es,"./dist.pdf")
    #print "mu:%f var:%f"%(np.mean(cps),np.var(cps))

