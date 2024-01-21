#!bin/bash
# October 2020
# anna.duenser@gmail.com
# differential transcript usage

PATH_TPM="/cl_tmp/singh_duenser/all_LV/DTU/output"
STAGE="L" #A, L
JAW="OJ" #OJ, PJ

for i in `cat event.txt`;

do

qsub -l h_vmem=20G -V -b y -cwd -N "DEU_"$STAGE"_"$JAW"_HvsC_"$i -e "DEU_"$STAGE"_"$JAW"_HvsC_"$i".err" -o "DEU_"$STAGE"_"$JAW"_HvsC_"$i".log" \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/"filtered.gffcmp.LV.annotated_"$i"_strict.ioe" \
--psi \
"Gh_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_event_"$i".tsv" \
"Ht_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_event_"$i".tsv" \
"Ml_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_event_"$i".tsv" \
"No_"$JAW"_"$STAGE"_psi.LV.filtered.gffcmp.annotated_event_"$i".tsv" \
--tpm \
$PATH_TPM/"Gh_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
$PATH_TPM/"Ht_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
$PATH_TPM/"Ml_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
$PATH_TPM/"No_"$JAW"_"$STAGE"_transcript_tpm.tsv" \
--save_tpm_events \
-gc -c -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DEU/DEU_res/$STAGE"_"$JAW/$i/"DEU_"$STAGE"_"$JAW"_HvsC_"$i

done
