#!/bin/bash

#SBATCH -J Zonation_Contrasts_fst
#SBATCH -n 3
#SBATCH --mem=90GB
#SBATCH -t 90:00:00

################
# Load Modules #
################

module load samtools/1.9
module load R/3.4.3

###################
# Comp. Variables #
###################

CPU=3
JAVAMEM=80g
Project=ME_RI_ICE_UKW_NOR_CAN_Sb3.1

popoolation2=~/data/S_balanoides_genomics_resources/Misc_resources/popoolation2

###################
# External files  #
###################

reference=~/data/S_balanoides_genomics_resources/Genomes/25XTENXME_10XPACBIO/DBG2OLC_Sparce_SGAcorrectedANDFiltered_GOOD/Sbal3_redundans/redundans/scaffolds.reduced.fa
Sync_pops=~/data/S_balanoides_genomics_resources/Analyses/Zonation_Paper/2.CMH_test/NALT_Zon.noindels.sync

################################
# Tests of Popoolation modules #
################################

perl  $popoolation2/indel_filtering/identify-indel-regions.pl --test
perl  $popoolation2/indel_filtering/filter-sync-by-gtf.pl --help
java -ea -Xmx$JAVAMEM -jar $popoolation2/mpileup2sync.jar --help
perl $popoolation2/snp-frequency-diff.pl --test
perl $popoolation2/cmh-test.pl  --test

#$HIHH        1 | 4 
#$FIHH        2 | 5
#$HIHC        3 | 6
#$FIHC        4 | 7
#$HILH        5 | 8
#$FILH        6 | 9
#$HILC        7 | 10
#$FILC        8 | 11

#$RICHS       9 | 12
#$RICLN      10 | 13
#$RIDHS		 11 | 14
#$RIDLN      12 | 15

WINSIZE=1000
WINSTEP=500

Comparison=Extremes_ME
POPSIZES=37:37:37:37
cat ../1.Sync_File/$Project.noindels.NoSigt.sync | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$4,$5,$10,$11}' > $Project.noindels.NoSigt.$Comparison.sync

perl $popoolation2/fst-sliding.pl --input $Project.noindels.NoSigt.$Comparison.sync --output $Project.$Comparison.FST.$WINSIZE.lenght.by.$WINSTEP.bp.txt --min-count 2 --min-coverage 10 --max-coverage 100 --pool-size $POPSIZES --window-size $WINSIZE --step-size $WINSTEP --suppress-noninformative
rm $Project.noindels.NoSigt.$Comparison.sync


Comparison=Extremes_RI
POPSIZES=37:37:37:37
cat ../1.Sync_File/$Project.noindels.NoSigt.sync | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$12,$13,$14,$15}' > $Project.noindels.NoSigt.$Comparison.sync

perl $popoolation2/fst-sliding.pl --input $Project.noindels.NoSigt.$Comparison.sync --output $Project.$Comparison.FST.$WINSIZE.lenght.by.$WINSTEP.bp.txt --min-count 2 --min-coverage 10 --max-coverage 100 --pool-size $POPSIZES --window-size $WINSIZE --step-size $WINSTEP --suppress-noninformative
rm $Project.noindels.NoSigt.$Comparison.sync


echo "done"