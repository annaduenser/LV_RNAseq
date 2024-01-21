#!bin/bash
# October 2020
# anna.duenser@gmail.com
# differential transcript usage for each species oj vs pj

STAGE="L" #change this
SPECIES="Ps" #change this

qsub -l h_vmem=20G -V -b y -cwd -N $STAGE"_"$SPECIES"_JAWS" -e $STAGE"_"$SPECIES"_JAWS".err -o $STAGE"_"$SPECIES"_JAWS".log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/filtered.gffcmp.LV.annotated.ioi \
-p \
$SPECIES"_OJ_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
$SPECIES"_PJ_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
-e \
$SPECIES"_OJ_"$STAGE"_transcript_tpm.tsv" \
$SPECIES"_PJ_"$STAGE"_transcript_tpm.tsv" \
-gc -pa -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/$STAGE"_JAWS"/$STAGE"_"$SPECIES"_JAWS"
