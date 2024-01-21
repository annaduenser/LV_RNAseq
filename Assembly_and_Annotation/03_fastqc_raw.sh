#!bin/bash

# anna.duenser@gmail.com
# fastqc
# March 2020
########### Change '-N' jobname, '-l h_vmem=' (storage), '-pe smp #' (number of cores)
########### fastqc of untrimmed reads

for i in `cat samples_fastqc.txt`;

do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i".fastqc" -o ./fastqc/"log."$i".fastqc.out" -e ./fastqc"log."$i".fastqc.err" -b y fastqc -t 12 \
-o /cl_tmp/singh_duenser/all_adult/fastqc /cl_tmp/singh_duenser/all_adult/$i".fq" &

done
