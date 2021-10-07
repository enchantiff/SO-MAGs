nano atlas.sh

#!/bin/bash
#PBS -l nodes=1:ppn=8
#PBS -l walltime=120:00:00
#PBS -q long
#PBS -o /nlustre/users/tiffdp/stdout.log
#PBS -e /nlustre/users/tiffdp/stderr.log
#PBS -k oe
#PBS -m ae
#PBS -M 17duplti@gmail.com

module load metagenome-atlas
source /apps/miniconda3/etc/profile.d/cond/sh
conda activate atlasenv

atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads

atlas run qc –-keep-going

qsub atlas.sh
