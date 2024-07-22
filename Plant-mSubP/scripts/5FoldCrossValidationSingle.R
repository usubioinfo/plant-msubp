#!/usr/bin/env Rscript

library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
options(stringsAsFactors = FALSE)

Celmemb.training.sequence.set = readFASTA("training/sequences/Celmemb_train_filter.fasta")
Celwall.training.sequence.set = readFASTA("training/sequences/Celwall_train_filter.fasta")
Cyto.training.sequence.set = readFASTA("training/sequences/Cyto_train_filter.fasta")
Endoplasm.training.sequence.set = readFASTA("training/sequences/Endoplasm_train_filter.fasta")
Extracel.training.sequence.set = readFASTA("training/sequences/Extracel_train_filter.fasta")
Golgi.training.sequence.set = readFASTA("training/sequences/Golgi_train_filter.fasta")
Mito.training.sequence.set = readFASTA("training/sequences/Mito_train_filter.fasta")
Nucl.training.sequence.set = readFASTA("training/sequences/Nucl_train_filter.fasta")
Peroxi.training.sequence.set = readFASTA("training/sequences/Peroxi_train_filter.fasta")
Plastid.training.sequence.set = readFASTA("training/sequences/Plastid_train_filter.fasta")
Vacu.training.sequence.set = readFASTA("training/sequences/Vacu_train_filter.fasta")

Celmemb.training.set = data.frame()
for(i in 1:length(Celmemb.training.sequence.set)){
  Celmemb.training.set = rbind(Celmemb.training.set, SequenceToQSO(Celmemb.training.sequence.set[[i]]))
}

Celwall.training.set = data.frame()
for(i in 1:length(Celwall.training.sequence.set)){
  Celwall.training.set = rbind(Celwall.training.set, SequenceToQSO(Celwall.training.sequence.set[[i]]))
}

Cyto.training.set = data.frame()
for(i in 1:length(Cyto.training.sequence.set)){
  Cyto.training.set = rbind(Cyto.training.set, SequenceToQSO(Cyto.training.sequence.set[[i]]))
}

Endoplasm.training.set = data.frame()
for(i in 1:length(Endoplasm.training.sequence.set)){
  Endoplasm.training.set = rbind(Endoplasm.training.set, SequenceToQSO(Endoplasm.training.sequence.set[[i]]))
}

Extracel.training.set = data.frame()
for(i in 1:length(Extracel.training.sequence.set)){
  Extracel.training.set = rbind(Extracel.training.set, SequenceToQSO(Extracel.training.sequence.set[[i]]))
}

Golgi.training.set = data.frame()
for(i in 1:length(Golgi.training.sequence.set)){
  Golgi.training.set = rbind(Golgi.training.set, SequenceToQSO(Golgi.training.sequence.set[[i]]))
}

Mito.training.set = data.frame()
for(i in 1:length(Mito.training.sequence.set)){
  Mito.training.set = rbind(Mito.training.set, SequenceToQSO(Mito.training.sequence.set[[i]]))
}

Nucl.training.set = data.frame()
for(i in 1:length(Nucl.training.sequence.set)){
  Nucl.training.set = rbind(Nucl.training.set, SequenceToQSO(Nucl.training.sequence.set[[i]]))
}

Peroxi.training.set = data.frame()
for(i in 1:length(Peroxi.training.sequence.set)){
  Peroxi.training.set = rbind(Peroxi.training.set, SequenceToQSO(Peroxi.training.sequence.set[[i]]))
}

Plastid.training.set = data.frame()
for(i in 1:length(Plastid.training.sequence.set)){
  Plastid.training.set = rbind(Plastid.training.set, SequenceToQSO(Plastid.training.sequence.set[[i]]))
}

Vacu.training.set = data.frame()
for(i in 1:length(Vacu.training.sequence.set)){
  Vacu.training.set = rbind(Vacu.training.set, SequenceToQSO(Vacu.training.sequence.set[[i]]))
}

Celmemb.training.set$SubCellClass = "Celmemb"
Celwall.training.set$SubCellClass = "Celwall"
Cyto.training.set$SubCellClass = "Cyto"
Endoplasm.training.set$SubCellClass = "Endoplasm"
Extracel.training.set$SubCellClass = "Extracel"
Golgi.training.set$SubCellClass = "Golgi"
Mito.training.set$SubCellClass = "Mito"
Nucl.training.set$SubCellClass = "Nucl"
Peroxi.training.set$SubCellClass = "Peroxi"
Plastid.training.set$SubCellClass = "Plastid"
Vacu.training.set$SubCellClass = "Vacu"

Cellmemb.fold.indexes$`1`

Cellmemb.fold.indexes = split(1:nrow(Celmemb.training.set), f = 1:5)
Cellwall.fold.indexes = split(1:nrow(Celwall.training.set), f = 1:5)
Cyto.fold.indexes = split(1:nrow(Cyto.training.set), f = 1:5)
Endoplasm.fold.indexes = split(1:nrow(Endoplasm.training.set), f = 1:5)
Extracel.fold.indexes = split(1:nrow(Extracel.training.set), f = 1:5)
Golgi.fold.indexes = split(1:nrow(Golgi.training.set), f = 1:5)
Mito.fold.indexes = split(1:nrow(Mito.training.set), f = 1:5)
Nucl.fold.indexes = split(1:nrow(Nucl.training.set), f = 1:5)
Peroxi.fold.indexes = split(1:nrow(Peroxi.training.set), f = 1:5)
Plastid.fold.indexes = split(1:nrow(Plastid.training.set), f = 1:5)
Vacu.fold.indexes = split(1:nrow(Vacu.training.set), f = 1:5)

fold.one = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`1`,], Celwall.training.set[Cellwall.fold.indexes$`1`,],
                 Cyto.training.set[Cyto.fold.indexes$`1`,], Endoplasm.training.set[Endoplasm.fold.indexes$`1`,],
                 Extracel.training.set[Extracel.fold.indexes$`1`,], Golgi.training.set[Golgi.fold.indexes$`1`,],
                 Mito.training.set[Mito.fold.indexes$`1`,],
                 Nucl.training.set[Nucl.fold.indexes$`1`,], Peroxi.training.set[Peroxi.fold.indexes$`1`,],
                 Plastid.training.set[Plastid.fold.indexes$`1`,], Vacu.training.set[Vacu.fold.indexes$`1`,])

fold.two = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`2`,], Celwall.training.set[Cellwall.fold.indexes$`2`,],
                 Cyto.training.set[Cyto.fold.indexes$`2`,], Endoplasm.training.set[Endoplasm.fold.indexes$`2`,],
                 Extracel.training.set[Extracel.fold.indexes$`2`,], Golgi.training.set[Golgi.fold.indexes$`2`,],
                 Mito.training.set[Mito.fold.indexes$`2`,],
                 Nucl.training.set[Nucl.fold.indexes$`2`,], Peroxi.training.set[Peroxi.fold.indexes$`2`,],
                 Plastid.training.set[Plastid.fold.indexes$`2`,], Vacu.training.set[Vacu.fold.indexes$`2`,])

fold.three = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`3`,], Celwall.training.set[Cellwall.fold.indexes$`3`,],
                 Cyto.training.set[Cyto.fold.indexes$`3`,], Endoplasm.training.set[Endoplasm.fold.indexes$`3`,],
                 Extracel.training.set[Extracel.fold.indexes$`3`,], Golgi.training.set[Golgi.fold.indexes$`3`,],
                 Mito.training.set[Mito.fold.indexes$`3`,],
                 Nucl.training.set[Nucl.fold.indexes$`3`,], Peroxi.training.set[Peroxi.fold.indexes$`3`,],
                 Plastid.training.set[Plastid.fold.indexes$`3`,], Vacu.training.set[Vacu.fold.indexes$`3`,])

fold.four = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`4`,], Celwall.training.set[Cellwall.fold.indexes$`4`,],
                 Cyto.training.set[Cyto.fold.indexes$`4`,], Endoplasm.training.set[Endoplasm.fold.indexes$`4`,],
                 Extracel.training.set[Extracel.fold.indexes$`4`,], Golgi.training.set[Golgi.fold.indexes$`4`,],
                 Mito.training.set[Mito.fold.indexes$`4`,],
                 Nucl.training.set[Nucl.fold.indexes$`4`,], Peroxi.training.set[Peroxi.fold.indexes$`4`,],
                 Plastid.training.set[Plastid.fold.indexes$`4`,], Vacu.training.set[Vacu.fold.indexes$`4`,])

fold.five = rbind(Celmemb.training.set[Cellmemb.fold.indexes$`5`,], Celwall.training.set[Cellwall.fold.indexes$`5`,],
                  Cyto.training.set[Cyto.fold.indexes$`5`,], Endoplasm.training.set[Endoplasm.fold.indexes$`5`,],
                  Extracel.training.set[Extracel.fold.indexes$`5`,], Golgi.training.set[Golgi.fold.indexes$`5`,],
                  Mito.training.set[Mito.fold.indexes$`5`,],
                  Nucl.training.set[Nucl.fold.indexes$`5`,], Peroxi.training.set[Peroxi.fold.indexes$`5`,],
                  Plastid.training.set[Plastid.fold.indexes$`5`,], Vacu.training.set[Vacu.fold.indexes$`5`,])

folds = list(fold.one, fold.two, fold.three, fold.four, fold.five)

mapper.acc = list()

for(i in 1:length(folds)){
  
  Training.testing.set <- folds[[i]]
  Training.training.set <- Reduce(rbind,folds[-i])
  
  Training.set <- subset(Training.training.set, select=-SubCellClass)
  Class.labels <- Training.training.set$SubCellClass
  
  svm.model = svm(Training.set, as.factor(Class.labels), cost = 500, gamma = 50, kernel="radial", type = 'C', scale = FALSE)
  
  Testing.set <- subset(Training.testing.set, select=-SubCellClass)
  Class.labels <- Training.testing.set$SubCellClass
  
  predictions = predict(svm.model, Testing.set)
  accuracy.val=sum(predictions==Class.labels)/length(Class.labels)
  
  mapper.acc[[i]] = accuracy.val
  
}
####Independent Test

Celmemb.testing.sequence.set = readFASTA("testing/sequences/Celmemb_Inde.fasta")
Celwall.testing.sequence.set = readFASTA("testing/sequences/Celwall_Inde.fasta")
Cyto.testing.sequence.set = readFASTA("testing/sequences/Cyto_Inde.fasta")
Endoplasm.testing.sequence.set = readFASTA("testing/sequences/Endoplasm_Inde.fasta")
Extracel.testing.sequence.set = readFASTA("testing/sequences/Extracel_Inde.fasta")
Golgi.testing.sequence.set = readFASTA("testing/sequences/Golgi_Inde.fasta")
Mito.testing.sequence.set = readFASTA("testing/sequences/Mito_Inde.fasta")
Nucl.testing.sequence.set = readFASTA("testing/sequences/Nucl_Inde.fasta")
Peroxi.testing.sequence.set = readFASTA("testing/sequences/Peroxi_Inde.fasta")
Plastid.testing.sequence.set = readFASTA("testing/sequences/Plastid_Inde.fasta")
Vacu.testing.sequence.set = readFASTA("testing/sequences/Vacu_Inde.fasta")

Celmemb.testing.set = data.frame()
for(i in 1:length(Celmemb.testing.sequence.set)){
  Celmemb.testing.set = rbind(Celmemb.testing.set, SequenceToCTDT(Celmemb.testing.sequence.set[[i]]))
}

Celwall.testing.set = data.frame()
for(i in 1:length(Celwall.testing.sequence.set)){
  Celwall.testing.set = rbind(Celwall.testing.set, SequenceToCTDT(Celwall.testing.sequence.set[[i]]))
}


Cyto.testing.set = data.frame()
for(i in 1:length(Cyto.testing.sequence.set)){
  Cyto.testing.set = rbind(Cyto.testing.set, SequenceToCTDT(Cyto.testing.sequence.set[[i]]))
}

Endoplasm.testing.set = data.frame()
for(i in 1:length(Endoplasm.testing.sequence.set)){
  Endoplasm.testing.set = rbind(Endoplasm.testing.set, SequenceToCTDT(Endoplasm.testing.sequence.set[[i]]))
}

Extracel.testing.set = data.frame()
for(i in 1:length(Extracel.testing.sequence.set)){
  Extracel.testing.set = rbind(Extracel.testing.set, SequenceToCTDT(Extracel.testing.sequence.set[[i]]))
}

Golgi.testing.set = data.frame()
for(i in 1:length(Golgi.testing.sequence.set)){
  Golgi.testing.set = rbind(Golgi.testing.set, SequenceToCTDT(Golgi.testing.sequence.set[[i]]))
}

Mito.testing.set = data.frame()
for(i in 1:length(Mito.testing.sequence.set)){
  Mito.testing.set = rbind(Mito.testing.set, SequenceToCTDT(Mito.testing.sequence.set[[i]]))
}

Nucl.testing.set = data.frame()
for(i in 1:length(Nucl.testing.sequence.set)){
  Nucl.testing.set = rbind(Nucl.testing.set, SequenceToCTDT(Nucl.testing.sequence.set[[i]]))
}

Peroxi.testing.set = data.frame()
for(i in 1:length(Peroxi.testing.sequence.set)){
  Peroxi.testing.set = rbind(Peroxi.testing.set, SequenceToCTDT(Peroxi.testing.sequence.set[[i]]))
}

Plastid.testing.set = data.frame()
for(i in 1:length(Plastid.testing.sequence.set)){
  Plastid.testing.set = rbind(Plastid.testing.set, SequenceToCTDT(Plastid.testing.sequence.set[[i]]))
}

Vacu.testing.set = data.frame()
for(i in 1:length(Vacu.testing.sequence.set)){
  Vacu.testing.set = rbind(Vacu.testing.set, SequenceToCTDT(Vacu.testing.sequence.set[[i]]))
}

Total.testing.set = rbind(Celmemb.testing.set, Celwall.testing.set, 
                          Cyto.testing.set, Endoplasm.testing.set,
                          Extracel.testing.set, Golgi.testing.set,
                          Mito.testing.set,
                          Nucl.testing.set, Peroxi.testing.set,
                          Plastid.testing.set, Vacu.testing.set)


