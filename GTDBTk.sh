cd $PBS_O_WORKDIR

module load gtdbtk

gtdbtk identify --genome_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/dast_bins/DAST_1500_DASTool_bins --out_dir gtdbtk_identify -x fa --cpus 2
gtdbtk align --identify_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/gtdbtk_identify --out_dir gtdbtk_align --cpus 2
gtdbtk classify --genome_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/dast_bins/DAST_1500_DASTool_bins --align_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/gtdbtk_align --out_dir gtdbtk_classify -x fa --cpus 2
