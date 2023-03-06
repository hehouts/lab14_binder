---
title: "Generating Data: Intro to Unix"
author: "Hannah E. Houts"
date: "2023-03-06"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---


## Learning Goals
*At the end of this exercise, you will be able to:* 

1. Change directory and list files in directory
2. Understand basic shell vocabulary
3. Gain exposure to the syntax of shell & shell scripting
4. Look at help menus
5. Look at the contents of a directory
6. Download a file from the internet with `curl`

commands: `pwd`, `ls`, `cd`, `curl`, `cat`, `cp`, `mv`, `rm`, `mkdir`, `rmdir`


## Resources
This lesson was adapted from the following resources:

- [Data Carpentries: Introduction to the Command Line for Genomics](https://datacarpentry.org/shell-genomics/)

- [DIB Lab: Advanced Beginner Shell](https://dib-training.readthedocs.io/en/pub/2016-01-13-adv-beg-shell.html)

- [ggg298 lab2: UNIX_for_file_manipulation](https://github.com/ngs-docs/2021-GGG298/tree/latest/Week2-UNIX_for_file_manipulation)


## Getting started in binder!

Click on the "launch binder" link at the bottom of [this page] (https://github.com/hehouts/lab14_binder). This runs RStudio in a ["binder"](https://binder.readthedocs.io/en/latest/user-manual/overview/intro.html), which means we can all use a unix OS terminal, regardless of what computer you're on!

Wait ~1-3 minutes. You should see an RStudio Server window ...sooner or later!


## What is the shell and what is the terminal?
The **shell** is a computer program that uses a command line interface (CLI) to give commands made by your keyboard to your operating system. Most people are used to interacting with a graphic user interface (GUI), where you can use a combination of your mouse and keyboard to carry out commands on your computer. We can use the shell through a **terminal** program. 

Everything we can do using our computer GUI, we can do in the shell. We can open programs, run analyses, create documents, delete files and create folders. We should note that _folders_ are called **directories** at the command line. For all intents and purposes they can be used interchangeably but if you'd like more information please see "The folder metaphor" section of [Wikipedia](https://en.wikipedia.org/wiki/Directory_%28computing%29#Folder_metaphor).

The ease of getting things done via the shell will increase with your exposure to the program.  

## Terminal Introduction
Once your binder has launched, there will be an rStudio interface. 

Go click on the terminal tab to get started. 

When we open up terminal in binder we will see a a line of text. This is a **prompt statement**. It can tell us useful things such as the name of the directory we are currently in, our username, or what computer we are currently running terminal on. However, the prompt statement that pops up in binder is quite long and distracting. Let's customize it to read `$ ` it by running:

```
PS1='$ '

```

we can clear that code from our screen with 

```
clear
```

Let's take a look around. First, we can use the **print working directory** command see what directory we are currently located in.

```
pwd
```

This gives us the **absolute path** to the directory where we are located. An absolute path shows the complete series of directories you need to locate either a directory or a file starting from the root directory of your computer.


We can also look at the contents of the directory by using the `ls` command:

```
ls
```

This command prints out a list of files and directories that are located in our current working directory. 

Now, if we look at the contents of our current directory we have a few files, and a folder called `hannahs_unix_cafe`,

To switch the directory we are located in, we need to change directories using the `cd` command. Let's move into the `hannahs_unix_cafe` directory. 

```
cd hannahs_unix_cafe
```

Let's have a look around.

```
ls
```
(ls stands for list. I remember it with `list stuff`)

However, this directory contains more than the eye can see! To show hidden files we can use the `-a` option.

```
ls -a
```

What did you find? discuss with your neighbor.



Using options with our commands allows us to do a lot! But how did we know to add `-a` after ls? Most commands offer a `--help`. Let's look at the available options that `ls` has:

```
ls --help
```

Here we see a long list of options. Each option will allow us to do something different.


##### Practice:
Find the date `unix_cafe.txt` was created with `ls -l`



We can also combine commands:

```
ls -lah
```

This combination of options will _list_ _all_ the contents of the directory, in _"long form"_ and display file sizes in _human readable_ units between files types. 

(what does  human readable units mean? compare `ls -lah` to `ls -la`)






## Navigation
  Now we have a fairly good concept of navigating around our computers and seeing what is located in the directory we are. But some of the beauty of the shell is that we can execute activities in locations that we are not currently in. To do this we can either use an absolute path or a relative path. A **relative path** is the path to another directory from the the one you are currently in. 

check out the  `hannahs_unix_cafe` directory

```
ls
```

Here we see several directories and text files. We can see what is in the text file using the `cat` command which concatenates and prints the content of the file we list. 

```
cat unix_cafe.txt
```

we can reference files by relative path too:
```
cat staff/cooks.txt
```

```
cat staff/waiters.txt 
```

Lets navigate into the `menu` directory

```
cd menu
```
and look at its contents:
```
ls 
```

We can see the contents of hours, and staff too:

```
ls ../staff
ls ../hours
```

So, even though we are in the `menu/` directory, we can see what is in other directories by using the relative path to the directory of interest. Note we can also use absolute paths too. You may have noticed the `../` this is how to get to the directory above the one you are currently located in. 

This .. feature can be used to help us navigate directories. move back up, out of the menu folder with 
```
cd ..
```

Note: in this case, we have access to the RStudio file browser, too, which is really nice. But in some situations, like if you are using a remote high performance compute cluster (hpc), you'll have to get by with just the command line interface and no other interface!

Wouldn't it be nice to see the contents of multiple directories at once? We can use a regular expression to capture a sequence of characters (like the numbers 1, 2 and 3 at the end of the tmp directories). We can use the wild card character `*`, which expands to match any amount of characters.

```
ls menu
```

```
ls menu/fall*
```

```
ls menu *
```

We are quite used to moving, copying and deleting files using a GUI. All of these functions can be carried out at the command line with the following commands: 

Copy files with the `cp` command by specifying a file to copy and the location of the copied file. 

```
cd menu
ls menu
```

```
cd fall
ls fall
```

```
cp fall_lunch.txt fall_dinner.txt
ls
```

The syntax for the copy command is `cp <source_file> <destination_file>`. Using this syntax we can copy files to other directories as well:

```
cp year_round_offerings.txt ../spring
```

If we navigate to the spring directory and list the files that are in it we will see the `year_round_offerings.txt` file has been copied to the `spring/` directory.

```
cd ../spring
ls -l
```

#### Practice:

1. use that `cat` function! check out the contents of `fall_festival_specials.txt`, and 2 more menus.


2. from the `spring/` directory, copy the spring lunch menu to a spring dinner menu

3. Super Challenge: A menu was misplaced! Given that the syntax for copy is the same as the syntax for move, use the `mv` (move) command to move the `fall_desserts.txt` file from `spring/` to `fall/`.


## Copy, move, remove
Once we know how to copy and move files, we can also copy and move directories. We can create new directories with the command `mkdir`. Let's make a new directory called `winter`

```
cd ~/hannahs_unix_cafe/menu
mkdir summer
ls -l
```

The shell is quite powerful and can create multiple directories at once. It can create multiple in the current working directory:

```
mkdir winter take-out
ls -l
```

or it can create a series of directories on top of one another:

```
cd ..
mkdir -p company_secrets/lie/deep/within/the/caverns/of/unix/
```

We can use tab complete to get to the `go` directory. Type `cd h` then hit `tab`. If you hit tab enough times your command will eventually read:

```
cd company_secrets/lie/deep/within/the/caverns/of/unix/
```

You can see that we've created a bit of a monster directory structure...

This nicely hints at the power of the shell - you can do certain things (in this case, create a nested hierarchy of directories) much more easily in the shell. But that power cuts both ways - you can also mess things up more easily in the shell!


Now lets talk about deleting things:
```
cd ~/hannahs_unix_cafe
```

delete a file with the `rm` command:
```
rm health_report_2023.txt
```

you can delete files with their relative path too:

```
rm  hours/holiday_hours/summer_hours.txt 
```

you can delete an empty directory with `rmdir`:
```
rmdir menu/summer
```


## Tutorial time: CLI tools


This whole quarter, we have focused on what to do with data once we have it. 
That is no small feat, and is a literal entire (booming!) career path (see: data scientist). Though R is often used for analyzing biological data, many software tools are run with what is called a command line interface, or CLI. Everything we've covered today has been working "on the command line"


Here, Im throwing a lot at you, and the goal is simply for you to see the power of CLI tools, not for you to be an expert genomicist by 5 o'clock!
```
mkdir ~/data
cd ~/data
```
We are using `curl`, a command that downloads files from a web url.
This is downloading the genome of an ecoli sample, and the reference genome for ecoli. Your can think of this as the difference between your genome, and the "human genome"
```
curl -L https://osf.io/ruanf/download -o ecoliMG1655_REFERENCE_GENOME.fa.gz
curl -L https://osf.io/q472x/download -o ecoli_ref_SAMPLE_5m.fastq.gz
```

run
```
ls -lh 
```
and we see that these files are pretty big, and they're zipped. BUT we can use "zcat" to see them


```
zcat ecoliMG1655_REFERENCE_GENOME.fa.gz
```
ahh!!!! escape with ctrl-c

now try
```
zcat ecoliMG1655_REFERENCE_GENOME.fa.gz  | head
```
look! some base pairs!



Sourmash is a software developed in my lab, that has a CLI (command line interface). It analyzes genomes, can can create output that we could visualize in R.
It is installed in this binder instance.
```
mkdir ~/sourmash
cd ~/sourmash
```

makes compressed representation of genomes (thanks to the magic of kmers, this only takes ~30 seconds).
```
sourmash sketch dna -p scaled=10000,k=31 ~/data/ecoli_ref*.fastq.gz -o ecoli-sample.sig

sourmash sketch dna -p scaled=1000,k=31 ~/data/ecoliMG1655_REFERENCE_GENOME.fa.gz -o ecoli-genome.sig
```



compares them:
```
sourmash search ecoli-sample.sig ecoli-genome.sig --containment

```
this shows us that our sample and our reference genome are only about 31% similar 

lets try this with more reference ecoli genomes. this will give us more that 1 comparison, so we will save our output in a csv file
```
mkdir ~/sourmash/ecoli_many_sigs
cd ~/sourmash/ecoli_many_sigs
curl -O -L https://github.com/sourmash-bio/sourmash/raw/latest/data/eschericia-sigs.tar.gz
tar xzf eschericia-sigs.tar.gz
rm eschericia-sigs.tar.gz

cd ~/sourmash/
sourmash index ecolidb ecoli_many_sigs/*.sig
sourmash search ecoli-genome.sig ecolidb.sbt.zip -n 20 -o ecoli_compare_table.csv
sourmash compare ecoli_many_sigs/*.sig --csv ecoli.cmp.csv

```



Reminder: The point the lesson today is not for you to be able to make sense of this output. The point is four you to understand that there are softwares that you might want to use, that require the use of a CLI (command line interface). May of these tools can output a table that we can use in R!


Now we export our csv from the binder: 
check the box of the `ecoli.cmp.csv` and the `ecoli_compare_table.csv`, click settings, and select export. This will download to your downloads folder, and then you can drag it into your lab_14 folder. 

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
## ✔ ggplot2 3.4.0      ✔ purrr   1.0.0 
## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
## ✔ tidyr   1.2.1      ✔ stringr 1.5.0 
## ✔ readr   2.1.3      ✔ forcats 0.5.2 
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```


```r
compare_table <- read_csv("ecoli_compare_table.csv")

compare_table %>% 
  ggplot(aes(x = name, y = ani))+
  geom_col()
```

Lets be clear... this is an ugly plot. Here is a neat way to visualize 3 dimensional data: a heatmap


```r
sourmash_comp_matrix <- read.csv("ecoli.cmp.csv")

# Label the rows
rownames(sourmash_comp_matrix) <- colnames(sourmash_comp_matrix)

# Transform for plotting
sourmash_comp_matrix <- as.matrix(sourmash_comp_matrix)

sourmash_comp_table <- read_csv("ecoli.cmp.csv")
sourmash_comp_table_dot <- read_csv("ecoli.cmp.csv")
```

### Make an unclustered heatmap

```r
heatmap(sourmash_comp_matrix, Colv=F, scale='none')
```


With some statistics research, we can figure our other ways to represent our data:
### Make an MDS plot


```r
fit <- dist(sourmash_comp_matrix)
fit <- cmdscale(fit)
x <- fit[, 1]
y <- fit[, 2]
plot(fit[ , 1], fit[ , 2], xlab = "Dimension 1", ylab = "Dimension 2")
```

### Make a tSNE plot

```r
library(Rtsne)
tsne_model <- Rtsne(sourmash_comp_matrix, check_duplicates=FALSE, pca=TRUE, perplexity=5, theta=0.5, dims=2)
d_tsne = as.data.frame(tsne_model$Y) 
plot(d_tsne$V1, d_tsne$V2)
```



