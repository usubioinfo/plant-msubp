#!/usr/bin/env Rscript

library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
options(stringsAsFactors = FALSE)

### Need to run evaluationSingle & evaluationMulti First.
fold.one = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`1`,], Celwall.training.set[Cellwall.fold.indexes$`1`,],
                 Cyto.training.set[Cyto.fold.indexes$`1`,], Endoplasm.training.set[Endoplasm.fold.indexes$`1`,],
                 Extracel.training.set[Extracel.fold.indexes$`1`,], Golgi.training.set[Golgi.fold.indexes$`1`,],
                 Mito.training.set[Mito.fold.indexes$`1`,],
                 Nucl.training.set[Nucl.fold.indexes$`1`,], Peroxi.training.set[Peroxi.fold.indexes$`1`,],
                 Plastid.training.set[Plastid.fold.indexes$`1`,], Vacu.training.set[Vacu.fold.indexes$`1`,],
                 Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`1`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`1`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`1`,])

fold.two = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`2`,], Celwall.training.set[Cellwall.fold.indexes$`2`,],
                 Cyto.training.set[Cyto.fold.indexes$`2`,], Endoplasm.training.set[Endoplasm.fold.indexes$`2`,],
                 Extracel.training.set[Extracel.fold.indexes$`2`,], Golgi.training.set[Golgi.fold.indexes$`2`,],
                 Mito.training.set[Mito.fold.indexes$`2`,],
                 Nucl.training.set[Nucl.fold.indexes$`2`,], Peroxi.training.set[Peroxi.fold.indexes$`2`,],
                 Plastid.training.set[Plastid.fold.indexes$`2`,], Vacu.training.set[Vacu.fold.indexes$`2`,],
                 Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`2`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`2`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`2`,])

fold.three = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`3`,], Celwall.training.set[Cellwall.fold.indexes$`3`,],
                 Cyto.training.set[Cyto.fold.indexes$`3`,], Endoplasm.training.set[Endoplasm.fold.indexes$`3`,],
                 Extracel.training.set[Extracel.fold.indexes$`3`,], Golgi.training.set[Golgi.fold.indexes$`3`,],
                 Mito.training.set[Mito.fold.indexes$`3`,],
                 Nucl.training.set[Nucl.fold.indexes$`3`,], Peroxi.training.set[Peroxi.fold.indexes$`3`,],
                 Plastid.training.set[Plastid.fold.indexes$`3`,], Vacu.training.set[Vacu.fold.indexes$`3`,],
                 Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`3`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`3`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`3`,])

fold.four = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`4`,], Celwall.training.set[Cellwall.fold.indexes$`4`,],
                 Cyto.training.set[Cyto.fold.indexes$`4`,], Endoplasm.training.set[Endoplasm.fold.indexes$`4`,],
                 Extracel.training.set[Extracel.fold.indexes$`4`,], Golgi.training.set[Golgi.fold.indexes$`4`,],
                 Mito.training.set[Mito.fold.indexes$`4`,],
                 Nucl.training.set[Nucl.fold.indexes$`4`,], Peroxi.training.set[Peroxi.fold.indexes$`4`,],
                 Plastid.training.set[Plastid.fold.indexes$`4`,], Vacu.training.set[Vacu.fold.indexes$`4`,],
                 Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`4`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`4`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`4`,])

fold.five = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`5`,], Celwall.training.set[Cellwall.fold.indexes$`5`,],
                  Cyto.training.set[Cyto.fold.indexes$`5`,], Endoplasm.training.set[Endoplasm.fold.indexes$`5`,],
                  Extracel.training.set[Extracel.fold.indexes$`5`,], Golgi.training.set[Golgi.fold.indexes$`5`,],
                  Mito.training.set[Mito.fold.indexes$`5`,],
                  Nucl.training.set[Nucl.fold.indexes$`5`,], Peroxi.training.set[Peroxi.fold.indexes$`5`,],
                  Plastid.training.set[Plastid.fold.indexes$`5`,], Vacu.training.set[Vacu.fold.indexes$`5`,],
                  Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`5`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`5`,],
                  Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`5`,])

folds = list(fold.one, fold.two, fold.three, fold.four, fold.five)

mapper.acc = list()
best.acc = 0
best.model = NULL

for(i in 1:length(folds)){
  
  Training.testing.set <- folds[[i]]
  Training.training.set <- Reduce(rbind,folds[-i])
  
  Training.set <- subset(Training.training.set, select=-SubCellClass)
  Training.Class.labels <- as.factor(Training.training.set$SubCellClass)
  
  
  svm.model = svm(Training.set, Training.Class.labels, cost = 2, gamma = 3, kernel="radial", type = 'C')
  #svm.model = svm(Training.set, Training.Class.labels, kernel="radial", type = 'C', scale = FALSE)
  
  Testing.set <- subset(Training.testing.set, select=-SubCellClass)
  Class.labels <- Training.testing.set$SubCellClass
  
  predictions <- predict(svm.model, Testing.set, na.action = na.fail)
  #nrow(Testing.set)
  accuracy.val <- sum(as.character(predictions)==Class.labels)/length(Class.labels)
  
  mapper.acc[[i]] <- accuracy.val
  
  if(best.acc<accuracy.val){
    best.model <- svm.model
  }
  
}

####Independent Test

Total.testing.set <- rbind(Celmemb.testing.set, Celwall.testing.set, 
                          Cyto.testing.set, Endoplasm.testing.set,
                          Extracel.testing.set, Golgi.testing.set,
                          Mito.testing.set,
                          Nucl.testing.set, Peroxi.testing.set,
                          Plastid.testing.set, Vacu.testing.set, Cyto.Golgi.testing.set, Cyto.Nucl.testing.set,
                          Mito.Plastid.testing.set)

Testing.set <- subset(Total.testing.set, select=-SubCellClass)
Class.labels <- Total.testing.set$SubCellClass

predictions <- predict(best.model, Testing.set)
accuracy.val <- sum(predictions==Class.labels)/length(Class.labels)
