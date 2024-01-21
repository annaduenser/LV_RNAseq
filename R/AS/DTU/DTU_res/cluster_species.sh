#!bin/bash
# October 2020
# anna.duenser@gmail.com
# cluster analysis, isoform level, species

STAGE="A" #change this
JAW="OJ"


qsub -l h_vmem=20G -V -b y -cwd -N $STAGE"_"$JAW"_cluster" -e $STAGE"_"$JAW"_cluster".err -o $STAGE"_"$JAW"_cluster".log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py clusterEvents \
-d $STAGE"_"$JAW"_single.dpsi" \
-p $STAGE"_"$JAW"_single.psivec" \
--sig-threshold 0.05 \
--groups 1-5,6-10,11-15,16-20,21-25 \
-c OPTICS \
-o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/cluster/$STAGE"_"$SPECIES"_JAWS"

