# SO-MAGs
Scripts used to generate Metagenome-Assembled Genomes from the Southern Ocean, see flow diagram below:

![Untitled](https://user-images.githubusercontent.com/84008482/136346041-0652c7c6-72dc-4a9d-aec3-2c24ee4f41fd.png)

## ATLAS
While we assembled and binned each sample step-by-step, ATLAS (Kieser et al., 2020) ran on all the samples.

`atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads/atlas/ --working-dir /nlustre/users/tiffdp/SCALE-META-reads/atlas/SCALE-META-reads
atlas run qc assembly binning --resources mem=250 --jobs 20 –-keep-going`

## Trimmomatic
The raw sequence reads needed to be trimmed with Trimmomatic (Bolger, Lohse and Usadel, 2014) to remove low quality reads and Nextera PE-PE adapters.

`for f in $(ls *fastq.gz | sed -e 's/_R1_001.fastq.gz//' -e 's/_R2_001.fastq.gz//' | sort -u)`

`do java -jar /usr/local/src/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 -threads 8 ${f}_R1_001.fastq.gz ${f}_R2_001.fastq.gz ${f}_R1_001_paired.fastq.gz ${f}_R1_001_unpaired.fastq.gz ${f}_R2_001_paired.fastq.gz ${f}_R2_001_unpaired.fastq.gz ILLUMINACLIP:/usr/local/src/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36`

`done`

## MetaSPAdes
Subsequently, the high-quality paired reads were aligned using MetaSPAdes (Nurk et al., 2017) to assemble contiguous sequences.

`for f in $(ls *fastq.gz | sed -e 's/_R1_001_paired.fastq.gz//' -e 's/_R2_001_paired.fastq.gz//' | sort -u)`

`do spades.py --pe1-1 ${f}_R1_001_paired.fastq.gz --pe1-2 ${f}_R2_001_paired.fastq.gz --meta -t 24 -o ${f}_metaspades_results -m 500`

`done`

## MetaBAT
Binning was done with the use of MetaBAT (Kang et al., 2019).

`jgi_summarize_bam_contig_depths --outputDepth depth.txt *.bam`

`metabat -i contigs.fasta -a depth.txt –verysensitive -o metabat_verysensitive -v > log.txt`

`metabat -i contigs.fasta -a depth.txt –sensitive -o metabat_sensitive -v > log.txt`

## MaxBin
Binning was done with the use of MaxBin (Wu, Simmons and Singer, 2016).

`pileup.sh in=metaspades.sam out=cov.txt`

`awk '{print $1"\t"$5}' cov.txt | grep -v '^#' > abundance.txt`

`run_MaxBin.pl -thread 20 -contig contigs.fasta -out maxbin -abund abundance.txt`

## CONCOCT
Binning was done with the use of CONCOCT (Alneberg et al., 2013).

`cut_up_fasta.py contigs.fasta -c 10000 -o 0 --merge_last -b contigs_10K.bed > contigs_10K.fa`

`concoct_coverage_table.py contigs_10K.bed metaspades_sorted.bam > coverage_table.tsv`

`concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/`

`merge_cutup_clustering.py concoct_output/clustering_gt1000.csv > concoct_output/clustering_merged.csv`

`mkdir concoct_output/fasta_bins`

`extract_fasta_bins.py contigs.fasta concoct_output/clustering_merged.csv --output_path concoct_output/fasta_bins`

## DAS Tool
Binning was done with the use of MetaBAT (Kang et al., 2019), CONCOCT (Alneberg et al., 2013) and MaxBin (Wu, Simmons and Singer, 2016) and were assessed by DAS Tool (Sieber et al., 2018) to choose the best quality bins.

`DAS_Tool -i /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/metabat_bins/metabat.scaffolds2bin.tsv,/nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/maxbin_bins/maxbin.scaffolds2bin.tsv,/nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/concoct_output/concoct.scaffolds2bin.tsv -l metabat,maxbin,concoct -c contigs.fasta -o DAST_1500 --write_bins 1 --db_directory /nlustre/users/tiffdp/SCALE-META-reads/db -t 20`

## GTDB-Tk
Once DAS Tool had selected the bins of good quality, GTDB-Tk (Chaumeil et al., 2020) was utilized for taxonomic classification.

`gtdbtk identify --genome_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/dast_bins/DAST_1500_DASTool_bins --out_dir gtdbtk_identify -x fa --cpus 2`

`gtdbtk align --identify_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/gtdbtk_identify --out_dir gtdbtk_align --cpus 2`

`gtdbtk classify --genome_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/dast_bins/DAST_1500_DASTool_bins --align_dir /nlustre/users/tiffdp/SCALE-META-reads/deeper_samples/20082D-04-18_S11_L003_metaspades_results/gtdbtk_align --out_dir gtdbtk_classify -x fa --cpus 2`

## MicrobeAnnotator
MAGs were annotated with MicrobeAnnotator (Ruiz-Perez, Conrad and Konstantinidis, 2021).

`microbeannotator -i $(ls *.faa) -d /nlustre/data/MicrobeAnnotator_DB -o microbean -m blast -p 2 -t 12`

## DRAM
MAGs were annotated with DRAM (Shaffer et al., 2020).

`DRAM.py annotate -i '*.fa' -o annotation`

`DRAM.py distill -i annotation/annotations.tsv -o genome_summaries --trna_path annotation/trnas.tsv --rrna_path annotation/rrnas.tsv`

## GToTree
Phylogenetic trees generated using GToTree (Lee, 2019).

`GToTree -g SAR324_gbff.txt -f SAR324_fa.txt -H Bacteria -j 4 -o SAR324_output`
