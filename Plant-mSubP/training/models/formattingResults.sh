#!/bin/bash

subcellular_localization=($(ls -d */ | sed 's/\///g' | awk '{for(i=1;i<=NF;i++) print $i;}'))
workspace=($(pwd))


for i in "${subcellular_localization[@]}"; do
			awk '{print $1}' ${workspace}/${i}/Testing_f1.txt > ${workspace}/${i}/1f_Predictions_f1.txt
			pr -mts ${workspace}/${i}/*Predictions_f1.txt > ${workspace}/${i}/${i}_f1_results.txt

			awk '{print $1}' ${workspace}/${i}/Testing_f2.txt > ${workspace}/${i}/2f_Predictions_f2.txt
			pr -mts ${workspace}/${i}/*Predictions_f2.txt > ${workspace}/${i}/${i}_f2_results.txt

			awk '{print $1}' ${workspace}/${i}/Testing_f3.txt > ${workspace}/${i}/3f_Predictions_f3.txt
			pr -mts ${workspace}/${i}/*Predictions_f3.txt > ${workspace}/${i}/${i}_f3_results.txt

			awk '{print $1}' ${workspace}/${i}/Testing_f4.txt > ${workspace}/${i}/4f_Predictions_f4.txt
			pr -mts ${workspace}/${i}/*Predictions_f4.txt > ${workspace}/${i}/${i}_f4_results.txt

			awk '{print $1}' ${workspace}/${i}/Testing_f5.txt > ${workspace}/${i}/5f_Predictions_f5.txt
			pr -mts ${workspace}/${i}/*Predictions_f5.txt > ${workspace}/${i}/${i}_f5_results.txt



			#rm ${workspace}/${i}/Testing_f1.txt;
			#rm ${workspace}/${i}/Testing_f2.txt;
			#rm ${workspace}/${i}/Testing_f3.txt;
			#rm ${workspace}/${i}/Testing_f4.txt;
			#rm ${workspace}/${i}/Testing_f5.txt;

			rm ${workspace}/${i}/Training_f1.txt;
			rm ${workspace}/${i}/Training_f2.txt;
			rm ${workspace}/${i}/Training_f3.txt;
			rm ${workspace}/${i}/Training_f4.txt;
			rm ${workspace}/${i}/Training_f5.txt;

			rm ${workspace}/${i}/1f_Predictions_f1.txt;
			rm ${workspace}/${i}/2f_Predictions_f2.txt;
			rm ${workspace}/${i}/3f_Predictions_f3.txt;
			rm ${workspace}/${i}/4f_Predictions_f4.txt;
			rm ${workspace}/${i}/5f_Predictions_f5.txt;
			

			#svm_classify ${workspace}/${i}/Testing_f1.txt ${workspace}/${i}/${i}_SingleModel_f1.txt ${workspace}/${i}/Predictions_f1.txt &> ${workspace}/${i}/Predictions_f1.log;
			#rm ${workspace}/${i}/${i}_SingleModel_f1.txt;
done