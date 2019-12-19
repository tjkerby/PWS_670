#!/bin/bash

#SBATCH --time=01:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --mem-per-cpu=2G   # memory per CPU core

fasta=pilon.hisat.sorted.stringtie.gtf.fasta

module purge
module load conda-pws
module load emboss

#you can change the size of the filter by changing the "1000" to another size.

sizeseq -sequences ${fasta} -descending -outseq ordered_${fasta} && bioawk -c fastx '{ if(length($seq) > 1000) { print ">"$name; print $seq }}' ordered_${fasta} > ordered_filtered_${fasta}
~                                                                   
