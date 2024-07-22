#!/usr/bin/env Rscript

library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
options(stringsAsFactors = FALSE)

Cyto.Golgi.training.sequence.set = readFASTA("training/sequences/Cyto_Golgi_train_filter.fasta")
Cyto.Nucl.training.sequence.set = readFASTA("training/sequences/Cyto_Nucl_train_filter.fasta")
Mito.Plastid.training.sequence.set = readFASTA("training/sequences/Mito_Plastid_train_filter.fasta")


Cyto.Golgi.training.set = data.frame()
for(i in 1:length(Cyto.Golgi.training.sequence.set)){
  Cyto.Golgi.training.set = rbind(Cyto.Golgi.training.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Golgi.training.sequence.set[[i]]))
}

Cyto.Nucl.training.set = data.frame()
for(i in 1:length(Cyto.Nucl.training.sequence.set)){
  Cyto.Nucl.training.set = rbind(Cyto.Nucl.training.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Nucl.training.sequence.set[[i]]))
}

Mito.Plastid.training.set = data.frame()
for(i in 1:length(Mito.Plastid.training.sequence.set)){
  Mito.Plastid.training.set = rbind(Mito.Plastid.training.set, SequenceToNCCDipepCTDCCTDTQSO(Mito.Plastid.training.sequence.set[[i]]))
}

Cyto.Golgi.training.set$SubCellClass = "Cyto.Golgi"
Cyto.Nucl.training.set$SubCellClass = "Cyto.Nucl"
Mito.Plastid.training.set$SubCellClass = "Mito.Plastid"


Cyto.Golgi.fold.indexes = split(1:nrow(Cyto.Golgi.training.set), f = 1:5)
Cyto.Nucl.fold.indexes = split(1:nrow(Cyto.Nucl.training.set), f = 1:5)
Mito.Plastid.fold.indexes = split(1:nrow(Mito.Plastid.training.set), f = 1:5)

fold.one = rbind(Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`1`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`1`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`1`,])

fold.two = rbind(Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`2`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`2`,],
                 Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`2`,])

fold.three = rbind(Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`3`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`3`,],
                   Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`3`,])

fold.four = rbind(Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`4`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`4`,],
                  Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`4`,])

fold.five = rbind(Cyto.Golgi.training.set[Cyto.Golgi.fold.indexes$`5`,], Cyto.Nucl.training.set[Cyto.Nucl.fold.indexes$`5`,],
                  Mito.Plastid.training.set[Mito.Plastid.fold.indexes$`5`,])

folds = list(fold.one, fold.two, fold.three, fold.four, fold.five)

mapper.acc = list()
best.acc = 0
best.model = NULL

for(i in 1:length(folds)){
  
  Training.testing.set <- folds[[i]]
  Training.training.set <- Reduce(rbind,folds[-i])
  
  Training.set <- subset(Training.training.set, select=-SubCellClass)
  Class.labels <- Training.training.set$SubCellClass
  
  svm.model = svm(Training.set, as.factor(Class.labels), cost = 30, gamma = 5, kernel="radial", type = 'C', scale = FALSE)
  #svm.model = svm(Training.set, as.factor(Class.labels), kernel="radial", type = 'C', scale = FALSE)
  
  Testing.set <- subset(Training.testing.set, select=-SubCellClass)
  Class.labels <- Training.testing.set$SubCellClass
  
  predictions <- predict(svm.model, Testing.set)
  accuracy.val <- sum(predictions==Class.labels)/length(Class.labels)
  
  mapper.acc[[i]] <- accuracy.val
  
  if(best.acc<accuracy.val){
    best.model <- svm.model
  }
  
}

####Independent Test

Cyto.Golgi.testing.sequence.set = readFASTA("testing/sequences/Cyto_Golgi_Inde.fasta")
Cyto.Nucl.testing.sequence.set = readFASTA("testing/sequences/Cyto_Nucl_Inde.fasta")
Mito.Plastid.testing.sequence.set = readFASTA("testing/sequences/Mito_Plastid_Inde.fasta")

Cyto.Golgi.testing.set = data.frame()
for(i in 1:length(Cyto.Golgi.testing.sequence.set)){
  Cyto.Golgi.testing.set = rbind(Cyto.Golgi.testing.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Golgi.testing.sequence.set[[i]]))
}

Cyto.Nucl.testing.set = data.frame()
for(i in 1:length(Cyto.Nucl.testing.sequence.set)){
  Cyto.Nucl.testing.set = rbind(Cyto.Nucl.testing.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Nucl.testing.sequence.set[[i]]))
}

Mito.Plastid.testing.set = data.frame()
for(i in 1:length(Mito.Plastid.testing.sequence.set)){
  Mito.Plastid.testing.set = rbind(Mito.Plastid.testing.set, SequenceToNCCDipepCTDCCTDTQSO(Mito.Plastid.testing.sequence.set[[i]]))
}

Cyto.Golgi.testing.set$SubCellClass = "Cyto.Golgi"
Cyto.Nucl.testing.set$SubCellClass = "Cyto.Nucl"
Mito.Plastid.testing.set$SubCellClass = "Mito.Plastid"

Total.testing.set <- rbind(Cyto.Golgi.testing.set, Cyto.Nucl.testing.set,
                           Mito.Plastid.testing.set)

Testing.set <- subset(Total.testing.set, select=-SubCellClass)
Class.labels <- Total.testing.set$SubCellClass

predictions <- predict(best.model, Testing.set)
accuracy.val <- sum(predictions==Class.labels)/length(Class.labels)
