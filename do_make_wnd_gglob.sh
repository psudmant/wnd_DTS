
#HG19
#wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/500_bp_windows.pkl.contigs
wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19/500_bp_windows.pkl.contigs
sunk_wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_sunk/500_bp_windows.pkl.contigs

#in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/
#refs_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/

in_dir=/net/eichler/vol22/projects/1000_genomes_phase_II_III/nobackups/DTS/
sunk_in_dir=/net/eichler/vol22/projects/1000_genomes_phase_II_III/nobackups/sunk_DTS/
genotype_loci=/net/eichler/vol7/home/psudmant/public_html/1000_genomes/PHASE_II_III/CNV_calling/callsets/20101027_all_calls_NO_DUPS.sorted.gz
gglob_dir=/net/eichler/vol7/home/psudmant/public_html/1000_genomes/PHASE_II_III/gglob

##setup
#echo python ~/EEE_Lab/projects/common_code/ssf_DTS_caller/gglob.py  --contigs $wnd_contigs --in_DTS_dir $in_dir --gglob_dir $gglob_dir --wnd_size 500 --wnd_slide 0 --sunk_contigs $sunk_wnd_contigs --in_sunk_DTS_dir $sunk_in_dir --init  

for chr in `cat $wnd_contigs | awk '{print $1}'`
do
    echo python ~/EEE_Lab/projects/common_code/ssf_DTS_caller/gglob.py  --contigs $wnd_contigs --in_DTS_dir $in_dir --gglob_dir $gglob_dir --wnd_size 500 --wnd_slide 0 --sunk_contigs $sunk_wnd_contigs --in_sunk_DTS_dir $sunk_in_dir --setup_chr $chr
done



