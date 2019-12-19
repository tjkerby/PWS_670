#!/bin/bash

#SBATCH -c 1 --mem=1gb -t 0:60:00

module purge 
module load conda-pws
module load maker_v2.31.10

#run this after you've run 3.merge.sh.  This script will merge all the clustered sequences (gff, protein, and transcript) together.

gff3_merge -o Final_allscaffolds.gff *.gff  

cat *.all.maker.proteins.fasta > Final_allscaffolds.all.maker.proteins.fasta

cat *.all.maker.transcripts.fasta  > Final_allscaffolds.all.maker.transcripts.fasta
