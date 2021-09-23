#!/bin/bash
for f in $(ls *fastq.gz | sed -e 's/_R1_001.fastq.gz//' -e 's/_R2_001.fastq.gz//' | sort -u)
do java -jar /usr/local/src/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 -threads 8 ${f}_R1_001.fastq.gz ${f}_R2_001.fastq.gz ${f}_R1_001_paired.fastq.gz ${f}_R1_001_unpaired.fastq.gz ${f}_R2_001_paired.fastq.gz ${f}_R2_001_unpaired.fastq.gz ILLUMINACLIP:/usr/local/src/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
