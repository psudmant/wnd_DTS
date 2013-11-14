input_genomes_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/analysis_files/input_genomes_moved/hg19/current_working_genomes/split_C_team
#input_genomes_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/analysis_files/input_genomes_moved/hg19/current_working_genomes/split_Loschbour_ABTeams_Neanderthal_Denisova/
contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg19_contigs.txt
mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG19-noWM-pad36
sunk_mask_file=/net/eichler/vol7/home/psudmant/genomes/sunk_tracks/hg19/hg19_sunk_depth_mask.dts

##outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/

#outdir=~/ev19/projects/apes/nobackups/psudmant/ancient_genomes/Loschbour/analysis/DTS_500_slide
#sunk_outdir=~/ev19/projects/apes/nobackups/psudmant/ancient_genomes/Loschbour/analysis/DTS_500_sunk_slide

outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/500_bp_slide
sunk_outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/500_bp_sunk_slide

wnds_pickle=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/500_bp_windows.pkl
sunk_wnds_pickle=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_sunk_slide/500_bp_windows.sunks.pkl

wnd_width=500

#wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19/
#gc_track=~/genomes/GC_tracks/hg19-gc-w200.GC_content

#######HG18!!
#input_genomes_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/analysis_files/input_genomes_moved/non_human_primates/working_dir/primate_seq_proj//split_reference_genomes_mapped_to_hg18
#split_primate_seq_proj_filtered_for_CP2
#input_genomes_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/analysis_files/input_genomes_moved/non_human_primates/working_dir/primate_seq_proj/Tobi_Kopongo_Redo/split_Tobi_Kopongo
#contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg18_contigs.txt
#mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG18-noWM-pad36_v2
#mask_file=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG18-noWM-pad36_v2_mask_GC
#outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg18/primate_seq_proj
#outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg18/primate_seq_proj_GC_mask
#outdir=~/ev19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg18/primate_references
#wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg18/
#wnd_pickle_dir=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg18_GC_masked

###OR< none will default to the original
###THE BELOW is just for SPECIAL GC libs
#params=_filtered_libs_analysis.GC3v2-NOWM-pad36_v2/fit_params-CALKAN-NOWM-pad36-simple-dim0-ed-all.per_bac_params

#for p in `ls $wnd_pickle_dir/*.pkl | grep 500`  
#	wnd_pickle=$p
#	wnd_contig_file=$p.contigs
for i in `ls $input_genomes_dir`
do
    echo python generate_windowed_cp_ests.py --contig_file $contigs --mask_file $mask_file --genome  $input_genomes_dir/$i --out_prefix $outdir/${wnd_width}_bp  --wnd_pickle $wnds_pickle --wnd_contig_file $wnds_pickle.contigs --wnd_width $wnd_width
    echo python generate_windowed_cp_ests.py --contig_file $contigs --mask_file $sunk_mask_file --genome  $input_genomes_dir/$i --out_prefix $sunk_outdir/${wnd_width}_bp  --wnd_pickle $sunk_wnds_pickle --wnd_contig_file $sunk_wnds_pickle.contigs --wnd_width $wnd_width --sunk_based --param_file _filtered_libs_analysis.GC3v2-NOWM-pad36/fit_params-CALKAN-NOWM-pad36-simple-dim1-ed-0.per_1kb_params
done
