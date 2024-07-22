results.directory <- Sys.getenv("PLANT_MSUBP_RESULTS_DIR", "training/models")


features = c("NCCDipepCTDCCTDTQSO")
sequence.numbers = c(827,37,34,170,348,280,137,204,118,442,565,57,2386,176)
total.sequences = 5781
for(j in 1:length(features)){
  folderpath = paste0(file.path(results.directory, features[j]), "/")
  files = list.files(path = folderpath)
  
  best.model.value = 0
  best.model = 0

  for(i in 1:length(files)){
    cross.val.result = read.delim(paste(folderpath,files[i],sep = ""), sep = " ")
    #colnames(cross.val.result) = c("SubCell","Sensitivity","Specificity","Precision","Rate_False_Prediction","Accuracy","toDelete","Error_Rate","Matthews_Correlation_Coeficient")
    #cross.val.result = cross.val.result[,-7]
    value = sum((cross.val.result$Sensitivity * sequence.numbers))  / total.sequences

    if(best.model.value < value){
      best.model.value = value
      best.model = i
    }
  }
  
  
  
  cross.val.result = read.delim(paste(folderpath,files[best.model],sep = ""), sep = " ",row.names = NULL)
  
  #cross.val.result = cross.val.result[,-7]
  colnames(cross.val.result) = c("SubCell","Sensitivity","Specificity","Precision","Rate_False_Prediction","Accuracy","toDelete","Error_Rate","Matthews_Correlation_Coeficient")
  cross.val.result = cross.val.result[,-7]
  subcell = "Overall"
  sensitivity = sum((cross.val.result$Sensitivity * sequence.numbers))  / total.sequences
  specificity = sum((cross.val.result$Specificity * sequence.numbers))  / total.sequences
  precision = sum((cross.val.result$Precision * sequence.numbers))  / total.sequences
  rate.false.prediction = sum((cross.val.result$Rate_False_Prediction * sequence.numbers))  / total.sequences
  accuracy = sum((cross.val.result$Accuracy * sequence.numbers))  / total.sequences
  error.rate = sum((cross.val.result$Error_Rate * sequence.numbers))  / total.sequences
  matthews.corr.coef  = sum((cross.val.result$Matthews_Correlation_Coeficient * sequence.numbers))  / total.sequences
  # sensitivity = (cross.val.result$Sensitivity[1] * 827 + cross.val.result$Sensitivity[2] * 37 + cross.val.result$Sensitivity[3] * 348 + cross.val.result$Sensitivity[4] * 34 +
  #   cross.val.result$Sensitivity[5] * 170 + cross.val.result$Sensitivity[6] * 280 + cross.val.result$Sensitivity[7] * 137 + cross.val.result$Sensitivity[8] * 204 +
  #   cross.val.result$Sensitivity[9] * 442 + cross.val.result$Sensitivity[10] * 118 + cross.val.result$Sensitivity[11] * 565 +
  #   cross.val.result$Sensitivity[12] * 57 + cross.val.result$Sensitivity[13] * 2386 + cross.val.result$Sensitivity[14] * 176) / 5781
  # specificity = (cross.val.result$Specificity[1] * 3455 + cross.val.result$Specificity[2] * 4245 + cross.val.result$Specificity[3] * 3934 + cross.val.result$Specificity[4] * 4248 +
  #                  cross.val.result$Specificity[5] * 4112 + cross.val.result$Specificity[6] * 4002 + cross.val.result$Specificity[7] * 4145 + cross.val.result$Specificity[8] * 4078 +
  #                  cross.val.result$Specificity[9] * 3840 + cross.val.result$Specificity[10] * 4164 + cross.val.result$Specificity[11] * 3717 +
  #                  cross.val.result$Specificity[12] * 4225 + cross.val.result$Specificity[13] * 3395 + cross.val.result$Specificity[14] * 4106) / 55666
  
  
  subc.results = data.frame(subcell,sensitivity,specificity,precision,rate.false.prediction,accuracy,error.rate,matthews.corr.coef)
  colnames(subc.results) = c("SubCell","Sensitivity","Specificity","Precision","Rate_False_Prediction","Accuracy","Error_Rate","Matthews_Correlation_Coeficient")
  
  cross.val.result = rbind(cross.val.result, subc.results)

  write.csv(cross.val.result, file.path(results.directory, paste0("Scaled", features[j], "_", files[best.model])), quote = FALSE, row.names = FALSE)
  
}


features = c("AAC","Dipep","CTDC","NCC","QSO")
for(j in 1:length(features)){
  folderpath = paste0(file.path(results.directory, features[j]), "/")
  files = list.files(path = folderpath)
  
  best.model.value = 0
  best.model = 0
  
  for(i in 1:length(files)){
    cross.val.result = read.delim(paste(folderpath,files[i],sep = ""), sep = " ")
    #value = mean(cross.val.result$Sensitivity) + mean(cross.val.result$Accuracy) + (mean(cross.val.result$Matthews_Correlation_Coeficient)*100)
    value = mean(cross.val.result$Sensitivity)
    #value = mean(cross.val.result$Accuracy)
    #value = (mean(cross.val.result$Matthews_Correlation_Coeficient)*100)
    if(best.model.value < value){
      best.model.value = value
      best.model = i
    }
  }
  
  cross.val.result = read.delim(paste(folderpath,files[best.model],sep = ""), sep = " ")
  
  cross.val.result = cross.val.result[,-7]
  subcell = "Overall"
  sensitivity = (cross.val.result$Sensitivity[1] * 827 + cross.val.result$Sensitivity[2] * 37 + cross.val.result$Sensitivity[3] * 348 + cross.val.result$Sensitivity[4] * 34 +
                   cross.val.result$Sensitivity[5] * 170 + cross.val.result$Sensitivity[6] * 280 + cross.val.result$Sensitivity[7] * 137 + cross.val.result$Sensitivity[8] * 204 +
                   cross.val.result$Sensitivity[9] * 442 + cross.val.result$Sensitivity[10] * 118 + cross.val.result$Sensitivity[11] * 565 +
                   cross.val.result$Sensitivity[12] * 57 + cross.val.result$Sensitivity[13] * 887 + cross.val.result$Sensitivity[14] * 176) / 4282
  specificity = (cross.val.result$Specificity[1] * 3455 + cross.val.result$Specificity[2] * 4245 + cross.val.result$Specificity[3] * 3934 + cross.val.result$Specificity[4] * 4248 +
                   cross.val.result$Specificity[5] * 4112 + cross.val.result$Specificity[6] * 4002 + cross.val.result$Specificity[7] * 4145 + cross.val.result$Specificity[8] * 4078 +
                   cross.val.result$Specificity[9] * 3840 + cross.val.result$Specificity[10] * 4164 + cross.val.result$Specificity[11] * 3717 +
                   cross.val.result$Specificity[12] * 4225 + cross.val.result$Specificity[13] * 3395 + cross.val.result$Specificity[14] * 4106) / 55666
  
  precision = mean(cross.val.result$Precision)
  rate.false.prediction = mean(cross.val.result$Rate_False_Prediction)
  accuracy = mean(cross.val.result$Accuracy)
  error.rate = mean(cross.val.result$Rate_False_Prediction)
  matthews.corr.coef  = mean(cross.val.result$Matthews_Correlation_Coeficient)
  
  subc.results = data.frame(subcell,sensitivity,specificity,precision,rate.false.prediction,accuracy,error.rate,matthews.corr.coef)
  colnames(subc.results) = c("SubCell","Sensitivity","Specificity","Precision","Rate_False_Prediction","Accuracy","Error_Rate","Matthews_Correlation_Coeficient")
  
  cross.val.result = rbind(cross.val.result, subc.results)
  
  write.csv(cross.val.result, file.path(results.directory, paste0(features[j], "_", files[best.model])), quote = FALSE, row.names = FALSE)
  
}


