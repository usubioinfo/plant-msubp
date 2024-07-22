column.feature.number = 20

features$SubCellClass = -1
for(j in 1:(ncol(features)-1)){
   features[,j] = paste(j,features[,j],sep = ":")
}

features= features[,c((column.feature.number+1),1:column.feature.number)]

query.filename = paste("./tmp/tmp",time.file,"svmlight.txt", sep = "")
#

Celmemb.model.filename = paste("./training/models/AAC/Celmemb_svmModel.txt")
Celwall.model.filename = paste("./training/models/AAC/Celwall_svmModel.txt")
Cyto.Golgi.model.filename = paste("./training/models/AAC/Cyto.Golgi_svmModel.txt")
Cyto.Nucl.model.filename = paste("./training/models/AAC/Cyto.Nucl_svmModel.txt")
Cyto.model.filename = paste("./training/models/AAC/Cyto_svmModel.txt")
Endoplasm.model.filename = paste("./training/models/AAC/Endoplasm_svmModel.txt")
Extracel.model.filename = paste("./training/models/AAC/Extracel_svmModel.txt")
Golgi.model.filename = paste("./training/models/AAC/Golgi_svmModel.txt")
Mito.Plastid.model.filename = paste("./training/models/AAC/Mito.Plastid_svmModel.txt")
Mito.model.filename = paste("./training/models/AAC/Mito_svmModel.txt")
Nucl.model.filename = paste("./training/models/AAC/Nucl_svmModel.txt")
Peroxi.model.filename = paste("./training/models/AAC/Peroxi_svmModel.txt")
Plastid.model.filename = paste("./training/models/AAC/Plastid_svmModel.txt")
Vacu.model.filename = paste("./training/models/AAC/Vacu_svmModel.txt")



Celmemb.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Celmemb_prediction.txt", sep = "")
Celwall.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Celwall_prediction.txt", sep = "")
Cyto.Golgi.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Cyto.Golgi_prediction.txt", sep = "")
Cyto.Nucl.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Cyto.Nucl_prediction.txt", sep = "")
Cyto.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Cyto_prediction.txt", sep = "")
Endoplasm.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Endoplasm_prediction.txt", sep = "")
Extracel.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Extracel_prediction.txt", sep = "")
Golgi.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Golgi_prediction.txt", sep = "")
Mito.Plastid.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Mito.Plastid_prediction.txt", sep = "")
Mito.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Mito_prediction.txt", sep = "")
Nucl.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Nucl_prediction.txt", sep = "")
Peroxi.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Peroxi_prediction.txt", sep = "")
Plastid.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Plastid_prediction.txt", sep = "")
Vacu.prediction.result.filename = paste("./tmp/tmp_result_",time.file,"_Vacu_prediction.txt", sep = "")
prediction.result.filename = paste("./tmp/tmp_result_",time.file,"final_prediction.txt", sep = "")


write.table(features, file = query.filename, quote = FALSE,
             sep = " ", row.names = FALSE, col.names = FALSE)

system(paste("svm_classify ",query.filename,Celmemb.model.filename,Celmemb.prediction.result.filename))
system(paste("svm_classify ",query.filename,Celwall.model.filename,Celwall.prediction.result.filename))
system(paste("svm_classify ",query.filename,Cyto.Golgi.model.filename,Cyto.Golgi.prediction.result.filename))
system(paste("svm_classify ",query.filename,Cyto.Nucl.model.filename,Cyto.Nucl.prediction.result.filename))
system(paste("svm_classify ",query.filename,Cyto.model.filename,Cyto.prediction.result.filename))
system(paste("svm_classify ",query.filename,Endoplasm.model.filename,Endoplasm.prediction.result.filename))
system(paste("svm_classify ",query.filename,Extracel.model.filename,Extracel.prediction.result.filename))
system(paste("svm_classify ",query.filename,Golgi.model.filename,Golgi.prediction.result.filename))
system(paste("svm_classify ",query.filename,Mito.Plastid.model.filename,Mito.Plastid.prediction.result.filename))
system(paste("svm_classify ",query.filename,Mito.model.filename,Mito.prediction.result.filename))
system(paste("svm_classify ",query.filename,Nucl.model.filename,Nucl.prediction.result.filename))
system(paste("svm_classify ",query.filename,Peroxi.model.filename,Peroxi.prediction.result.filename))
system(paste("svm_classify ",query.filename,Plastid.model.filename,Plastid.prediction.result.filename))
system(paste("svm_classify ",query.filename,Vacu.model.filename,Vacu.prediction.result.filename))


system(paste("paste -d , ",Celmemb.prediction.result.filename,Celwall.prediction.result.filename,Cyto.Golgi.prediction.result.filename,
             Cyto.Nucl.prediction.result.filename, Cyto.prediction.result.filename, Endoplasm.prediction.result.filename,
             Extracel.prediction.result.filename, Golgi.prediction.result.filename, Mito.Plastid.prediction.result.filename,
             Mito.prediction.result.filename, Nucl.prediction.result.filename, Peroxi.prediction.result.filename,
             Plastid.prediction.result.filename, Vacu.prediction.result.filename," > ", prediction.result.filename))
       
       
prediction = read.csv(prediction.result.filename,header = FALSE)
prediction$Prediction = "None"
prediction = prediction[,c(15,seq(1,14))]
i = 1
for(i in 1:nrow(prediction)){
  prediction.index = as.numeric(which.max( prediction[i,seq(2,15)] ) )
  if(prediction[i,prediction.index+1]>0){
    prediction[i,1] = SubCellClasses[prediction.index]
  }
}


prediction$Sequence_id = names(sequences)
prediction = prediction[,c(16,seq(1,15))]








