# hisat2

The first steps to gene annotation includes trimming and mapping your RNA-seq reads and then converting them into a sorted bam file. You will use trimmomatic and trim and samtools to convert to a sorted bam file as usual, but for mapping, we will use hisat2 version 2.1. First you will need to index your reference genome or sequence using the hisat2-build command like so:

    module purge
    module load hisat2/2.1

    hisat2-build <reference.fasta> <basename>
This will build .X.ht2 index files with the prefix of whatever you put as the basename.

After you trimmed your RNA-seq reads with Trimmomatic SE (refer to Trimming.md for more information) you will use hisat2 again to map your reads to the reference. This is done with the following commands:

    module purge
    module load hisat2/2.1

    hisat2 -x <index_filename_prefix> -U <unpaired_trimmed_reads>,<...> -S <output.sam>
    
You can put multiple files of unpaired reads as input by separating them with a comma and no whitespace. You can also name your output sam file to whatever suits you.

Next you will need to convert your sam file into a sorted bam file. Here are the commands to do so:

    module purge
    module load conda-pws
    module load samtools

    samtools view -Sb --threads 4 <output.sam> > <output.bam> &&  samtools sort --threads 4 -o <output.sorted.bam> <output.bam>



# Stringtie 
Stringtie will convert your sorted bam files into assembled transcripts in .gtf file format that can be used further down the gene annotation pipeline.

    module purge
    module load conda-pws
    module load stringtie_1.3.4

    stringtie <output.sorted.bam> -o <RNA_transcript.gtf>   



# gffread 
convert gff or gtf files into fasta files 

    gffread -w <transcript.fasta> -g <reference.fasta> <RNA_transcript.gtf>

# MAKER 

MAKER is a genome annotation pipeline that requires multiple steps in order to annotate a genome you may have. Refer to https://www.yandell-lab.org/software/maker.html for any additional information on the functions and possibilities of MAKER.

There are 8 scripts you will need to run in order to produce files with annotated genes and other functional data found in your genome or sequence input. The scripts are labeled sequentially starting at 0 and ending with 7 in the MAKER directory.

# BUSCO 
BUSCO assesses annotation completeness by measuring the number orthologs compared to what you would expect for any particular organism. The following commands will run BUSCO. Note that you can change parameters such as the mode (genome, proteins, or transcriptome) and the dataset you can use depending on your species and input data type.

    #Add full path to assembly
    assembly=<genome.fasta | transcript.fasta | protein.fasta>

    #Add output name
    output=output_file_genome | transcript | protein

    #Add species (rice or arabidopsis)
    species=arabidopsis

    #Add the mode (genome, proteins, transcriptome)
    m=protein

    #Add the dataset (plants: embryophyta_odb10; liliopsida_odb10; solanaceae_odb10; eudicotyledons_odb10; look them up on https://busco.ezlab.org/)
    l=~/fsl_groups/fslg_pws_module/software/.conda/envs/busco/datasets/embryophyta_odb10

    run_BUSCO.py -i ${assembly} -o ${output}_${species} -l ${l} -m ${m} -c 1 -sp ${species} -f
# Resources

hisat2 - https://ccb.jhu.edu/software/hisat2/manual.shtml

Stringtie - https://ccb.jhu.edu/software/stringtie/

gffread - http://ccb.jhu.edu/software/stringtie/gff.shtml

MAKER - https://www.yandell-lab.org/software/maker.html

BUSCO - https://busco-archive.ezlab.org/v1/files/BUSCO_userguide.pdf
