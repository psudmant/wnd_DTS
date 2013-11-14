#HG19
contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg19_contigs.txt
#mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG19-noWM-pad36
outdir=~/genomes/GC_tracks/windowed_DTS
wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/
gc_track=/net/eichler/vol7/home/psudmant/genomes/GC_tracks/hg19-gc-w200.GC_content
outfile_prefix=HG19_slide

##HG18
#contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg18_contigs.txt
##mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG18-noWM-pad36_v2
#outdir=~/genomes/GC_tracks/windowed_DTS
#wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg18/
#gc_track=/net/eichler/vol7/home/psudmant/genomes/GC_tracks/hg18-gc-w200.GC_content
#outfile_prefix=HG18_

for p in `ls $wnd_pickle_dir/*.pkl`  
do
	wnd_pickle=$p
	wnd_contig_file=$p.contigs
	wnd_width=`echo $wnd_pickle | awk -F "/" '{print $(NF)}' | awk -F _ '{print $1}'`
	echo python make_GC_CONTENT_windowed_DTS.py --contig_file $contigs --outfile  $outdir/${outfile_prefix}${wnd_width}_bp.GC_content --wnd_pickle $wnd_pickle --wnd_contig_file $wnd_contig_file --wnd_width $wnd_width  --gc_track $gc_track
done
