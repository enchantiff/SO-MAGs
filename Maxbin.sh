cd $PBS_O_WORKDIR

module load maxbin-2.2.6
module load bbmap
module load samtools-1.10
pileup.sh in=metaspades.sam out=cov.txt
awk '{print $1"\t"$5}' cov.txt | grep -v '^#' > abundance.txt

run_MaxBin.pl -thread 20 -contig contigs.fasta -out maxbin -abund abundance.txt
