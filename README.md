# SO-MAGs
Scripts used to generate Metagenome-Assembled Genomes from the Southern Ocean, see flow diagram below:

![Untitled](https://user-images.githubusercontent.com/84008482/136346041-0652c7c6-72dc-4a9d-aec3-2c24ee4f41fd.png)

> While we assembled and binned each sample step-by-step, ATLAS (Kieser et al., 2020) ran on all the samples.

module load metagenome-atlas
source /apps/miniconda3/etc/profile.d/cond/sh
conda activate atlasenv

atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads/atlas/ --working-dir /nlustre/users/tiffdp/SCALE-META-reads/atlas/SCALE-META-reads

atlas run qc assembly binning --resources mem=250 --jobs 20 –-keep-going

> The raw sequence reads needed to be trimmed with Trimmomatic (Bolger, Lohse and Usadel, 2014) to remove low quality reads and Nextera PE-PE adapters.

for f in $(ls *fastq.gz | sed -e 's/_R1_001.fastq.gz//' -e 's/_R2_001.fastq.gz//' | sort -u)
do java -jar /usr/local/src/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 -threads 8 ${f}_R1_001.fastq.gz ${f}_R2_001.fastq.gz ${f}_R1_001_paired.fastq.gz ${f}_R1_001_unpaired.fastq.gz ${f}_R2_001_paired.fastq.gz ${f}_R2_001_unpaired.fastq.gz ILLUMINACLIP:/usr/local/src/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
