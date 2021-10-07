module load metagenome-atlas
source /apps/miniconda3/etc/profile.d/cond/sh
conda activate atlasenv

atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads

atlas run qc –-keep-going
