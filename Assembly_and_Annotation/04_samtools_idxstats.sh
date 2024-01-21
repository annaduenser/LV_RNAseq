#!bin/bash

# anna.duenser@gmail.com
# samtool idxstats - .bam mapping statistics
# March 2020
########### Change '-N' jobname, '-l h_vmem=' (storage), '-pe smp #' (number of cores)
########### samtools idxstats

for i in `cat samples_samtools_idx.txt`;


do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i".idxstat" -o ./star_assembly/$i".idxstat.out" -e ./star_assembly/$i".samtools_idx.err" -b y samtools idxstats --threads 12 \
 /cl_tmp/singh_duenser/all_adult/star_assembly/$i".Aligned.sortedByCoord.out.bam" &

done
