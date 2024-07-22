
#!/bin/bash

app_root="${PLANT_MSUBP_APP_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

## AAC NCC Dipep CTDC CTDT PseAAC PseACCNCCDipep NCCDipepCTDCCTDTQSO  QSO

subcellular_localization=($(ls -d */ | sed 's/\///g' | awk '{for(i=1;i<=NF;i++) print $i;}'))
workspace=($(pwd))

for i in "${subcellular_localization[@]}"; do
	svm_classify "${app_root}/testing/models/NCCDipepCTDCCTDTQSO/SequenceToNCCDipepCTDCCTDTQSO_Singletesting_svmlight.txt" ${workspace}/${i}/SingleModel.txt ${workspace}/${i}_Predictions.txt &> ${workspace}/${i}_Predictions.log;
done


awk '{print $1}' "${app_root}/testing/models/NCCDipepCTDCCTDTQSO/SequenceToNCCDipepCTDCCTDTQSO_Singletesting_svmlight.txt" > ${workspace}/Alabel_Predictions.txt
pr -mts ${workspace}/*Predictions.txt > ${workspace}/results.txt