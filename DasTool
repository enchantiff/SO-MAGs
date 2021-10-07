cd $PBS_O_WORKDIR

module load das_tool-1.1
module load R-3.6.3
module load ruby-2.7.1
module load perl-5.26.1
module load prodigal-2.6.3
module load diamond-2.0.7

DAS_Tool -i /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/metabat_bins/metabat.scaffolds2bin.tsv,/nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/maxbin_bins/maxbin.scaffolds2bin.tsv,/nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/concoct_output/concoct.scaffolds2bin.tsv -l metabat,maxbin,concoct -c contigs.fasta -o DAST_1500 --write_bins 1 --db_directory /nlustre/users/tiffdp/SCALE-META-reads/db -t 20 
