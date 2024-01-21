#!bin/bash
# October 2020
# anna.duenser@gmail.com
# differential transcript usage A OJ vs PJ

qsub -l h_vmem=20G -V -b y -cwd -N L_OJPJ -e L_OJPJ.err -o L_OJPJ.log \
python3.6 /cl_tmp/singh_duenser/tools/SUPPA-2.3/suppa.py diffSplice -m empirical \
-i /cl_tmp/singh_duenser/all_LV/suppa/filtered.gffcmp.LV.annotated.ioi \
-p \
OJ_L_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
PJ_L_psi.LV.filtered.gffcmp.annotated_isoform.tsv \
-e \
OJ_L_transcript_tpm.tsv \
PJ_L_transcript_tpm.tsv \
--save_tpm_events \
-gc -pa -nan 0.33 -o /cl_tmp/singh_duenser/all_LV/DTU/DTU_res/L_JAWS/L_OJPJ
