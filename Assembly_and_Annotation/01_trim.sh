#!/bin/bash

#pooja.singh09@gmail.com
#stage 26 samples all 3 lakes
# NB copy TrueSeq3-PE-2.fa to cwd

########### trimm adapters and drop reads shorter than 70 bp

for i in `cat all.adults.lab5 | grep .1.fq | cut -f -4 -d"."`;

do


qsub -q all.q -b y -cwd -N trim -l h_vmem=4G -pe smp 8 -o $i".trim.log" -e $i".trim.err" \
/usr/bin/java -jar /cl_tmp/singh_duenser/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 \
/cl_tmp/singh_duenser/all_adult/$i".1.fq" \
/cl_tmp/singh_duenser/all_adult/$i".2.fq" \
/cl_tmp/singh_duenser/all_adult/trimmomatic/$i".1.paired.fq.gz" \
/cl_tmp/singh_duenser/all_adult/trimmomatic/$i".1.unpaired.fq.gz" \
/cl_tmp/singh_duenser/all_adult/trimmomatic/$i".2.paired.fq.gz" \
/cl_tmp/singh_duenser/all_adult/trimmomatic/$i".2.unpaired.fq.gz" \
ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10:8:keepBothReads SLIDINGWINDOW:4:28 MINLEN:70 &

done
