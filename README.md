# SO-MAGs
Scripts used to generate Metagenome-Assembled Genomes from the Southern Ocean, see flow diagram below:

![Untitled](https://user-images.githubusercontent.com/84008482/136346041-0652c7c6-72dc-4a9d-aec3-2c24ee4f41fd.png)

> While we assembled and binned each sample step-by-step, ATLAS (Kieser et al., 2020) ran on all the samples.

'''module load metagenome-atlas
source /apps/miniconda3/etc/profile.d/cond/sh
conda activate atlasenv

atlas init –db-dir databases /nlustre/users/tiffdp/SCALE-META-reads/atlas/ --working-dir /nlustre/users/tiffdp/SCALE-META-reads/atlas/SCALE-META-reads

atlas run qc assembly binning --resources mem=250 --jobs 20 –-keep-going
