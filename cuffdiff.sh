#!/bin/bash

#SBATCH --time=08:00:00   # walltime
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4G   # memory per CPU core
#SBATCH -J "cuffdiff"   # job name

module purge
module load cufflinks


cuffdiff -o ./cuffdiff_out -b ../maker/jelly.out.pilon.fasta.fa -p 8 -L 24h,1h -u merged_transcripts1.gtf heat_24h_rep1_ref2_annotation.bam.sort.gtf,heat_24h_rep2_ref2_annotation.bam.sort.gtf heat_1h_rep1_ref2_annotation.bam.sort.gtf,heat_1h_rep2_ref2_annotation.bam.sort.gtf 
