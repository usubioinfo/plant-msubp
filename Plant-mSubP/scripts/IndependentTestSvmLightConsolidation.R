SubCellClasses = c("Celmemb", "Celwall", "Cyto.Golgi", "Cyto.Nucl", "Cyto", "Endoplasm", "Extracel", "Golgi",
                   "Mito.Plastid", "Mito", "Nucl", "Peroxi", "Plastid", "Vacu")
accuracy.matrix = read.delim("training/models/NCCSingleModels/results.txt", header = FALSE)

#92,5,4,20,39,28,14,23,13,52,63,6,247,20,626

sequences.number = c(92,5,4,20,39,28,14,23,13,52,63,6,247,20)


Celmemb.predicted = 0
Celwall.predicted = 0
Cyto.Golgi.predicted = 0
Cyto.Nucl.predicted = 0
Cyto.predicted = 0 
Endoplasm.predicted = 0
Extracel.predicted = 0
Golgi.predicted = 0
Mito.Plastid.predicted = 0
Mito.predicted = 0
Nucl.predicted = 0
Peroxi.predicted = 0
Plastid.predicted = 0
Vacu.predicted = 0


for(i in 1:nrow(accuracy.matrix)){

    max.value.index = which(accuracy.matrix[i,] == max(accuracy.matrix[i,2:ncol(accuracy.matrix)]))
    
  if(max.value.index == 2 && i <= 92){
    Celmemb.predicted = Celmemb.predicted + 1
  }
  
  if(max.value.index == 3 && i > 92 & i <= 97){
    Celwall.predicted = Celwall.predicted + 1
  }
  
  if(max.value.index == 4 && i > 97 & i <= 101){
    Cyto.Golgi.predicted = Cyto.Golgi.predicted + 1
  }
  
  if(max.value.index == 5 && i > 101 & i <= 121){
    Cyto.Nucl.predicted = Cyto.Nucl.predicted + 1
  }
  
  if(max.value.index == 6 && i > 121 & i <= 160){
    Cyto.predicted = Cyto.predicted + 1
  }
  
  if(max.value.index == 7 && i > 160 & i <= 188){
    Endoplasm.predicted = Endoplasm.predicted + 1
  }
  
  if(max.value.index == 8 && i > 188 & i <= 202){
    Extracel.predicted = Extracel.predicted + 1
  }
  
  if(max.value.index == 9 && i > 202 & i <= 225){
    Golgi.predicted = Golgi.predicted + 1
  }
  
  if(max.value.index == 10 && i > 225 & i <= 238){
    Mito.Plastid.predicted = Mito.Plastid.predicted + 1
  }
  
  if(max.value.index == 11 && i > 238 & i <= 290){
    Mito.predicted = Mito.predicted + 1
  }
  
  if(max.value.index == 12 && i > 290 & i <= 353){
    Nucl.predicted = Nucl.predicted + 1
  }
  
  if(max.value.index == 13 && i > 353 & i <= 359){
    Peroxi.predicted = Peroxi.predicted + 1
  }
  
  if(max.value.index == 14 && i > 359 & i <= 606){
    Plastid.predicted = Plastid.predicted + 1
  }
  
  if(max.value.index == 15 && i > 606 & i <= 626){
    Vacu.predicted = Vacu.predicted + 1
  }
  
}

All.predicted = c(Celmemb.predicted, Celwall.predicted, Cyto.Golgi.predicted, Cyto.Nucl.predicted, Cyto.predicted, Endoplasm.predicted, Extracel.predicted,
                  Golgi.predicted, Mito.Plastid.predicted, Mito.predicted, Nucl.predicted, Peroxi.predicted, Plastid.predicted, Vacu.predicted)

results =  as.data.frame(c(All.predicted/sequences.number,sum(All.predicted)/sum(sequences.number)))

  


