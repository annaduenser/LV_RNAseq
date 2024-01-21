#!bin/bash

# anna.duenser@gmail.com
# April 2020
# gffcompare
## annotate .gtf files

# -r comparing with a reference annotation - will produce class codes: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml
# -e Maximum distance (range) allowed from free ends of terminal exons of reference transcripts when assessing exon accuracy. By default, this is 100.
# -d Maximum distance (range) for grouping transcript start sites, by default 100.

FILE_DIR="/cl_tmp/singh_duenser/all_LV/gffread"

# gffcompare filtered gtf file (after gffread you loose the class codes info

qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.fil.stepwise \
-e $FILE_DIR/gffcmp.LV.stepwise.err -o $FILE_DIR/gffcmp.LV.stepwise.out \
/usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
$FILE_DIR/gffread.filtered.gffcmp.stringtieMerge_stepwise.allLV.annotated.gtf -o $FILE_DIR/filtered.gffread.gffcmp.allLV
