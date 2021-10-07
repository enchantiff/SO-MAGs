cd $PBS_O_WORKDIR

module load DRAM
source /apps/anaconda3-2020.02/etc/profile.d/conda.sh
conda activate DRAM

DRAM.py annotate -i '*.fa' -o annotation
DRAM.py distill -i annotation/annotations.tsv -o genome_summaries --trna_path annotation/trnas.tsv --rrna_path annotation/rrnas.tsv
