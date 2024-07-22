basename.directory = ("training/models/DipepSingleModels/")

results = NULL
#SubCellClasses =SubCellClasses[-13]


for(j in 1:length(SubCellClasses)){
  
  
  for(h in 1:5){
    result.filename = paste(basename.directory,SubCellClasses[[j]],"/",SubCellClasses[[j]],"_f",h,"_results.txt",sep="")
    accuracy.matrix = read.delim(result.filename, header = FALSE)
    subclocal = j + 1 ##plus one
    
    true.positives = 0
    true.negatives = 0
    false.negatives = 0
    false.positives = 0
    
    for(i in 1:nrow(accuracy.matrix)){
      is.true = accuracy.matrix[i,1] == 1
      max.value.index = which(accuracy.matrix[i,] == max(accuracy.matrix[i,2:ncol(accuracy.matrix)]))
      
      if(max.value.index == subclocal && is.true){
        if(max(accuracy.matrix[i,2:ncol(accuracy.matrix)]) > 0){
          true.positives = true.positives + 1
        }else {
          false.negatives = false.negatives + 1
        }
      }

      if(max.value.index != subclocal && is.true){
        false.negatives = false.negatives + 1
      }

      if(max.value.index == subclocal && !is.true){
        false.positives = false.positives + 1
      }

      if(max.value.index != subclocal && !is.true){
        true.negatives = true.negatives + 1
      }

      
    }
    
    sensitivity = (true.positives/(true.positives+false.negatives)) * 100
    specificity = (true.negatives/(true.negatives+false.positives)) * 100
    precision = (true.positives/(false.positives+true.positives)) * 100
    rate.false.prediction = (false.positives/(false.positives+true.positives)) * 100
    
    accuracy = ((true.positives+true.negatives)/(true.negatives+true.positives+false.negatives+false.positives)) * 100
    
    error.rate = ((false.positives+false.negatives)/(true.negatives+true.positives+false.negatives+false.positives)) * 100
    
    matthews.corr.coef = ((true.positives*true.negatives) - (false.positives*false.negatives))/ sqrt( (false.positives+true.positives) * (true.positives+false.negatives) * (true.negatives+false.positives) * (true.negatives+false.negatives))
    
    subc.results = data.frame(sensitivity,specificity,precision,rate.false.prediction,accuracy,error.rate,matthews.corr.coef)
    colnames(subc.results) = c("Sensitivity","Specificity","Precision","Rate False Prediction","Accuracy","Error Rate","Matthews Correlation Coeficient")
    
    if(is.null(results)){
      results = subc.results
    } else {
      results = rbind(results, subc.results)
    }
    
    
  }
  
}




SubCellClassesExpand = sort(rep(SubCellClasses,5))
for(i in 1:length(SubCellClassesExpand)){
  if(i %% 5 != 0){
    SubCellClassesExpand[i] = paste(SubCellClassesExpand[i],i %% 5,sep = "")
  } else {
    SubCellClassesExpand[i] = paste(SubCellClassesExpand[i],5,sep = "")
  }
  SubCellClassesExpand[i] = SubCellClassesExpand[i]
}

rownames(results) = SubCellClassesExpand

results