
import sys,os
import numpy as np
import scipy.ndimage as ndi
#import scipy.interpolate.fitpack2 as sp_i_fp2
#from kg_file_handling import *
#from scipy import *
from optparse import OptionParser

from kitz_wssd.wssd_common import *
from wssd_pw_common import *

import math

import ml_get_cpn

from sys import stderr

import cPickle

if __name__=='__main__':

	opts = OptionParser()
	#opts.add_option('','--sex_pop_index',dest='fn_sex_pop_index')
   
	opts.add_option('','--contig_file',dest='fn_contigs')
	opts.add_option('','--gc_track',dest='fn_gc_track')
	opts.add_option('','--outfile',dest='outfile',default=None)
	opts.add_option('','--wnd_width',dest='wnd_width',default=None,type=int)
	opts.add_option('','--wnd_pickle',dest='wnd_pickle',default=None)
	opts.add_option('','--wnd_contig_file',dest='fn_wnd_contig_file')
		
	(o, args) = opts.parse_args()
	
	gc_width = 401.0

	F_region_pickle=open(o.wnd_pickle,"rb")
	regions_chrms,regions_coords,regions_wnds = cPickle.load(F_region_pickle) 

	GC_content = DenseTrackSet(o.fn_contigs,
													o.fn_gc_track,
													overwrite=False,
													openMode = 'r')

	out_GC_wnd_DTS = DenseTrackSet(o.fn_wnd_contig_file,
															"%s"%(o.outfile),
															overwrite=True,
															openMode='w')
	
	out_GC_wnd_DTS.addGroup("GC")
	out_GC_wnd_DTS.addGroup("starts")
	out_GC_wnd_DTS['GC'].addArray(tables.Float32Atom(),[])
	out_GC_wnd_DTS['starts'].addArray(tables.UInt32Atom(),[])
	
	curr_chr=None
	curr_wnd_bin=0
	
	for xi in xrange(len(regions_chrms)):
		chr=regions_chrms[xi]
		start,end= regions_coords[xi]
		wnds = regions_wnds[xi]
		
		GC = GC_content["GC_content"][chr][start:end]

		#if chr!="chr20": continue

		if curr_chr!=chr:
			curr_chr=chr
			curr_wnd_bin=0
		
		print "REGION",chr,start,end,wnds.shape
		print wnds
		#regressions=g_data.get_regression(chr,start,end,wnds,mask,int(o.wnd_width))
		l_wnds=wnds.shape[0]
		#print regressions
		starts=wnds[:,0]+start

		GC_csum=np.cumsum(GC)
		print GC_csum.shape
		GC_csum_at_starts=GC_csum[wnds[:,1]-1]   ###NOT ACTUALLY AT THE START< it's at the end, but, we're going to assign it to the start
		GC_csum_shift = np.r_[0,GC_csum_at_starts[0:GC_csum_at_starts.shape[0]-1]] 
		
		wnd_widths=wnds[:,1]-wnds[:,0]

		mean_GC_frac=(GC_csum_at_starts-GC_csum_shift)/wnd_widths/gc_width
		print mean_GC_frac
		
		out_GC_wnd_DTS['GC'][chr][curr_wnd_bin:curr_wnd_bin+l_wnds] = mean_GC_frac
		out_GC_wnd_DTS['starts'][chr][curr_wnd_bin:curr_wnd_bin+l_wnds] = wnds[:,0]+start

		print out_GC_wnd_DTS['starts'][chr][curr_wnd_bin:curr_wnd_bin+l_wnds]
		#out_GC_wnd_DTS['copy'][chr][curr_wnd_bin:curr_wnd_bin+l_wnds] = regressions
		curr_wnd_bin+=l_wnds



