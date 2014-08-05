
#HG19
wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/500_bp_windows.pkl.contigs
sunk_wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_sunk_slide/500_bp_windows.sunks.pkl.contigs

#wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19/500_bp_windows.pkl.contigs
#sunk_wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_sunk/500_bp_windows.pkl.contigs
#in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/
#refs_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/

#in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/DTS_renamed/500_bp_slide
#sunk_in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/DTS_renamed/500_bp_sunk_slide

#in_dir=/net/eichler/vol23/projects/human_diversity/nobackups/PCR_free_genomes/DTS_files/500_bp_slide
#sunk_in_dir=/net/eichler/vol23/projects/human_diversity/nobackups/PCR_free_genomes/DTS_files/500_bp_sunk_slide

in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/MTN_GORILLA/500_bp_slide
sunk_in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/MTN_GORILLA/500_bp_sunk_slide

#in_dir=/net/eichler/vol22/projects/1000_genomes_phase_II_III/nobackups/DTS/
#sunk_in_dir=/net/eichler/vol22/projects/1000_genomes_phase_II_III/nobackups/sunk_DTS/
#genotype_loci=/net/eichler/vol7/home/psudmant/public_html/1000_genomes/PHASE_II_III/CNV_calling/callsets/20101027_all_calls_NO_DUPS.sorted.gz
#gglob_dir=/net/eichler/vol20/projects/human_diversity_sequencing/nobackups/1kg_PHASE_I_II_III/gglob
#gglob_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/gglob_renamed/
#gglob_dir=/net/eichler/vol23/projects/human_diversity/nobackups/PCR_free_genomes/DTS_gglob
gglob_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/MTN_GORILLA/gglob/

wnd_slide=100
wnd_size=500

##setup
if [ "$1" == "setup" ]
then
    echo python ~psudmant/EEE_Lab/projects/common_code/ssf_DTS_caller/gglob.py  --contigs $wnd_contigs --in_DTS_dir $in_dir --gglob_dir $gglob_dir --wnd_size $wnd_size --wnd_slide $wnd_slide --sunk_contigs $sunk_wnd_contigs --in_sunk_DTS_dir $sunk_in_dir --init  
else
    for chr in `cat $wnd_contigs | awk '{print $1}'`
    do
        echo which python';' source ~psudmant/.bash_profile ';' which python ';' python ~psudmant/EEE_Lab/projects/common_code/ssf_DTS_caller/gglob.py  --contigs $wnd_contigs --in_DTS_dir $in_dir --gglob_dir $gglob_dir --wnd_size $wnd_size --wnd_slide $wnd_slide --sunk_contigs $sunk_wnd_contigs --in_sunk_DTS_dir $sunk_in_dir --setup_chr $chr
    done
fi


