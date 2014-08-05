#HG19
#mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG19-noWM-pad36
#fn_out=~/genomes/GC_tracks/windowed_DTS/500_bp_slide_HG19
#wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/
#gc_track=/net/eichler/vol7/home/psudmant/genomes/GC_tracks/hg19-gc-w200.GC_content
#fasta=~/genomes/fastas/hg19/bwa_index/hg19_93_contigs.fa

#GORGOR3
wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/gorGor3.1_slide/
fn_out=~/genomes/GC_tracks/windowed_DTS/500_bp_slide_gorGor3.1
fasta=/net/eichler/vol7/home/psudmant/genomes/fastas/gorGor3.1/gorGor3.fasta

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
	echo python ~/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/generate_windowed_GC_ests.py --wnd_pickle $wnd_pickle --wnd_contig_file $wnd_contig_file --wnd_width $wnd_width  --fasta $fasta --fn_out $fn_out
done
