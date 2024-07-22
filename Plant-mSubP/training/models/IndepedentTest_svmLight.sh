#!/bin/bash

app_root="${PLANT_MSUBP_APP_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

## AAC NCC Dipep CTDC CTDT PseAAC PseACCNCCDipep AAC  QSO

cost="$1"
gamma="$2"
jay="$3"
feature="$4"
subcellular_localization=($(ls -d */ | sed 's/\///g' | awk '{for(i=1;i<=NF;i++) print $i;}'))
workspace=($(pwd))

for i in "${subcellular_localization[@]}"; do
	cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4* ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training.txt;
	svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training.txt ${workspace}/${i}/SingleModel.txt;
	#svm_classify ${workspace}/${i}/Testing_f1.txt ${workspace}/${i}/${i}_SingleModel_f1.txt ${workspace}/${i}/Predictions_f1.txt &> ${workspace}/${i}/Predictions_f1.log;
	#rm ${workspace}/${i}/${i}_SingleModel_f1.txt;
done

for i in "${subcellular_localization[@]}"; do
	svm_classify "${app_root}/testing/models/${feature}/SequenceTo${feature}_Singletesting_svmlight.txt" ${workspace}/${i}/SingleModel.txt ${workspace}/${i}_Predictions.txt &> ${workspace}/${i}_Predictions.log;
done


awk '{print $1}' "${app_root}/testing/models/${feature}/SequenceTo${feature}_Singletesting_svmlight.txt" > ${workspace}/Alabel_Predictions.txt
pr -mts ${workspace}/*Predictions.txt > ${workspace}/results.txt