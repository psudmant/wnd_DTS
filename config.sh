export PATH=$PATH/usr/bin

export PYGRDATAPATH=$HOME/pygr_data

	. /net/gs/vol3/software/userenv/pathfuncs.sh
	. /etc/profile.d/modules.sh
	
	module use /net/eichler/vol7/home/psudmant/local_modules
	export MOD_PS_SW=/net/eichler/vol7/home/psudmant/local_modules_sw

	module load modules modules-init modules-gs modules-eichler/prod
    module load vim/7.4
    
    module load ncdu	
	module load zlib/1.2.6
    module load matplotlib_venn/0.9

    module load bwa/0.7.5a
    module load novosort/1.01.00
	module load bedtools/2.15.0
    module load tmux/1.6
	module load mpfr/3.1.0

	module load hdf5/1.8.8
	module load lzo/2.06
	module load python/2.7.2 
	module load pytables/2.3.1_hdf5-1.8.8

	module load tabix/0.2.6
	module load samtools/0.1.19
    
	module load boost/1.52.0
	module load cufflinks/2.0.2
	
    module load PANDAseq/20130605
    module load cython/0.19.1

    module load numpy/1.6.1 scipy/0.10.0
    module load matplotlib_venn/0.9

    module load networkx
    module load perl/5.14.2
    module load git/latest

    module load fastahack
    module load fastahack-python
    module load python3
    module load freebayes
    module load vcflib
    module load matplotlib_venn/0.9


    module load protobuf/2.5.0
    module load openssl/1.0.1g
    
    module load UCSC/20140617
    module load bx-python/PS_0.7.1
	
    export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts
	export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/plotting/heatmap_scripts
	export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/cython_apis
	export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/projects/common_code
	export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/projects/common_code/ssf_DTS_caller
	export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/EEE_Lab/1000G/1000genomesScripts/
	
	if [ "$MODULES_REL" = "RHEL6" ]; then
					
				#ADDED TO make MIROPEATS RUN{
				PATH=$PATH:/usr/local/bin
				PATH=$PATH:/net/eichler/vol2/local/inhousebin/
				PATH=$PATH:/net/eichler/vol2/local/bin/
				PATH=$PATH:/net/eichler/vol7/home/ginger/bin/i386-redhat-linux-gnu
				PATH=$PATH:/net/eichler/vol7/home/ginger/bin
				#}

					export PATH=/net/eichler/vol7/home/psudmant/local_installations/bin_RHEL6:$PATH
					export LD_LIBRARY_PATH=/net/eichler/vol7/home/psudmant/local_installations/lib_RHEL6:$LD_LIBRARY_PATH
					export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/local_installations/python_non_dist_packages_RHEL6
					export PYTHONPATH=$PYTHONPATH:/net/eichler/vol7/home/psudmant/local_installations/python_non_dist_packages_RHEL6/lib/python2.7/site-packages

	fi
