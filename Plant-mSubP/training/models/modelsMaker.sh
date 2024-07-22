#!/bin/bash

subcellular_localization=($(ls -d */ | sed 's/\///g' | awk '{for(i=1;i<=NF;i++) print $i;}'))
workspace=($(pwd))

for i in "${subcellular_localization[@]}"; do
	cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4*  ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training.txt;
	svm_learn -t 2 -c 200 -g 120 -j 1 ${workspace}/${i}/Training.txt ${workspace}/${i}/${i}_svmModel.txt;
	#svm_classify ${workspace}/${i}/Testing_f1.txt ${workspace}/${i}/${i}_SingleModel_f1.txt ${workspace}/${i}/Predictions_f1.txt &> ${workspace}/${i}/Predictions_f1.log;
	#rm ${workspace}/${i}/${i}_SingleModel_f1.txt;
done
