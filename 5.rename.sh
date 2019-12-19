#!/bin/bash

#SBATCH -c 1 --mem=1gb -t 0:60:00

module purge
module load conda-pws
module load maker_v2.31.10

#this is set of commands is changing the IDs of the genes, transcripts, and proteins to something more manageable (--prefix).  In this case the AT just stands for A. thalinana.  

maker_map_ids --prefix AT --justify 6 Final_allscaffolds.gff > Final_allscaffolds.map && map_gff_ids Final_allscaffolds.map Final_allscaffolds.gff && map_fasta_ids Final_allscaffolds.map Final_allscaffolds.all.maker.proteins.fasta && map_fasta_ids Final_allscaffolds.map Final_allscaffolds.all.maker.transcripts.fasta

