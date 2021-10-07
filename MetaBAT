cd $PBS_O_WORKDIR

module load metabat
module load bamtools
jgi_summarize_bam_contig_depths --outputDepth depth.txt *.bam

metabat -i contigs.fasta -a depth.txt –verysensitive -o metabat_verysensitive -v > log.txt
metabat -i contigs.fasta -a depth.txt –sensitive -o metabat_sensitive -v > log.txt
