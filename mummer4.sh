#!/bin/bash

#SBATCH --time=3-00:00:00   # walltime
#SBATCH --ntasks=16   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=32768M   # memory per CPU core
#SBATCH -J "nucmer_mummerplot"   # job name
#SBATCH --mail-user={email address}   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module purge
module load gnuplot/4/6
module load conda-pws
module load mummer_4.0.0beta

#There is a bug with making the --png.  This script will run, but not produce the png.  To make the png you need to "module load gnuplot/4/6" then gnuplot prefix.gp 
Reference=/path/to/reference.fasta #complete path to the reference
Query=/path/to/query.fasta #complete path to the query
Prefix=Reference_V_query_C500 #file prefixes.  You can vary the -c argument -here I’ve set it to 500- to get difference plots, review this in the manual for a better explanation.

nucmer --threads 16 --mum -c 500 -p ${Prefix} ${Reference} ${Query} && mummerplot -s large --png --color --filter --layout -p ${Prefix} ${Prefix}.delta
