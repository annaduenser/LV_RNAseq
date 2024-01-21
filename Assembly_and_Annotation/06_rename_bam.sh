#!bin/bash

# anna.duenser@gmail.com
# April 2020
# rename larvae and put a ".L." in the name

FILE_DIR="/cl_tmp/singh_duenser/all_st26/star_assembly"

# loop through .bam files
for i in `ls $FILE_DIR/*.bam | cut -d "/" -f 6`;

do
# cut only first part off
FIRST="$(echo $i | cut -d '.' -f 1)"
# cut the rest of needed name of
LAST="$(echo $i | cut -d '.' -f 2-3)"
# create new name
NEW_NAME=$FIRST".L."$LAST".bam"

mv $FILE_DIR/$i $FILE_DIR/$NEW_NAME

done
