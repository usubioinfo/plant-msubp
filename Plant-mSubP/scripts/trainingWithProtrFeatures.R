library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
#dir("training/sequences")

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
Multi.SubCellClass.training.sequence.set = readFASTA("training/sequences/Multi_Class_train_filter.fasta")
Nucl.training.sequence.set = readFASTA("training/sequences/Nucl_train_filter.fasta")
Peroxi.training.sequence.set = readFASTA("training/sequences/Peroxi_train_filter.fasta")
Plastid.training.sequence.set = readFASTA("training/sequences/Plastid_train_filter.fasta")
Vacu.training.sequence.set = readFASTA("training/sequences/Vacu_train_filter.fasta")

Celmemb.training.set = data.frame()
for(i in 1:length(Celmemb.training.sequence.set)){
  Celmemb.training.set = rbind(Celmemb.training.set, SequenceToAAC(Celmemb.training.sequence.set[[i]]))
}

Celwall.training.set = data.frame()
for(i in 1:length(Celwall.training.sequence.set)){
  Celwall.training.set = rbind(Celwall.training.set, SequenceToAAC(Celwall.training.sequence.set[[i]]))
}

Cyto.Golgi.training.set = data.frame()
for(i in 1:length(Cyto.Golgi.training.sequence.set)){
  Cyto.Golgi.training.set = rbind(Cyto.Golgi.training.set, SequenceToAAC(Cyto.Golgi.training.sequence.set[[i]]))
}

Cyto.Nucl.training.set = data.frame()
for(i in 1:length(Cyto.Nucl.training.sequence.set)){
  Cyto.Nucl.training.set = rbind(Cyto.Nucl.training.set, SequenceToAAC(Cyto.Nucl.training.sequence.set[[i]]))
}

Cyto.training.set = data.frame()
for(i in 1:length(Cyto.training.sequence.set)){
  Cyto.training.set = rbind(Cyto.training.set, SequenceToAAC(Cyto.training.sequence.set[[i]]))
}

Endoplasm.training.set = data.frame()
for(i in 1:length(Endoplasm.training.sequence.set)){
  Endoplasm.training.set = rbind(Endoplasm.training.set, SequenceToAAC(Endoplasm.training.sequence.set[[i]]))
}

Extracel.training.set = data.frame()
for(i in 1:length(Extracel.training.sequence.set)){
  Extracel.training.set = rbind(Extracel.training.set, SequenceToAAC(Extracel.training.sequence.set[[i]]))
}

Golgi.training.set = data.frame()
for(i in 1:length(Golgi.training.sequence.set)){
  Golgi.training.set = rbind(Golgi.training.set, SequenceToAAC(Golgi.training.sequence.set[[i]]))
}

Mito.Plastid.training.set = data.frame()
for(i in 1:length(Mito.Plastid.training.sequence.set)){
  Mito.Plastid.training.set = rbind(Mito.Plastid.training.set, SequenceToAAC(Mito.Plastid.training.sequence.set[[i]]))
}

Mito.training.set = data.frame()
for(i in 1:length(Mito.training.sequence.set)){
  Mito.training.set = rbind(Mito.training.set, SequenceToAAC(Mito.training.sequence.set[[i]]))
}

Multi.SubCellClass.training.set = data.frame()
for(i in 1:length(Multi.SubCellClass.training.sequence.set)){
  Multi.SubCellClass.training.set = rbind(Multi.SubCellClass.training.set, SequenceToAAC(Multi.SubCellClass.training.sequence.set[[i]]))
}

Nucl.training.set = data.frame()
for(i in 1:length(Nucl.training.sequence.set)){
  Nucl.training.set = rbind(Nucl.training.set, SequenceToAAC(Nucl.training.sequence.set[[i]]))
}

Peroxi.training.set = data.frame()
for(i in 1:length(Peroxi.training.sequence.set)){
  Peroxi.training.set = rbind(Peroxi.training.set, SequenceToAAC(Peroxi.training.sequence.set[[i]]))
}

Plastid.training.set = data.frame()
for(i in 1:length(Plastid.training.sequence.set)){
  Plastid.training.set = rbind(Plastid.training.set, SequenceToAAC(Plastid.training.sequence.set[[i]]))
}

Vacu.training.set = data.frame()
for(i in 1:length(Vacu.training.sequence.set)){
  Vacu.training.set = rbind(Vacu.training.set, SequenceToAAC(Vacu.training.sequence.set[[i]]))
}
Celmemb.training.set$SubCellClass = "Celmemb"
Celwall.training.set$SubCellClass = "Celwall"
Cyto.Golgi.training.set$SubCellClass = "Cyto.Golgi"
Cyto.Nucl.training.set$SubCellClass = "Cyto.Nucl"
Cyto.training.set$SubCellClass = "Cyto"
Endoplasm.training.set$SubCellClass = "Endoplasm"
Extracel.training.set$SubCellClass = "Extracel"
Golgi.training.set$SubCellClass = "Golgi"
Mito.Plastid.training.set$SubCellClass = "Mito.Plastid"
Mito.training.set$SubCellClass = "Mito"
Multi.SubCellClass.training.set$SubCellClass = "Multi.SubCellClass"
Nucl.training.set$SubCellClass = "Nucl"
Peroxi.training.set$SubCellClass = "Peroxi"
Plastid.training.set$SubCellClass = "Plastid"
Vacu.training.set$SubCellClass = "Vacu"


SubCellClasses = c("Celmemb", "Celwall", "Cyto.Golgi", "Cyto.Nucl","Cyto", "Endoplasm", "Extracel", "Golgi",
                   "Mito.Plastid", "Mito", "Multi.SubCellClass", "Nucl", "Peroxi", "Plastid", "Vacu")

Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
                           Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
                           Mito.Plastid.training.set, Mito.training.set, Multi.SubCellClass.training.set, Nucl.training.set, Peroxi.training.set, Plastid.training.set, Vacu.training.set)

Training.set <- subset(Total.training.set, select=-SubCellClass)
Class.labels <- Total.training.set$SubCellClass

svm.model = svm(Class.labels ~., Training.set, cost = 1, gamma = 5,type = 'C', scale = FALSE, probability = TRUE)
saveRDS(svm.model, file = "training/models/svmModel_SequenceToAAC.rds")
