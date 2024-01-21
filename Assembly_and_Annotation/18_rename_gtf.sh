for i in `cat samples_LV_all.txt`;

do

cp ./count_matrices/$i/"transcripts.gtf" ./count_matrices/$i/$i"_ref.gtf"

done
