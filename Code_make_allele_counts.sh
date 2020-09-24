#!/bin/bash

#SBATCH -J Make_allele_frequencies
#SBATCH -n 1
#SBATCH --mem=90GB
#SBATCH -t 90:00:00


###################
# Comp. Variables #
###################

CPU=3
JAVAMEM=80g

popoolation2=~/data/S_balanoides_genomics_resources/Misc_resources/popoolation2

###################
# External files  #
###################

reference=~/data/S_balanoides_genomics_resources/Genomes/25XTENXME_10XPACBIO/DBG2OLC_Sparce_SGAcorrectedANDFiltered_GOOD/Sbal3_redundans/redundans/scaffolds.reduced.fa

#Name of out files
Project=SCGP_Sb3.1

################################
# Tests of Popoolation modules #
################################

perl  $popoolation2/indel_filtering/identify-indel-regions.pl --test
perl  $popoolation2/indel_filtering/filter-sync-by-gtf.pl --help
java -ea -Xmx$JAVAMEM -jar $popoolation2/mpileup2sync.jar --help
perl $popoolation2/snp-frequency-diff.pl --test
perl $popoolation2/cmh-test.pl  --test

###################
# Script	      # 
###################

#=============#
#Calculate  Allele freq diff
#=============#

perl $popoolation2/snp-frequency-diff.pl --input ../1.Sync_File/$Project.noindels.NoSigt.sync --output $Project.noindels.NoSigt.AlleleCount.txt --min-count 8 --min-coverage 10 --max-coverage 300


