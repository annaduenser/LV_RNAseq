#!bin/bash

# anna.duenser@gmail.com
# September 2020
# stringtie
## Run stringtie with the new annotations
# -M to reduce multimapping, -e to only alow transcripts in the hopefully soon filtered annotation file, --rf strand info, -B ballgown files

FILE_DIR_STAR_A="/cl_tmp/singh_duenser/all_adult/star_assembly"
FILE_DIR_STAR_L="/cl_tmp/singh_duenser/all_st26/star_assembly"
FILE_DIR_OUT="/cl_tmp/singh_duenser/all_LV/count_matrices"
FILE_DIR_ANNO="/cl_tmp/singh_duenser/all_LV/gffread"

for i in `cat samples_LV_A.txt`;
 
do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i"stringtie.all" \
-o $FILE_DIR_OUT/"log.A.stringtie.all.out" -e $FILE_DIR_OUT/"log.A.stringtie.all.err" -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/stringtie -M 0.0 -e -B -G \
$FILE_DIR_ANNO/filtered.gffread.gffcmp.allLV.annotated.gtf \
--rf  -o $FILE_DIR_OUT/$i/transcripts.gtf \
-A $FILE_DIR_OUT/$i/gene_abundance.tsv \
$FILE_DIR_STAR_A/$i".Aligned.sortedByCoord.out.bam"

sleep 1

done 

for i in `cat samples_LV_L.txt`;
 
do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i"stringtie.all" \
-o $FILE_DIR_OUT/"log.L.stringtie.all.out" -e $FILE_DIR_OUT/"log.L.stringtie.all.err" -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/stringtie -M 0.0 -e -B -G \
$FILE_DIR_ANNO/filtered.gffread.gffcmp.allLV.annotated.gtf \
--rf  -o $FILE_DIR_OUT/$i/transcripts.gtf \
-A $FILE_DIR_OUT/$i/gene_abundance.tsv \
$FILE_DIR_STAR_L/$i".bam"

sleep 1

done 

