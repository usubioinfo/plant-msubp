#!/usr/bin/env Rscript

library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
column.feature.number = 20
options(stringsAsFactors = FALSE)

Celmemb.training.sequence.set = readFASTA("training/sequences/Celmemb_train_filter.fasta")
Celwall.training.sequence.set = readFASTA("training/sequences/Celwall_train_filter.fasta")
Cyto.Golgi.training.sequence.set = readFASTA("training/sequences/Cyto_Golgi_train_filter.fasta")
Cyto.Nucl.training.sequence.set = readFASTA("training/sequences/Cyto_Nucl_train_filter.fasta")
Cyto.training.sequence.set = readFASTA("training/sequences/Cyto_train_filter.fasta")
Endoplasm.training.sequence.set = readFASTA("training/sequences/Endoplasm_train_filter.fasta")
Extracel.training.sequence.set = readFASTA("training/sequences/Extracel_train_filter.fasta")
Golgi.training.sequence.set = readFASTA("training/sequences/Golgi_train_filter.fasta")
Mito.Plastid.training.sequence.set = readFASTA("training/sequences/Mito_Plastid_train_filter.fasta")
Mito.training.sequence.set = readFASTA("training/sequences/Mito_train_filter.fasta")
#Multi.SubCellClass.training.sequence.set = readFASTA("training/sequences/Multi_Class_train_filter.fasta")
Nucl.training.sequence.set = readFASTA("training/sequences/Nucl_train_filter.fasta")
#Other.Dual.training.sequence.set = readFASTA("training/sequences/Other_Dual_train_filter.fasta")
Peroxi.training.sequence.set = readFASTA("training/sequences/Peroxi_train_filter.fasta")
Plastid.training.sequence.set = readFASTA("training/sequences/Plastid_train_filter.fasta")
Vacu.training.sequence.set = readFASTA("training/sequences/Vacu_train_filter.fasta")

Celmemb.training.set = data.frame()
for(i in 1:length(Celmemb.training.sequence.set)){
  Celmemb.training.set = rbind(Celmemb.training.set, SequenceToNCCDipepCTDCCTDTQSO(Celmemb.training.sequence.set[[i]]))
}

Celwall.training.set = data.frame()
for(i in 1:length(Celwall.training.sequence.set)){
  Celwall.training.set = rbind(Celwall.training.set, SequenceToNCCDipepCTDCCTDTQSO(Celwall.training.sequence.set[[i]]))
}

Cyto.Golgi.training.set = data.frame()
for(i in 1:length(Cyto.Golgi.training.sequence.set)){
  Cyto.Golgi.training.set = rbind(Cyto.Golgi.training.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Golgi.training.sequence.set[[i]]))
}

Cyto.Nucl.training.set = data.frame()
for(i in 1:length(Cyto.Nucl.training.sequence.set)){
  Cyto.Nucl.training.set = rbind(Cyto.Nucl.training.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.Nucl.training.sequence.set[[i]]))
}

Cyto.training.set = data.frame()
for(i in 1:length(Cyto.training.sequence.set)){
  Cyto.training.set = rbind(Cyto.training.set, SequenceToNCCDipepCTDCCTDTQSO(Cyto.training.sequence.set[[i]]))
}

Endoplasm.training.set = data.frame()
for(i in 1:length(Endoplasm.training.sequence.set)){
  Endoplasm.training.set = rbind(Endoplasm.training.set, SequenceToNCCDipepCTDCCTDTQSO(Endoplasm.training.sequence.set[[i]]))
}

Extracel.training.set = data.frame()
for(i in 1:length(Extracel.training.sequence.set)){
  Extracel.training.set = rbind(Extracel.training.set, SequenceToNCCDipepCTDCCTDTQSO(Extracel.training.sequence.set[[i]]))
}

Golgi.training.set = data.frame()
for(i in 1:length(Golgi.training.sequence.set)){
  Golgi.training.set = rbind(Golgi.training.set, SequenceToNCCDipepCTDCCTDTQSO(Golgi.training.sequence.set[[i]]))
}

Mito.Plastid.training.set = data.frame()
for(i in 1:length(Mito.Plastid.training.sequence.set)){
  Mito.Plastid.training.set = rbind(Mito.Plastid.training.set, SequenceToNCCDipepCTDCCTDTQSO(Mito.Plastid.training.sequence.set[[i]]))
}

Mito.training.set = data.frame()
for(i in 1:length(Mito.training.sequence.set)){
  Mito.training.set = rbind(Mito.training.set, SequenceToNCCDipepCTDCCTDTQSO(Mito.training.sequence.set[[i]]))
}

# Multi.SubCellClass.training.set = data.frame()
# for(i in 1:length(Multi.SubCellClass.training.sequence.set)){
#   Multi.SubCellClass.training.set = rbind(Multi.SubCellClass.training.set, SequenceToNCCDipepCTDCCTDTQSO(Multi.SubCellClass.training.sequence.set[[i]]))
# }

Nucl.training.set = data.frame()
for(i in 1:length(Nucl.training.sequence.set)){
  Nucl.training.set = rbind(Nucl.training.set, SequenceToNCCDipepCTDCCTDTQSO(Nucl.training.sequence.set[[i]]))
}


Peroxi.training.set = data.frame()
for(i in 1:length(Peroxi.training.sequence.set)){
  Peroxi.training.set = rbind(Peroxi.training.set, SequenceToNCCDipepCTDCCTDTQSO(Peroxi.training.sequence.set[[i]]))
}

Plastid.training.set = data.frame()
for(i in 1:length(Plastid.training.sequence.set)){
  Plastid.training.set = rbind(Plastid.training.set, SequenceToNCCDipepCTDCCTDTQSO(Plastid.training.sequence.set[[i]]))
}

Vacu.training.set = data.frame()
for(i in 1:length(Vacu.training.sequence.set)){
  Vacu.training.set = rbind(Vacu.training.set, SequenceToNCCDipepCTDCCTDTQSO(Vacu.training.sequence.set[[i]]))
}
# Celmemb.training.set$SubCellClass = "Celmemb"
# Celwall.training.set$SubCellClass = "Celwall"
# Cyto.Golgi.training.set$SubCellClass = "Cyto.Golgi"
# Cyto.Nucl.training.set$SubCellClass = "Cyto.Nucl"
# Cyto.training.set$SubCellClass = "Cyto"
# Endoplasm.training.set$SubCellClass = "Endoplasm"
# Extracel.training.set$SubCellClass = "Extracel"
# Golgi.training.set$SubCellClass = "Golgi"
# Mito.Plastid.training.set$SubCellClass = "Mito.Plastid"
# Mito.training.set$SubCellClass = "Mito"
# Multi.SubCellClass.training.set$SubCellClass = "Multi.SubCellClass"
# Nucl.training.set$SubCellClass = "Nucl"
# Other.Dual.training.set$SubCellClass = "Other.Dual"
# Peroxi.training.set$SubCellClass = "Peroxi"
# Plastid.training.set$SubCellClass = "Plastid"
# Vacu.training.set$SubCellClass = "Vacu"


Celmemb.training.set$SubCellClass = 1
Celwall.training.set$SubCellClass = 2
Cyto.Golgi.training.set$SubCellClass = 3
Cyto.Nucl.training.set$SubCellClass = 4
Cyto.training.set$SubCellClass = 5
Endoplasm.training.set$SubCellClass = 6
Extracel.training.set$SubCellClass = 7
Golgi.training.set$SubCellClass = 8
Mito.Plastid.training.set$SubCellClass = 9
Mito.training.set$SubCellClass = 10
#Multi.SubCellClass.training.set$SubCellClass = 11
Nucl.training.set$SubCellClass = 11
Peroxi.training.set$SubCellClass = 12
Plastid.training.set$SubCellClass = 13
Vacu.training.set$SubCellClass = 14

Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
                           Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
                           Mito.Plastid.training.set, Mito.training.set, Nucl.training.set,
                           Peroxi.training.set, Plastid.training.set, Vacu.training.set)

Training.set <- subset(Total.training.set, select=-SubCellClass)
Class.labels <- Total.training.set$SubCellClass

SubCellClasses = c("Celmemb", "Celwall", "Cyto.Golgi", "Cyto.Nucl","Cyto", "Endoplasm", "Extracel", "Golgi",
                   "Mito.Plastid", "Mito", "Nucl", "Peroxi", "Plastid", "Vacu")

svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 400 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy

svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 700 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy

svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 280 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy

svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 120 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 200 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 300 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 1400 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 1400 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 1 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 40 ,gamma =5, cross =5, type = 'C', scale = FALSE)
svm.model$tot.accuracy

