library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
column.feature.number = 30

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
  Celmemb.training.set = rbind(Celmemb.training.set, SequenceToPseAAC(Celmemb.training.sequence.set[[i]]))
}

Celwall.training.set = data.frame()
for(i in 1:length(Celwall.training.sequence.set)){
  Celwall.training.set = rbind(Celwall.training.set, SequenceToPseAAC(Celwall.training.sequence.set[[i]]))
}

Cyto.Golgi.training.set = data.frame()
for(i in 1:length(Cyto.Golgi.training.sequence.set)){
  Cyto.Golgi.training.set = rbind(Cyto.Golgi.training.set, SequenceToPseAAC(Cyto.Golgi.training.sequence.set[[i]]))
}

Cyto.Nucl.training.set = data.frame()
for(i in 1:length(Cyto.Nucl.training.sequence.set)){
  Cyto.Nucl.training.set = rbind(Cyto.Nucl.training.set, SequenceToPseAAC(Cyto.Nucl.training.sequence.set[[i]]))
}

Cyto.training.set = data.frame()
for(i in 1:length(Cyto.training.sequence.set)){
  Cyto.training.set = rbind(Cyto.training.set, SequenceToPseAAC(Cyto.training.sequence.set[[i]]))
}

Endoplasm.training.set = data.frame()
for(i in 1:length(Endoplasm.training.sequence.set)){
  Endoplasm.training.set = rbind(Endoplasm.training.set, SequenceToPseAAC(Endoplasm.training.sequence.set[[i]]))
}

Extracel.training.set = data.frame()
for(i in 1:length(Extracel.training.sequence.set)){
  Extracel.training.set = rbind(Extracel.training.set, SequenceToPseAAC(Extracel.training.sequence.set[[i]]))
}

Golgi.training.set = data.frame()
for(i in 1:length(Golgi.training.sequence.set)){
  Golgi.training.set = rbind(Golgi.training.set, SequenceToPseAAC(Golgi.training.sequence.set[[i]]))
}

Mito.Plastid.training.set = data.frame()
for(i in 1:length(Mito.Plastid.training.sequence.set)){
  Mito.Plastid.training.set = rbind(Mito.Plastid.training.set, SequenceToPseAAC(Mito.Plastid.training.sequence.set[[i]]))
}

Mito.training.set = data.frame()
for(i in 1:length(Mito.training.sequence.set)){
  Mito.training.set = rbind(Mito.training.set, SequenceToPseAAC(Mito.training.sequence.set[[i]]))
}

# Multi.SubCellClass.training.set = data.frame()
# for(i in 1:length(Multi.SubCellClass.training.sequence.set)){
#   Multi.SubCellClass.training.set = rbind(Multi.SubCellClass.training.set, SequenceToPseAAC(Multi.SubCellClass.training.sequence.set[[i]]))
# }

Nucl.training.set = data.frame()
for(i in 1:length(Nucl.training.sequence.set)){
  Nucl.training.set = rbind(Nucl.training.set, SequenceToPseAAC(Nucl.training.sequence.set[[i]]))
}


Peroxi.training.set = data.frame()
for(i in 1:length(Peroxi.training.sequence.set)){
  Peroxi.training.set = rbind(Peroxi.training.set, SequenceToPseAAC(Peroxi.training.sequence.set[[i]]))
}

Plastid.training.set = data.frame()
for(i in 1:length(Plastid.training.sequence.set)){
  Plastid.training.set = rbind(Plastid.training.set, SequenceToPseAAC(Plastid.training.sequence.set[[i]]))
}

Vacu.training.set = data.frame()
for(i in 1:length(Vacu.training.sequence.set)){
  Vacu.training.set = rbind(Vacu.training.set, SequenceToPseAAC(Vacu.training.sequence.set[[i]]))
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

# Celmemb.training.set = as.data.frame(scale(Celmemb.training.set))
# Celwall.training.set = as.data.frame(scale(Celwall.training.set))
# Cyto.Golgi.training.set = as.data.frame(scale(Cyto.Golgi.training.set))
# Cyto.Nucl.training.set = as.data.frame(scale(Cyto.Nucl.training.set))
# Cyto.training.set = as.data.frame(scale(Cyto.training.set))
# Endoplasm.training.set = as.data.frame(scale(Endoplasm.training.set))
# Extracel.training.set = as.data.frame(scale(Extracel.training.set))
# Golgi.training.set = as.data.frame(scale(Golgi.training.set))
# Mito.Plastid.training.set = as.data.frame(scale(Mito.Plastid.training.set))
# Mito.training.set = as.data.frame(scale(Mito.training.set))
# Nucl.training.set = as.data.frame(scale(Nucl.training.set))
# Peroxi.training.set = as.data.frame(scale(Peroxi.training.set))
# Plastid.training.set = as.data.frame(scale(Plastid.training.set))
# Vacu.training.set = as.data.frame(scale(Vacu.training.set))



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


SubCellClasses = c("Celmemb", "Celwall", "Cyto.Golgi", "Cyto.Nucl","Cyto", "Endoplasm", "Extracel", "Golgi",
                   "Mito.Plastid", "Mito", "Nucl", "Peroxi", "Plastid", "Vacu")


DTSplitter <- function(training.dataframe) {
  
  group.reminders = nrow(training.dataframe) %% 5
  group.size = (nrow(training.dataframe) - group.reminders ) / 5
  group.dividing.factor = c(sample(rep(1:5, group.size)),rep(1:5, len = group.reminders))
  training.dataframe.five.fold = split(training.dataframe, group.dividing.factor)
  
  training.dataframe.five.fold
  
}

Celmemb.training.set.five.fold = DTSplitter(Celmemb.training.set)
Celwall.training.set.five.fold = DTSplitter(Celwall.training.set)
Cyto.Golgi.training.set.five.fold = DTSplitter(Cyto.Golgi.training.set)
Cyto.Nucl.training.set.five.fold = DTSplitter(Cyto.Nucl.training.set)
Cyto.training.set.five.fold = DTSplitter(Cyto.training.set)
Endoplasm.training.set.five.fold = DTSplitter(Endoplasm.training.set)
Extracel.training.set.five.fold = DTSplitter(Extracel.training.set)
Golgi.training.set.five.fold = DTSplitter(Golgi.training.set)
Mito.Plastid.training.set.five.fold = DTSplitter(Mito.Plastid.training.set)
Mito.training.set.five.fold = DTSplitter(Mito.training.set)
#Multi.SubCellClass.training.set.five.fold = DTSplitter(Multi.SubCellClass.training.set)
Nucl.training.set.five.fold = DTSplitter(Nucl.training.set)
Peroxi.training.set.five.fold = DTSplitter(Peroxi.training.set)
Plastid.training.set.five.fold = DTSplitter(Plastid.training.set)
Vacu.training.set.five.fold = DTSplitter(Vacu.training.set)

dir.create("training/models/PseAACSingleModels", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Celmemb", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Celwall", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Cyto.Golgi", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Cyto.Nucl", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Cyto", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Endoplasm", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Extracel", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Golgi", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Mito.Plastid", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Mito", showWarnings = FALSE)
#dir.create("training/models/SingleModels/Multi.SubCellClass", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Nucl", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Peroxi", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Plastid", showWarnings = FALSE)
dir.create("training/models/PseAACSingleModels/Vacu", showWarnings = FALSE)

Total.training.set = c()
for(i in 1:5){
  
  Five.fold.training.set = rbind(Celmemb.training.set.five.fold[[i]], Celwall.training.set.five.fold[[i]], Cyto.Golgi.training.set.five.fold[[i]], Cyto.Nucl.training.set.five.fold[[i]],
                             Cyto.training.set.five.fold[[i]], Endoplasm.training.set.five.fold[[i]], Extracel.training.set.five.fold[[i]], Golgi.training.set.five.fold[[i]],
                             Mito.Plastid.training.set.five.fold[[i]], Mito.training.set.five.fold[[i]], Nucl.training.set.five.fold[[i]],
                             Peroxi.training.set.five.fold[[i]], Plastid.training.set.five.fold[[i]], Vacu.training.set.five.fold[[i]])

  Class.training.set = Five.fold.training.set
  Class.training.set.colnames = colnames(Class.training.set)
  
  for(j in 1:(ncol(Class.training.set)-1)){
    Class.training.set[,j] = paste(j,Class.training.set[,j],sep = ":")
  }
  
  for(j in 1:length(SubCellClasses)){
    Class.training.set[Class.training.set$SubCellClass == SubCellClasses[j],(column.feature.number+1)] = j
  }
  
  Class.training.set= Class.training.set[,c((column.feature.number+1),1:column.feature.number)]
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 1,1] = -1
  Training.set[ Training.set$SubCellClass == 1,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Celmemb/Celmemb_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 2,1] = -1
  Training.set[ Training.set$SubCellClass == 2,1] = 1
   write.table(Training.set, file = paste("training/models/PseAACSingleModels/Celwall/Celwall_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 3,1] = -1
  Training.set[ Training.set$SubCellClass == 3,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Cyto.Golgi/Cyto.Golgi_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 4,1] = -1
  Training.set[ Training.set$SubCellClass == 4,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Cyto.Nucl/Cyto.Nucl_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 5,1] = -1
  Training.set[ Training.set$SubCellClass == 5,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Cyto/Cyto_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 6,1] = -1
  Training.set[ Training.set$SubCellClass == 6,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Endoplasm/Endoplasm_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 7,1] = -1
  Training.set[ Training.set$SubCellClass == 7,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Extracel/Extracel_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 8,1] = -1
  Training.set[ Training.set$SubCellClass == 8,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Golgi/Golgi_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 9,1] = -1
  Training.set[ Training.set$SubCellClass == 9,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Mito.Plastid/Mito.Plastid_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 10,1] = -1
  Training.set[ Training.set$SubCellClass == 10,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Mito/Mito_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  # 
  # Training.set = Class.training.set
  # Training.set[ Training.set$SubCellClass != 11,1] = -1
  # Training.set[ Training.set$SubCellClass == 11,1] = 1
  # write.table(Training.set, file = paste("training/models/SingleModels/Multi.SubCellClass/Multi.SubCellClass_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
  #             sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 11,1] = -1
  Training.set[ Training.set$SubCellClass == 11,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Nucl/Nucl_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 12,1] = -1
  Training.set[ Training.set$SubCellClass == 12,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Peroxi/Peroxi_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 13,1] = -1
  Training.set[ Training.set$SubCellClass == 13,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Plastid/Plastid_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  Training.set = Class.training.set
  Training.set[ Training.set$SubCellClass != 14,1] = -1
  Training.set[ Training.set$SubCellClass == 14,1] = 1
  write.table(Training.set, file = paste("training/models/PseAACSingleModels/Vacu/Vacu_SequenceToPseAAC_SingleTraining_svmlight",i,".txt",sep=""), quote = FALSE,
              sep = " ", row.names = FALSE, col.names = FALSE)
  
  
}

# Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
#                            Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
#                            Mito.Plastid.training.set, Mito.training.set, Multi.SubCellClass.training.set, Nucl.training.set,
#                            Peroxi.training.set, Plastid.training.set, Vacu.training.set)

