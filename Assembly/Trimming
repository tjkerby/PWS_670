Trimming is often a prerequisite to use other programs. Trimming takes fastq files as input and outputs trimmed fastq files. It essentially scans the quality of the reads and if the quality is ever below a specified threshold then it will cut them out. 

In order to run trimmomatic on the BYU super computer you need to load module conda-pws and then load module trimmomatic. 

Options to run in trimmomatic:

ILLUMINACLIP   - Perform adapter removal.
SLIDINGWINDOW	 - Perform sliding window trimming, cutting once the average quality within the window falls below a threshold.
LEADING	       - Cut bases off the start of a read, if below a threshold quality.
TRAILING	     - Cut bases off the end of a read, if below a threshold quality.
CROP	         - Cut the read to a specified length.
HEADCROP	     - Cut the specified number of bases from the start of the read.
MINLEN	       - Drop an entire read if it is below a specified length.
TOPHRED33	     - Convert quality scores to Phred-33.
TOPHRED64	     - Convert quality scores to Phred-64.

Depending on whether your reads are single ended or pair ended you will use trimmomatic SE or trimmomatic PE respectively. The two scripts below are listed below with that same order.

##### Single End Script #####

```
#!/bin/sh

#this is a shell script that you launch using:$ 'sh trimmomatic_single-end.sh'
#it will launch separate jobs for all of the *.fq.gz illumina files it finds in the file where it was launched.
#this is for SE (single end illumina) files.
#it is checking for all of the adapters in the following kits: NexteraPE-PE.fa  TruSeq2-PE.fa  TruSeq2-SE.fa  TruSeq3-PE -2.fa  TruSeq3-PE.fa  TruSeq3-SE.fa
#make sure you make a trim_scripts and a Trimmed_Reads folder in the folder you launch the script from.

for fastq_file in *.fq.gz
do
name=`echo $fastq_file | sed 's/.fq.gz//'`
cat > ./trim_scripts/${name}.sh <<EOF
#!/bin/bash

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=4   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4096M   # memory per CPU core
#SBATCH -J "trimmomatic"   # job name
#SBATCH --mail-user=username@byu.edu   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load trimmomatic

trimmomatic SE -threads 4 -summary ${name}_stats_trim.txt ${name}.fq.gz ./Trimmed_Reads/${name}_trimmed.fq.gz ILLUMINACLIP:/fslhome/pjm43/fsl_groups/fslg_pws_module/software/.conda/envs/trimmomatic/adapters/all_adaptor.fasta:2:30:10 LEADING:10 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:75
EOF

sbatch ./trim_scripts/${name}.sh

done
```

##### Paired End Script #####

```
#!/bin/sh

#this is a shell script that you launch using:$ 'sh trimmomatic_paired-end.sh'
#it will launch separate jobs for all pairs of  illumina files it finds in the file where it was launched - it does this by looking for a forward file of the pair, labeled _1.fq.gz (this could be changed) -the reverse file is _2.fq.gz.
#this is for PE (paried-end illumina) files.
#it is checking for all of the adapters in the following kits: NexteraPE-PE.fa  TruSeq2-PE.fa  TruSeq2-SE.fa  TruSeq3-PE -2.fa  TruSeq3-PE.fa  TruSeq3-SE.fa
#make sure you make a trim_scripts and a Trimmed_Reads folders in the folder you launch the script from.

mkdir ./trim_scripts
mkdir ./Trimmed_Reads

for forward_file in *_1.fq.gz
do
name=`echo $forward_file | sed 's/_1.fq.gz//'`
cat > ./trim_scripts/${name}.sh <<EOF
#!/bin/bash

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=4   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4096M   # memory per CPU core
#SBATCH -J "trimmomatic"   # job name
#SBATCH --mail-user=username@byu.edu   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load trimmomatic

trimmomatic PE -threads 4 -summary ${name}_stats_trim.txt ${name}_1.fq.gz ${name}_2.fq.gz -baseout ./Trimmed_Reads/${name}.fq.gz ILLUMINACLIP:/fslhome/pjm43/fsl_groups/fslg_pws_module/software/.conda/envs/trimmomatic/adapters/all_adaptor.fasta:2:40:15 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:75

EOF

sbatch ./trim_scripts/${name}.sh

done
```
