Contents:
* man, -h, --help
* viewing data
* rm, cp, mv, mkdir, pwd, history
* grep
* sed
* awk
* cut
* sort, uniq
* submitting jobs on slurm
* how to write a file in a script
* how to use pipes
* how to use vi
* for loops
* how to edit your bash_profile

##### BASIC COMMANDS #####

If you don't know how to use a command you can put man before the command or put -h or --help after the command to get help on using it.

ls is a way to show the contents of the directory that you are currently in. Some flags that are especially useful are:
-a shows hidden files that begin with a "."
-h if accompanied by -l it prints the file sizes in a human readable format
-l gives the long listing format and gives more information for each file/folder
-r reverses the order while sorting
-t sorts files by modification time where the newest one is listed first

less filename
This prints to the screen the contents of the file. Pressing space will move down a screen while pressing enter moves down a line.
To exit the viewer press q. When you do so the contents of the file will be removed from the terminal viewer.

more filename
This does the exact same thing as less except that more retains the contents in the terminal viewer even after you exit. 

cat filename
prints the contents of the file to the screen to the terminal viewer. This can be used in conjunction with > to redirect the input into a 
new file.

rm [OPTION]... FILE...
This command is used to remove a file/folder. If removing a folder and its contents be sure to add -r. This will delete the folder's files
and then goes into the folders in that folder and repeats that step and then removes the empty folder. Be careful with this command since 
you cannot recover the files/folders after running the command.

cp [OPTION]... SOURCE... DIRECTORY
This copies either a file or a folder which is referred to as the SOURCE and copies it to the DIRECTORY.
-r allows you to copy a folder and all of its contents.

mv [OPTION]... SOURCE... DIRECTORY
This moves a file or a folder to a new location. This command can also be used to rename a file if the location of the SOURCE and the 
DIRECTORY are the same.

mkdir [OPTION]... DIRECTORY...
This commands creates a new director(y/ies) in the current directory.

pwd [OPTION]...
This command prints the name of current/working directory. If you add -P it will print the full path, avoiding all symlinks.

history
This command will print out a history of the commands you have run in the terminal. This can be very powerful if piping to grep.

##### GREP #####

grep [OPTION]... PATTERN [FILE]...
grep searches for a pattern in a list of files. Some important flags are:
-c print only a count of matching lines per FILE
-i ignores case
example: grep "contig_1" genome.gff

##### SED #####

sed [OPTION]... 's/{find_pattern}/{replace_pattern}/' [input-file]...
sed is used to find a pattern of text in a list of input files and then replace that pattern with a new pattern. If the pattern you desire 
to replace is found multiple times in a line you can put a g at the end of 's/{find_pattern}/{replace_pattern}/g'. The flag -i replaces
the file with the output of the command.
example: sed -i 's/_pilon//g' m4f30.hapmap.headers.txt

##### AWK #####
awk [POSIX or GNU style options] [--] 'program' file ...
This takes a script that is wrapped in '' and then executes it using the 'program' file as input. 
example: awk '{if (($3 == "exon") || ($3 == "gene")) print $3}' Arabidopsis_RNAseq.stringtie.gtf
The example means that if collumn 3 in the file Arabidopsis_RNAseq.stringtie.gtf is "exon" or "gene" it will print it to the screen.
awk is used for filtering data, doing manipulations, or a host of other things. It is a very powerful tool.

##### CUT #####
cut OPTION... [FILE]...
Cut prints selected parts of lines from each FILE to standard output. 
-f is used to limit it to a certain collumn.
example: cut -f 9 Arabidopsis_RNAseq.stringtie.gtf

##### SUBMITTING JOBS ON SLURM #####

sbatch [OPTIONS...] executable [args...]
There is an automatic script generator available at https://rc.byu.edu/documentation/slurm/script-generator that can help you put the 
correct headers in the file for requesting resources. Here is an example header:
#!/bin/bash

#SBATCH --time=01:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=16G   # memory per CPU core
#SBATCH -J "job_ID"   # job name
#SBATCH --mail-user=user@mail.com   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

example: sbatch script.sh

##### HOW TO DO A BASH SCRIPT #####

sh [GNU long option] [option] script-file ...
This runs a shell script that runs on your current machine. Because this is running on the current machine you don't need to specify the
amount of resources that you will be using, but you do need to add this on the top of the file that you are running:
#!/bin/sh
This can often be used with a for loop to make several job scripts and then send them off.
example: sh script.sh

##### HOW TO WRITE A FILE IN A SCRIPT #####

You can generate a new file by running a script with the following structure: 
File_name <<EOF
{
put what ever content you want in here
}
EOF
After running this a new file named File_name was generate with the content between the EOFs.

##### HOW TO USE PIPES #####

Sometimes you don't want to use just one command, but a series of commands chained together. You can do this by "piping" commands together
with the "|" character. 
example: history | grep "awk"
This example runs the history commands and takes its output as the input to the grep command. This command will search through your history
for any command that contains "awk". 

##### HOW TO USE VI #####

There are many different text editors. One of them is vi. You can use vi to make new files or edit existing files. To make a new file
you simply do vi and then put the name of the file you want to create. To edit an existing file you do the same except you put the name 
of the file instead of a new name. After running the command the editor will open displaying the file. 
  * To edit the file type "i". This should change the bottom to say "insert" and now when you type you are editing the file. 
  * To save your work you can press "esc" and then type "w:" and press enter.
  * To exit the text editor, press "esc" and then type "q:" and press enter.
You can combine the last two step and save and exit at the same time by simply typing "wq:" and pressing enter.

##### BASICS OF FOR LOOPS #####

A for loop is a loop that executes certain lines of code a certain number of times. Here is a basic example to demonstrate.
for i in 1 2 3; do  echo $i; done
The following code will print out:
1
2
3
This can be used to do something for every .fasta file you have in a folder.
example: for input_file in *.fasta; do sh modify_input.sh $i; done
This will execute the shell script with every fasta file in the directory as input.

##### HOW TO EDIT YOUR BASH_PROFILE #####

When you first log on to ubuntu or ssh into the supercomputer if you do ls -a you will see a file called .bash_profile
If you open this file in vi you can add aliases or shortcuts. 
example: alias home="cd; cd ../../mnt/c/Users/username; lk"
Now when I type home it will take me to the directory specified. I can also increase how many files my history will store by adding:
export HISTTIMEFORMAT="%h %d %H:%M:S "
export HISTSIZE=10000
export HISTFILESIZE=10000

For fun you can have a personal message be sent to the screen everytime you log on by adding the following:
echo "Welcome, <insert your name>"












