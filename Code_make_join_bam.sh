#!/bin/bash

#SBATCH -J Make_join_ME_panel
#SBATCH -n 1
#SBATCH --mem=90GB
#SBATCH -t 70:00:00

#########################################################
#########################################################
#########################################################

####################
#LOAD OSCAR MODULES#
####################

module load samtools/1.9 # Manipulate SAM/BAM files

#########################################################
#Script variables													<----- USER DEFINED
CPU=6
JAVAMEM=100g
QUAL=35
PRIOR=2.8e-09
#########################################################

#############################
#Input files and Identifiers# 										<----- USER DEFINED
#############################

#Input Reads 
HIHH_Bam=~/data/S_balanoides_genomics_resources/bam_files/pool_seq_DNA/Maine_Damariscotta_High_Low_tide/Hodson_Island_High_Hot/flt.rmdp.srt.ME_HI_HH.sbal3.1.bam

HILH_Bam=~/data/S_balanoides_genomics_resources/bam_files/pool_seq_DNA/Maine_Damariscotta_High_Low_tide/Hodson_Island_Low_Hot/flt.rmdp.srt.ME_HI_LH.sbal3.1.bam

HIHC_Bam=~/data/S_balanoides_genomics_resources/bam_files/pool_seq_DNA/Maine_Damariscotta_High_Low_tide/Hodson_Island_High_Cold/flt.rmdp.srt.ME_HI_HC.sbal3.1.bam

HILC_Bam=~/data/S_balanoides_genomics_resources/bam_files/pool_seq_DNA/Maine_Damariscotta_High_Low_tide/Hodson_Island_Low_Cold/flt.rmdp.srt.ME_HI_LC.sbal3.1.bam

#Name of the project: to be added to all outputs
ProjectName=Hodgsons_Panel

#References
reference=~/data/S_balanoides_genomics_resources/Genomes/25XTENXME_10XPACBIO/DBG2OLC_Sparce_SGAcorrectedANDFiltered_GOOD/Sbal3_redundans/redundans/scaffolds.reduced.fa
#########################################################

########
#SCRIPT#
########
echo "Merging bams bam"
date

samtools merge $ProjectName.bam $HIHH_Bam $HILH_Bam $HIHC_Bam $HILC_Bam --reference $reference


echo "Finishing Process Merging bam"
date
echo "cheers JCBN"