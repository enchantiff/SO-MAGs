cd $PBS_O_WORKDIR

module load SPAdes-3.13.0

for f in $(ls *fastq.gz | sed -e 's/_R1_001_paired.fastq.gz//' -e 's/_R2_001_paired.fastq.gz//' | sort -u)
do spades.py --pe1-1 ${f}_R1_001_paired.fastq.gz --pe1-2 ${f}_R2_001_paired.fastq.gz --meta -t 24 -o ${f}_metaspades_results -m 500
done
