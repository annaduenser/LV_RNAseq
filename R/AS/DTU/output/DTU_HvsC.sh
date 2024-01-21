#!bin/bash
# october 2020
# anna.duenser@gmail.com
# differential transcript usage

STAGE="A"
JAW="OJ"

qsub -l h_vmem=20G -V -b y -cwd -N $STAGE$JAW"HvsC" -e $STAGE$JAW"HvsC".err -o $STAGE$JAW"HvsC".log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/filtered.gffcmp.LV.annotated.ioi \
-p \
"Gh_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
"Ht_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
"Ml_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
"No_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_isoform.tsv" \
-e \
"Gh_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
"Ht_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
"Ml_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
"No_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
--save_tpm_events \
-gc -c -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/$STAGE"_"$JAW/"DTU_"$STAGE"_"$JAW"_HvsC"
