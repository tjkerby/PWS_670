# Visualizing Hi-C Scaffolds in Juicebox

In order to visualize your Hi-C scaffolds in Juicebox, you need to run convert.sh. This script needs a .jar file that is part of Juicertools.  

# The .jar File

The .jar file is on the PWS module here: /panfs/pan.fsl.byu.edu/home/grp/fslg_pws_module/software/SALSA/juicer_tools_1.13.02.jar. 

You can also download it from here: https://github.com/aidenlab/juicer/wiki/Download

# convert.sh

The script for convert.sh can be found here: https://github.com/marbl/SALSA/blob/master/convert.sh . Make sure you change the JUICER_JAR variable to the location of your .jar file.

Run convert.sh from the command line like this:

        convert.sh <scaffolds>
        
Where scaffolds is the output directory you specified in SALSA.
       
# Juicebox

This will create a salsa_scaffolds.hic file in the scaffolds directory. Pull this file down to your local machine to visualize in in Juicebox. ADD HOW TO DOWNLOAD JUICEBOX.

