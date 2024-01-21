#!bin/bash
# October 2020
# anna.duenser@gmail.com
# differential transcript usage

qsub -l h_vmem=20G -V -b y -cwd -N A_PJ_single -e A_PJ_single.err -o A_PJ_single.log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/filtered.gffcmp.LV.annotated.ioi \
-p \
Gh_PJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ht_PJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ml_PJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
No_PJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ps_PJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
-e \
Gh_PJ_A_transcript_tpm.tsv \
Ht_PJ_A_transcript_tpm.tsv \
Ml_PJ_A_transcript_tpm.tsv \
No_PJ_A_transcript_tpm.tsv \
Ps_PJ_A_transcript_tpm.tsv \
--save_tpm_events \
-gc -c -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/A_PJ/A_PJ_single
