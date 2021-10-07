module load metagenome-atlas
source /apps/miniconda3/etc/profile.d/cond/sh
conda activate atlasenv

atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads/atlas/ --working-dir /nlustre/users/tiffdp/SCALE-META-reads/atlas/SCALE-META-reads

atlas run qc assembly binning --resources mem=250 --jobs 20 –-keep-going
