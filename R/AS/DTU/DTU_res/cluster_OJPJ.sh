#!bin/bash
# October 2020
# anna.duenser@gmail.com
# cluster analysis, isoform level, species

STAGE="A" #change this


qsub -l h_vmem=20G -V -b y -cwd -N $STAGE"_cluster_OJPJ" -e $STAGE"_cluster_OJPJ".err -o $STAGE"_cluster_OJPJ".log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py clusterEvents \
-d $STAGE"_OJPJ.dpsi" \
-p $STAGE"_OJPJ.psivec" \
--sig-threshold 0.05 \
--groups 1-25,26-50 \
-c OPTICS \
-o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/cluster/$STAGE"_OJPJ"

