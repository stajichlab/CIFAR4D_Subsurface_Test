#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 1 -c 8 --mem 24gb --out amptk.%A.log

CPU=8
module load amptk
PREFIX=SSF_test1

amptk illumina -i input --rev_primer ITS2 --fwd_primer ITS1-F --rescue_forward on --require_primer off --cpus $CPU -o $PREFIX

amptk cluster -i $PREFIX.demux.fq.gz -o $PREFIX
amptk filter -c all -i $PREFIX.otu_table.txt -f $PREFIX.cluster.otus.fa

amptk lulu -i $PREFIX.final.txt -f $PREFIX.filtered.otus.fa -o $PREFIX

amptk taxonomy -f $PREFIX.lulu.otus.fa -i $PREFIX.lulu.otu_table.txt -m $PREFIX.mapping_file.txt -d ITS1 -o $PREFIX

