import os,sys
import os.path
import cPickle
import pickle 
from optparse import OptionParser
from kitz_wssd.wssd_common_v2 import *
from wssd_pw_common import *
from  ml_get_cpn import *
from sys import stderr
from fastahack import FastaHack
from IPython import embed

if __name__=='__main__':
    opts = OptionParser()
    opts.add_option('','--contig_file',dest='fn_contig_file')
    opts.add_option('','--wnd_width',dest='wnd_width',default=None,type=int)
    opts.add_option('','--wnd_slide',dest='wnd_slide',default=None,type=int)
    opts.add_option('','--wnd_pickle',dest='wnd_pickle',default=None)
    opts.add_option('','--wnd_contig_file',dest='fn_wnd_contig_file')
    opts.add_option('','--fasta',dest='fn_fasta')
    opts.add_option('','--fn_out',dest='fn_out',default=None)
    opts.add_option('','--sunk_based',dest='sunk_based',action='store_true',default=False)
    
    (o, args) = opts.parse_args()
    

    print "loading fasta %s..."%(o.fn_fasta)
    fa = FastaHack(o.fn_fasta)

    print>>stderr, "%s"%(o.fn_out)    
    out_wnd_DTS = DenseTrackSet(o.fn_wnd_contig_file,
                                            "%s"%(o.fn_out),
                                            overwrite=True,
                                            openMode='w')
    
    out_wnd_DTS.addGroup("GC")
    out_wnd_DTS.addGroup("starts")
    out_wnd_DTS.addGroup("ends")
    out_wnd_DTS['GC'].addArray(tables.Float32Atom(),[])
    out_wnd_DTS['starts'].addArray(tables.UInt32Atom(),[])
    out_wnd_DTS['ends'].addArray(tables.UInt32Atom(),[])
    ###WE ONLY NEED THE STARTS because start[k],start[k+1] == start[k], end[k]
    
    print >>stderr,"loading regions..." 
    F_region_pickle=open(o.wnd_pickle,"rb")
    regions_chrms,regions_coords,regions_wnds = cPickle.load(F_region_pickle) 
    print >>stderr,"done "

    curr_chr=None
    curr_wnd_bin=0

    for xi in xrange(len(regions_chrms)):
        chr=regions_chrms[xi]
        start,end= regions_coords[xi]
        wnds = regions_wnds[xi]
        
        #if chr!="chr20": continue

        if curr_chr!=chr:
            curr_chr=chr
            curr_wnd_bin=0
            seq_str = (fa.get_sequence(curr_chr)[:]).upper()
            char_seq_str = np.array(seq_str,'c')
            GC = (char_seq_str=="G")|(char_seq_str=="C")
            notN = (char_seq_str!="N")
            print "chr %s total GC %f"%(curr_chr, np.sum(GC)/float(np.sum(notN)))
            csum_GC = np.cumsum(GC).astype(np.float) 

        print "REGION",chr,start,end,wnds.shape, o.wnd_width
        bp_starts, bp_ends = wnds[:,0]+start, wnds[:,1]+start
        real_lens = bp_ends-bp_starts
        curr_GC = (csum_GC[bp_ends] - csum_GC[bp_starts])/real_lens

        #@regressions=g_data.get_regression(chr,start,end,wnds,mask,int(o.wnd_width))
        ##l_regressions=regressions.shape[0]
        l=wnds.shape[0]
        print wnds.shape
        out_wnd_DTS['starts'][chr][curr_wnd_bin:curr_wnd_bin+l] = wnds[:,0]+start
        out_wnd_DTS['ends'][chr][curr_wnd_bin:curr_wnd_bin+l] = wnds[:,1]+start
        out_wnd_DTS['GC'][chr][curr_wnd_bin:curr_wnd_bin+l] = curr_GC
        #out_wnd_DTS.tbl.flush()
        curr_wnd_bin+=l
        
