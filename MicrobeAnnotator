module load prodigal-2.6.3

for items in *fa; do prodigal -i $items -a $items\.proteins.faa -p meta; done

cd $PBS_O_WORKDIR

module load anaconda3-2021.05
source activate microbeannotator

microbeannotator -i $(ls *.faa) -d /nlustre/data/MicrobeAnnotator_DB -o microbean -m blast -p 2 -t 12
