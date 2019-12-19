# Gap Filling with PBJelly
Hi-C does a good job of putting scaffolds together, but it does not estimate the size of any gaps between scaffolds. We filled in gaps in our scaffolded assembly using our original PacBio reads and PBJelly. PBJelly uses long reads to completely or partially fill in gaps, thus reducing the number of Ns and the average gap length in your assembly.

# PBJelly
  This is the code we used to run PBJelly:
       
       module purge 
       module load python/2.7
       module load blasr
       module load samtools
       module load pbsuite/15.8.24 

       Jelly.py setup Protocol.xml \
       && Jelly.py mapping Protocol.xml -x "-minReadLength l750"\
       && Jelly.py support Protocol.xml -x "--spanOnly --capturedOnly" \
       && Jelly.py extraction Protocol.xml \
       && Jelly.py assembly Protocol.xml -x “--nproc=16” \
       && Jelly.py output Protocol.xml -x "-m 2" 
      
   You need a Protoco.xml file that contains


# Resources
PBJelly - https://sourceforge.net/p/pb-jelly/wiki/Home/
