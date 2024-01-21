#!bin/bash

# anna.duenser@gmail.com
# April 2020
# gffcompare
## annotate .gtf files

# -r comparing with a reference annotation - will produce class codes: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml
# -e Maximum distance (range) allowed from free ends of terminal exons of reference transcripts when assessing exon accuracy. By default, this is 100.
# -d Maximum distance (range) for grouping transcript start sites, by default 100.

FILE_DIR="/cl_tmp/singh_duenser/all_LV"

# all single gtf files merged at once

# qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.single \
# -e $FILE_DIR/gffcompare/gffcmp.LV.single_gtf.err -o $FILE_DIR/gffcompare/gffcmp.LV.single_gtf.out \
# /usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
# $FILE_DIR/stringtie_single/stringtieMerge_single.allLV.gtf -o $FILE_DIR/gffcompare/gffcmp.stringtieMerge_single.allLV


# gtf files from merged bam per species merged at once

# qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.MergedBAM \
# -e $FILE_DIR/gffcompare/gffcmp.LV.MergedBam_gtf.err -o $FILE_DIR/gffcompare/gffcmp.LV.MergedBam_gtf.out \
# /usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
# $FILE_DIR/stringtie_MergedBam/stringtieMerge_MergedBam.allLV.gtf -o $FILE_DIR/gffcompare/gffcmp.stringtieMerge_MergedBam.allLV


# all bam files merged - one gtf

# qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.oneBam \
# -e $FILE_DIR/gffcompare/gffcmp.LV.oneBam.err -o $FILE_DIR/gffcompare/gffcmp.LV.oneBam.out \
# /usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
# $FILE_DIR/stringtie_oneBam/ALL_LV.oneBam_stringtie.gtf -o $FILE_DIR/gffcompare/gffcmp.stringtieMerge_oneBam.allLV


# stepwise merging, species, jaw, ojpj, stages

qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.stepwise \
-e $FILE_DIR/gffcompare/gffcmp.LV.stepwise.err -o $FILE_DIR/gffcompare/gffcmp.LV.stepwise.out \
/usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
$FILE_DIR/stringtie_stepwise/merged.LV.gtf -o $FILE_DIR/gffcompare/gffcmp.stringtieMerge_stepwise.allLV

