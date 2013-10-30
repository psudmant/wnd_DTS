
#HG19
dup_tabix=~/genomes/annotations/hg19/superdups/superdups_sorted.gz
gene_tabix=~/genomes/annotations/hg19/genes/refGene.txt_sorted.gz
GC_tabix=~/genomes/GC_tracks/hg19-gc-w200.GC_content.bed_sorted.gz
wnd_contigs=/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/windowed_analysis/DTS_window_analysis/windows/hg19_slide/500_bp_windows.pkl.contigs
GC_DTS=/net/eichler/vol7/home/psudmant/genomes/GC_tracks/windowed_DTS/HG19/HG19_slide500_bp.GC_content

mask_track=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG19-noWM-pad36
mask_contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg19_contigs.txt
gaps=~/genomes/annotations/hg19/gaps/gap.bed.gz
segdups=~/genomes/annotations/hg19/superdups/superdups.merged.bed.gz
out_viz_dir=./call_visualizations/Homo
out_call_dir=~/public_html/1000_genomes/analysis/dup_del_callsets/dCGH/HGDP_Denisova_Neanderthal_Loschbour
#out_call_dir=~/public_html/1000_genomes/analysis/dup_del_callsets/dCGH/1kg_vs_HGDP

#in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/
#refs_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/Neanderthal/500bp_slide/renamed/

in_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/renamed
refs_dir=/net/eichler/vol19/projects/human_population_sequencing/nobackups/psudmant/wnd_output_DTS/hg19/C_team/renamed
outdir=/net/eichler/vol7/home/psudmant/public_html/WorldWide_SD_diversity/QC/depth_cvg_var

module load python/2.7.3
module load numpy/1.7.0
module load scipy/0.12.0b1


for test_DTS in `ls $in_dir/*`
do	    
    indiv=`echo $test_DTS | awk -F '/' '{print $(NF)}'` 
    echo python assess_variance_over_DTS.py  --GC_tabix $GC_tabix --dup_tabix $dup_tabix  --contigs $wnd_contigs --in_DTS $test_DTS --gaps $gaps  --segdups $segdups --window_size 500 --GC_DTS $GC_DTS --out_total $outdir/total/$indiv --out_by_GC $outdir/by_GC/$indiv
    #--chunk_len 1000000 --binomial_smooth_k_times 0 --k_mult_transitions 0 --cutoff_scale 3000 --max_merge_dif 0.27  --out_call_dir $out_call_dir --out_prefix $out_prefix --ref_DTS $ref_DTS  --plot_lims -4:4  
    #--GC_contents_dir $GC_contents_dir 
done

