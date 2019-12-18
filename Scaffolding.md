# Scaffolding with Hi-C Reads
We scaffolded our assembly using Hi-C technology.  Watch this video from Phase Genomics if you don't remember how Hi-C works: https://youtu.be/-MxEw3IXUWU. Salsa is the program that uses the Hi-C reads to create the scaffolds. The scaffolds can then be visualized and improved in Juicebox.

# SALSA 
SALSA needs 3 input files: an assembly file in fasta format, a .fai file with the lengths of the contigs, and a .bed file of Hi-C reads mapped to the assembly. 
  
  Assembly File: This is an assembly made from DNA reads.  You should have created it with an assembler, like CANU.
  .fai file: This file contains the lengths of the contigs.  Create this file by running samtools faidx on your assembly fasta file. This is the script we used:
        
      module purge
      module load samtools

      samtools faidx assembly_file.fasta
  
  .bed file of mapped Hi-C reads: This file contains the alignments of your Hi-C reads (aligned to your assembly). To create this file, you need to map your Hi-C reads, convert the sam files to bam files. Then, convert these to bed files and sort them by read name.
  
   Code for mapping the Hi-C reads: 
    
      bwa mem -t 16 -M <assembly_file.fasta> <Hi-C_forward_reads.fastq> <Hi-C_reverse_reads.fastq> > <mapped_reads.sam>
   
   Code for converting .sam to .bam file:
   
      module purge
      module load samtools

      samtools view -S -b <mapped_reads.sam> > <mapped_reads.bam>
   
   Code for converting .bam file to .bed file:
      
      module purge
      module load bedtools

      bedtools bamtobed -i <mapped_reads.bam> > <mapped_reads.bed>
      
   Code for sorting .bed file by read name:
   
      sort -k4 <mapped_reads.bed> > <mapped_reads.sort.bed>
    
      
      
Now you can run SALSA. Here is the code:

      module purge    
      module load python/2.7
      module load boost/1.65
      module load salsa

      run_pipeline.py -a <assembly_file.fasta> -l <indexed_assembly_file.fai> -b <mapped_reads.sort.bed> -e GATC -o <output_directory>
      
      # -e is the sequence of the restriction site for your restriction enzyme used to make the Hi-C reads. Make sure this is correct.
   
   The output directory you specified should end up with many files in it. Ours had 56.
   
# Resources
  SALSA - https://github.com/marbl/SALSA
  Samtools faidx - http://www.htslib.org/doc/faidx.5.html; http://www.htslib.org/doc/samtools-faidx.1.html
