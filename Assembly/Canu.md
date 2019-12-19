# PWS_670

Canu

Canu is a sequence assembly pipeline which runs in four steps:
-	Detects overlaps using MinHash Alignment Process (MHAP)
-	Generates corrected sequence consensus
-	Trims corrected sequences
-	Assemble trimmed corrected sequences 

usage:   canu [-version] [-citation] \
[-correct | -trim | -assemble | -trim-assemble] \
[-s <assembly-specifications-file>] \
-p <assembly-prefix> \
-d <assembly-directory> \
genomeSize=<number>[g|m|k] \
[other-options] \
[-pacbio-raw |
-pacbio-corrected |
-nanopore-raw |
-nanopore-corrected] file1 file2 ...

example: canu -d run1 -p godzilla genomeSize=1g -nanopore-raw reads/*.fasta.gz


To restrict canu to only a specific stage, use:
-correct       - generate corrected reads
-trim          - generate trimmed reads
-assemble      - generate an assembly
-trim-assemble - generate trimmed reads and then assemble them

The assembly is computed in the -d <assembly-directory>, with output files named
using the -p <assembly-prefix>.  This directory is created if needed.  It is not
possible to run multiple assemblies in the same directory.

The genome size should be your best guess of the haploid genome size of what is being
assembled.  It is used primarily to estimate coverage in reads, NOT as the desired
assembly size.  Fractional values are allowed: '4.7m' equals '4700k' equals '4700000'

Some common options:
useGrid=string
- Run under grid control (true), locally (false), or set up for grid control
but don't submit any jobs (remote)
rawErrorRate=fraction-error
- The allowed difference in an overlap between two raw uncorrected reads.  For lower
quality reads, use a higher number.  The defaults are 0.300 for PacBio reads and
0.500 for Nanopore reads.
correctedErrorRate=fraction-error
- The allowed difference in an overlap between two corrected reads.  Assemblies of
low coverage or data with biological differences will benefit from a slight increase
in this.  Defaults are 0.045 for PacBio reads and 0.144 for Nanopore reads.
gridOptions=string
- Pass string to the command used to submit jobs to the grid.  Can be used to set
maximum run time limits.  Should NOT be used to set memory limits; Canu will do
that for you.
minReadLength=number
- Ignore reads shorter than 'number' bases long.  Default: 1000.
minOverlapLength=number
- Ignore read-to-read overlaps shorter than 'number' bases long.  Default: 500.
A full list of options can be printed with '-options'.  All options can be supplied in
an optional sepc file with the -s option.

Reads can be either FASTA or FASTQ format, uncompressed, or compressed with gz, bz2 or xz.
Reads are specified by the technology they were generated with, and any processing performed:
-pacbio-raw         <files>      Reads are straight off the machine.
-pacbio-corrected   <files>      Reads have been corrected.
-nanopore-raw       <files>
-nanopore-corrected <files>

Complete documentation at http://canu.readthedocs.org/en/latest/

Two ways to access assemblathon2-analysis program:
1.	git clone https://github.com/marbl/canu.git
2.	- Access fulton supercomputing lab; load module with following commands ‘module load conda-pws’ and ‘module load canu_v1.8

Canu Scripts Used

#!/bin/bash

module purge
module load conda-pws
module load canu_v1.8
module load gnuplot/5.2

canu -d [assembly directory] -p [output prefix] genomeSize= [estimate genome size] maxThreads=16 corMhapSensitivity=normal corOutCoverage=40 \
merylThreads=16 ovlThreads=16 obtovlMemory=4g \
gridOptions="--time=72:00:00" \
gridOptionsOVS="--mem-per-cpu=32g --time=71:05:00" \
gridOptionsExecutive="--mem-per-cpu=32g --time=71:50:00" \
gridOptionsCORMHAP="--mem-per-cpu=10g --time=71:45:00" \
gridOptionsOBTMHAP="--mem-per-cpu=10g --time=71:40:00" \
gridOptionsUTGMHAP="--mem-per-cpu=10g --time=71:35:00" \
gridOptionsCOROVL="--mem-per-cpu=10g --time=71:30:00" \
gridOptionsOBTOVL="--mem-per-cpu=5g --cpus-per-task=16 --time=168:00:00" \
gridOptionsUTGOVL="--mem-per-cpu=6g --time=71:25:00" \
gridOptionsRED="--mem-per-cpu=12g --time=71:20:00" \
gridOptionsOEA="--mem-per-cpu=12g --time=71:10:00" \
gridOptionsOVB="--mem-per-cpu=24g --time=71:00:00" \
gridOptionsCNS="--mem-per-cpu=12g --time=72:00:00" \
-pacbio-raw [input raw pacbio read file]
