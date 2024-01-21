#!bin/bash

# anna.duenser@gmail.com
# April 2020
# run prepDE.py

FILE_DIR="/cl_tmp/singh_duenser/all_LV/count_matrices"

qsub -q all.q -pe smp 12 -l h_vmem=4G -cwd -V -N prepDE_A \
-o $FILE_DIR/log.prepDE_A.out -e $FILE_DIR/log.prepDE_A.err -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/prepDE.py -i $FILE_DIR/sample_prepDE_A.txt \
-g $FILE_DIR/gene_count_matrix_A.csv -t $FILE_DIR/transcript_count_matrix_A.csv  -l 125


qsub -q all.q -pe smp 12 -l h_vmem=4G -cwd -V -N prepDE_L \
-o $FILE_DIR/log.prepDE_L.out -e $FILE_DIR/log.prepDE_L.err -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/prepDE.py -i $FILE_DIR/sample_prepDE_L.txt \
-g $FILE_DIR/gene_count_matrix_L.csv -t $FILE_DIR/transcript_count_matrix_L.csv  -l 125

echo -e "\n$(date)\n"

