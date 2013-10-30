
########
contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg19_contigs.txt
mask=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG19-noWM-pad36
#
wnd_width=500
windows_out=./windows/hg19_slide/500_bp_windows_2.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width --slide_by 100
##option now --sunk_based (the mask is a sunk mask)


#wnd_width=1000
#windows_out=./windows/hg19/1000_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
#wnd_width=100
#windows_out=./windows/hg19/100_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
#
#contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg18_contigs.txt
#mask=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG18-noWM-pad36_v2
#
#wnd_width=500
#windows_out=./windows/hg18/500_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
#wnd_width=1000
#windows_out=./windows/hg18/1000_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
#wnd_width=100
#windows_out=./windows/hg18/100_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width

#contigs=/net/eichler/vol7/home/psudmant/genomes/contigs/hg18_contigs.txt
#mask=/net/eichler/vol7/home/psudmant/genomes/mask_tracks/HG18-noWM-pad36_v2_mask_GC
#wnd_width=500
#windows_out=./windows/hg18_GC_masked/500_bp_windows.pkl
#echo python generate_window_files.py --contig_file $contigs --mask_file $mask --region_output $windows_out --wnd_width $wnd_width
