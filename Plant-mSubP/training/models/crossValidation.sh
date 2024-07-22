#!/bin/bash

costarray=(1 5 10 20 50 70 90 100 110 150 180 200 230 258 278 300 320 340 365 390 450 500 1000 2000)
gammaarray=(0.01 1 2 5 7 10 15 20 25 30 45 50 80 100 120 135 150 175 200 230 258 278 300 320 340 365 390 450 500)
jayarray=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
#costarray=(1 5 10)
#gammaarray=(0.01 1 2)

subcellular_localization=($(ls -d */ | sed 's/\///g' | awk '{for(i=1;i<=NF;i++) print $i;}'))
workspace=($(pwd))
for jay in "${jayarray[@]}"; do
	for cost in "${costarray[@]}"; do
		for gamma in "${gammaarray[@]}"; do

			#################################### FOLD 1/5 ######################################################################################

					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4* > ${workspace}/${i}/Training_f1.txt;
						cat ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Testing_f1.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training_f1.txt ${workspace}/${i}/${i}_SingleModel_f1.txt;
						#svm_classify ${workspace}/${i}/Testing_f1.txt ${workspace}/${i}/${i}_SingleModel_f1.txt ${workspace}/${i}/Predictions_f1.txt &> ${workspace}/${i}/Predictions_f1.log;
						#rm ${workspace}/${i}/${i}_SingleModel_f1.txt;
					done
					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${i}/Testing_f1.txt ${workspace}/${j}/${j}_SingleModel_f1.txt ${workspace}/${i}/${j}_Predictions_f1.txt &> ${workspace}/${i}/${j}_Predictions_f1.log;
						done
					done
					for i in "${subcellular_localization[@]}"; do
						rm ${workspace}/${i}/${i}_SingleModel_f1.txt;
						#${workspace}/${i}/Testing_f1.txt;
						#${workspace}/${i}/Training_f1.txt;
					done

			#################################### FOLD 2/5 ######################################################################################

					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training_f2.txt;
						cat ${workspace}/${i}/*svmlight4* > ${workspace}/${i}/Testing_f2.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training_f2.txt ${workspace}/${i}/${i}_SingleModel_f2.txt;
						#svm_classify ${workspace}/${i}/Testing_f2.txt ${workspace}/${i}/${i}_SingleModel_f2.txt ${workspace}/${i}/Predictions_f2.txt &> ${workspace}/${i}/Predictions_f2.log;
						#rm ${workspace}/${i}/${i}_SingleModel_f2.txt;
					done
					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${i}/Testing_f2.txt ${workspace}/${j}/${j}_SingleModel_f2.txt ${workspace}/${i}/${j}_Predictions_f2.txt &> ${workspace}/${i}/${j}_Predictions_f2.log;
						done
					done
					for i in "${subcellular_localization[@]}"; do
						rm ${workspace}/${i}/${i}_SingleModel_f2.txt;
						#${workspace}/${i}/Testing_f2.txt;
						#${workspace}/${i}/Training_f2.txt;
					done


			#################################### FOLD 3/5 ######################################################################################

					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight4* ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training_f3.txt;
						cat ${workspace}/${i}/*svmlight3* > ${workspace}/${i}/Testing_f3.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training_f3.txt ${workspace}/${i}/${i}_SingleModel_f3.txt;
						#svm_classify ${workspace}/${i}/Testing_f3.txt ${workspace}/${i}/${i}_SingleModel_f3.txt ${workspace}/${i}/Predictions_f3.txt &> ${workspace}/${i}/Predictions_f3.log;
						#rm ${workspace}/${i}/${i}_SingleModel_f3.txt;
					done
					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${i}/Testing_f3.txt ${workspace}/${j}/${j}_SingleModel_f3.txt ${workspace}/${i}/${j}_Predictions_f3.txt &> ${workspace}/${i}/${j}_Predictions_f3.log;
						done
					done
					for i in "${subcellular_localization[@]}"; do
						rm ${workspace}/${i}/${i}_SingleModel_f3.txt;
						#${workspace}/${i}/Testing_f3.txt;
						#${workspace}/${i}/Training_f3.txt;
					done

			#################################### FOLD 4/5 ######################################################################################

					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4* ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training_f4.txt;
						cat ${workspace}/${i}/*svmlight2* > ${workspace}/${i}/Testing_f4.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training_f4.txt ${workspace}/${i}/${i}_SingleModel_f4.txt;
						#svm_classify ${workspace}/${i}/Testing_f4.txt ${workspace}/${i}/${i}_SingleModel_f4.txt ${workspace}/${i}/Predictions_f4.txt &> ${workspace}/${i}/Predictions_f4.log;
						#rm ${workspace}/${i}/${i}_SingleModel_f4.txt;
					done
					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${i}/Testing_f4.txt ${workspace}/${j}/${j}_SingleModel_f4.txt ${workspace}/${i}/${j}_Predictions_f4.txt &> ${workspace}/${i}/${j}_Predictions_f4.log;
						done
					done
					for i in "${subcellular_localization[@]}"; do
						rm ${workspace}/${i}/${i}_SingleModel_f4.txt;
						#${workspace}/${i}/Testing_f4.txt;
						#${workspace}/${i}/Training_f4.txt;
					done

			#################################### FOLD 5/5 ######################################################################################


					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4* ${workspace}/${i}/*svmlight5* > ${workspace}/${i}/Training_f5.txt;
						cat ${workspace}/${i}/*svmlight1* > ${workspace}/${i}/Testing_f5.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training_f5.txt ${workspace}/${i}/${i}_SingleModel_f5.txt;
						#svm_classify ${workspace}/${i}/Testing_f5.txt ${workspace}/${i}/${i}_SingleModel_f5.txt ${workspace}/${i}/Predictions_f5.txt &> ${workspace}/${i}/Predictions_f5.log;
						#rm ${workspace}/${i}/${i}_SingleModel_f5.txt;
					done
					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${i}/Testing_f5.txt ${workspace}/${j}/${j}_SingleModel_f5.txt ${workspace}/${i}/${j}_Predictions_f5.txt &> ${workspace}/${i}/${j}_Predictions_f5.log;
						done
					done
					for i in "${subcellular_localization[@]}"; do
						rm ${workspace}/${i}/${i}_SingleModel_f5.txt;
						#${workspace}/${i}/Testing_f5.txt;
						#${workspace}/${i}/Training_f5.txt;
					done


			###################################### INDEPENDENT TEST #####################################################################################################################3


					for i in "${subcellular_localization[@]}"; do
						cat ${workspace}/${i}/*svmlight1* ${workspace}/${i}/*svmlight2* ${workspace}/${i}/*svmlight3* ${workspace}/${i}/*svmlight4* ${workspace}/${i}/*svmlight5*  > ${workspace}/${i}/Training.txt;
						svm_learn -t 2 -c ${cost} -g ${gamma} -j ${jay} ${workspace}/${i}/Training.txt ${workspace}/${i}/${i}_SingleModel.txt;
					done

					for i in "${subcellular_localization[@]}"; do
						for j in "${subcellular_localization[@]}"; do
							svm_classify ${workspace}/${j}IndependentTest.txt ${workspace}/${i}/${i}_SingleModel.txt ${workspace}/${i}/IndependentTest_${j}_Predictions.txt &> ${workspace}/${i}/Predictions_IndependentTest_${j}.log;
						done
					done



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


			Rscript resultsConsolidation.R > c_${cost}_g_${gamma}_5foldcrossvalidation.txt;
		done
	done
done