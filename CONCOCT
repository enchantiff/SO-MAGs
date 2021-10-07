cd $PBS_O_WORKDIR

module load concoct
source /apps/miniconda3/etc/profile.d/conda.sh
conda activate concoct

module load bedtools-2.28.0
module load bamtools

cut_up_fasta.py contigs.fasta -c 10000 -o 0 --merge_last -b contigs_10K.bed > contigs_10K.fa
concoct_coverage_table.py contigs_10K.bed metaspades_sorted.bam > coverage_table.tsv
concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/
merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv
mkdir concoct_output/fasta_bins
extract_fasta_bins.py contigs.fasta concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins
