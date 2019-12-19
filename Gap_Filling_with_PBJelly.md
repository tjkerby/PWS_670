# Gap Filling with PBJelly
Hi-C does a good job of putting scaffolds together, but it does not estimate the size of any gaps between scaffolds. We filled in gaps in our scaffolded assembly using our original PacBio reads via PBJelly. PBJelly uses long reads to completely or partially fill in gaps, thus reducing the number of Ns and the average gap length in your assembly.

# Protocol File

First, you need a to set up a Protocol.xml file that contains information for PBJelly to run. Here is the code for our Protocol.xml:
   
    <jellyProtocol> 
              
    <reference>path_to_SALSA_scaffolds_output_directory/scaffolds_FINAL.fasta</reference>
    <outputDir>output_directory</outputDir>
    <blasr>-minMatch 8 -minPctIdentity 75 -bestn 1 -nCandidates 20 -maxScore -500 -nproc 16 -noSplitSubreads</blasr>
    <input baseDir="PacBio_reads_directory">
    <job>PacBio_reads.fastq</job>
    </input>
    </jellyProtocol>
    
    #you do not need to add bash headers to this file
    #The -nproc option should match the number of threads you give in your bash header. 
    #use a fastq file for your reads, or use a fasta file with a qual file in the same directory. See the Preprocessing section of the the PBJelly documentation for more information on this.
   
   If you would like to learn more about the blasr options, use 'blasr --help' to read the documentation for this program.
   
 # Run PBJelly
 
 You need to run several steps in PBJelly: setup, mapping, support, extraction, assembly, and output. This is the code we used to automate running these steps:
       
       module purge 
       module load python/2.7
       module load blasr
       module load samtools
       module load pbsuite/15.8.24 

       Jelly.py setup Protocol.xml \
       && Jelly.py mapping Protocol.xml \
       && Jelly.py support Protocol.xml -x "--spanOnly --capturedOnly" \
       && Jelly.py extraction Protocol.xml \
       && Jelly.py assembly Protocol.xml -x “--nproc=16” \
       && Jelly.py output Protocol.xml -x "-m 2" 
       
       #--nproc option should match the number of threads you give in your bash header
    
   To learn more about different options that can be run for each step, use 'Jelly.py <step> --help' on the command line.
  
   This script will create an ouput directory with several subdirectories. You can run assemblathon-stats on the jelly.out.fasta file and your reference to compare the number of Ns and the size of the gaps before and after gap filling with PBJelly.


# Resources
PBJelly - https://sourceforge.net/p/pb-jelly/wiki/Home/
