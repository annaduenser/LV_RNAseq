#!bin/bash
# October 2020
# anna.duenser@gmail.com
# differential transcript usage

qsub -l h_vmem=20G -V -b y -cwd -N A_OJ_single -e A_OJ_single.err -o A_OJ_single.log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/filtered.gffcmp.LV.annotated.ioi \
-p \
Gh_OJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ht_OJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ml_OJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
No_OJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
Ps_OJ_A_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
-e \
Gh_OJ_A_transcript_tpm.tsv \
Ht_OJ_A_transcript_tpm.tsv \
Ml_OJ_A_transcript_tpm.tsv \
No_OJ_A_transcript_tpm.tsv \
Ps_OJ_A_transcript_tpm.tsv \
-gc -c -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/A_OJ/A_OJ_single
