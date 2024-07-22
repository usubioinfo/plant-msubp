#!/usr/bin/env Rscript

library('e1071')
library('protr')
source("scripts/sequence_to_feature.R")
dir.create("training/features/CTDT", recursive = TRUE, showWarnings = FALSE)
dir.create("testing/models/CTDT", recursive = TRUE, showWarnings = FALSE)
#column.feature.number = 400

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
  Celmemb.training.set = rbind(Celmemb.training.set, SequenceToCTDT(Celmemb.training.sequence.set[[i]]))
}

Celwall.training.set = data.frame()
for(i in 1:length(Celwall.training.sequence.set)){
  Celwall.training.set = rbind(Celwall.training.set, SequenceToCTDT(Celwall.training.sequence.set[[i]]))
}

Cyto.Golgi.training.set = data.frame()
for(i in 1:length(Cyto.Golgi.training.sequence.set)){
  Cyto.Golgi.training.set = rbind(Cyto.Golgi.training.set, SequenceToCTDT(Cyto.Golgi.training.sequence.set[[i]]))
}

Cyto.Nucl.training.set = data.frame()
for(i in 1:length(Cyto.Nucl.training.sequence.set)){
  Cyto.Nucl.training.set = rbind(Cyto.Nucl.training.set, SequenceToCTDT(Cyto.Nucl.training.sequence.set[[i]]))
}

Cyto.training.set = data.frame()
for(i in 1:length(Cyto.training.sequence.set)){
  Cyto.training.set = rbind(Cyto.training.set, SequenceToCTDT(Cyto.training.sequence.set[[i]]))
}

Endoplasm.training.set = data.frame()
for(i in 1:length(Endoplasm.training.sequence.set)){
  Endoplasm.training.set = rbind(Endoplasm.training.set, SequenceToCTDT(Endoplasm.training.sequence.set[[i]]))
}

Extracel.training.set = data.frame()
for(i in 1:length(Extracel.training.sequence.set)){
  Extracel.training.set = rbind(Extracel.training.set, SequenceToCTDT(Extracel.training.sequence.set[[i]]))
}

Golgi.training.set = data.frame()
for(i in 1:length(Golgi.training.sequence.set)){
  Golgi.training.set = rbind(Golgi.training.set, SequenceToCTDT(Golgi.training.sequence.set[[i]]))
}

Mito.Plastid.training.set = data.frame()
for(i in 1:length(Mito.Plastid.training.sequence.set)){
  Mito.Plastid.training.set = rbind(Mito.Plastid.training.set, SequenceToCTDT(Mito.Plastid.training.sequence.set[[i]]))
}

Mito.training.set = data.frame()
for(i in 1:length(Mito.training.sequence.set)){
  Mito.training.set = rbind(Mito.training.set, SequenceToCTDT(Mito.training.sequence.set[[i]]))
}

# Multi.SubCellClass.training.set = data.frame()
# for(i in 1:length(Multi.SubCellClass.training.sequence.set)){
#   Multi.SubCellClass.training.set = rbind(Multi.SubCellClass.training.set, SequenceToCTDT(Multi.SubCellClass.training.sequence.set[[i]]))
# }

Nucl.training.set = data.frame()
for(i in 1:length(Nucl.training.sequence.set)){
  Nucl.training.set = rbind(Nucl.training.set, SequenceToCTDT(Nucl.training.sequence.set[[i]]))
}


Peroxi.training.set = data.frame()
for(i in 1:length(Peroxi.training.sequence.set)){
  Peroxi.training.set = rbind(Peroxi.training.set, SequenceToCTDT(Peroxi.training.sequence.set[[i]]))
}

Plastid.training.set = data.frame()
for(i in 1:length(Plastid.training.sequence.set)){
  Plastid.training.set = rbind(Plastid.training.set, SequenceToCTDT(Plastid.training.sequence.set[[i]]))
}

Vacu.training.set = data.frame()
for(i in 1:length(Vacu.training.sequence.set)){
  Vacu.training.set = rbind(Vacu.training.set, SequenceToCTDT(Vacu.training.sequence.set[[i]]))
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

# Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
#                            Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
#                            Mito.Plastid.training.set, Mito.training.set, Multi.SubCellClass.training.set, Nucl.training.set,
#                            Peroxi.training.set, Plastid.training.set, Vacu.training.set)

Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Endoplasm.training.set, Extracel.training.set,
                           Golgi.training.set, Mito.training.set, Nucl.training.set, Peroxi.training.set,
                           Plastid.training.set, Vacu.training.set, Cyto.training.set, Cyto.Golgi.training.set,
                           Cyto.Nucl.training.set, Mito.Plastid.training.set)

write.table(Celmemb.training.set, file = paste("training/features/CTDT/CTDTfeature_Celmemb_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Celwall.training.set, file = paste("training/features/CTDT/CTDTfeature_Celwall_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Endoplasm.training.set, file = paste("training/features/CTDT/CTDTfeature_Endoplasm_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Extracel.training.set, file = paste("training/features/CTDT/CTDTfeature_Extracel_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Golgi.training.set, file = paste("training/features/CTDT/CTDTfeature_Golgi_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Mito.training.set, file = paste("training/features/CTDT/CTDTfeature_Mito_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Nucl.training.set, file = paste("training/features/CTDT/CTDTfeature_Nucl_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Peroxi.training.set, file = paste("training/features/CTDT/CTDTfeature_Peroxi_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Plastid.training.set, file = paste("training/features/CTDT/CTDTfeature_Plastid_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Vacu.training.set, file = paste("training/features/CTDT/CTDTfeature_Vacu_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.training.set, file = paste("training/features/CTDT/CTDTfeature_Cyto_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.Golgi.training.set, file = paste("training/features/CTDT/CTDTfeature_Cyto_Golgi_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.Nucl.training.set, file = paste("training/features/CTDT/CTDTfeature_Cyto_Nucl_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Mito.Plastid.training.set, file = paste("training/features/CTDT/CTDTfeature_Mito_Plastid_train.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

Celmemb.testing.sequence.set = readFASTA("testing/sequences/Celmemb_Inde.fasta")
Celwall.testing.sequence.set = readFASTA("testing/sequences/Celwall_Inde.fasta")
Cyto.Golgi.testing.sequence.set = readFASTA("testing/sequences/Cyto_Golgi_Inde.fasta")
Cyto.Nucl.testing.sequence.set = readFASTA("testing/sequences/Cyto_Nucl_Inde.fasta")
Cyto.testing.sequence.set = readFASTA("testing/sequences/Cyto_Inde.fasta")
Endoplasm.testing.sequence.set = readFASTA("testing/sequences/Endoplasm_Inde.fasta")
Extracel.testing.sequence.set = readFASTA("testing/sequences/Extracel_Inde.fasta")
Golgi.testing.sequence.set = readFASTA("testing/sequences/Golgi_Inde.fasta")
Mito.Plastid.testing.sequence.set = readFASTA("testing/sequences/Mito_Plastid_Inde.fasta")
Mito.testing.sequence.set = readFASTA("testing/sequences/Mito_Inde.fasta")
#Multi.SubCellClass.testing.sequence.set = readFASTA("testing/sequences/Multi_Class_Inde.fasta")
Nucl.testing.sequence.set = readFASTA("testing/sequences/Nucl_Inde.fasta")
#Other.Dual.testing.sequence.set = readFASTA("testing/sequences/Other_Dual_Inde.fasta")
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

Cyto.Golgi.testing.set = data.frame()
for(i in 1:length(Cyto.Golgi.testing.sequence.set)){
  Cyto.Golgi.testing.set = rbind(Cyto.Golgi.testing.set, SequenceToCTDT(Cyto.Golgi.testing.sequence.set[[i]]))
}

Cyto.Nucl.testing.set = data.frame()
for(i in 1:length(Cyto.Nucl.testing.sequence.set)){
  Cyto.Nucl.testing.set = rbind(Cyto.Nucl.testing.set, SequenceToCTDT(Cyto.Nucl.testing.sequence.set[[i]]))
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

Mito.Plastid.testing.set = data.frame()
for(i in 1:length(Mito.Plastid.testing.sequence.set)){
  Mito.Plastid.testing.set = rbind(Mito.Plastid.testing.set, SequenceToCTDT(Mito.Plastid.testing.sequence.set[[i]]))
}

Mito.testing.set = data.frame()
for(i in 1:length(Mito.testing.sequence.set)){
  Mito.testing.set = rbind(Mito.testing.set, SequenceToCTDT(Mito.testing.sequence.set[[i]]))
}

# Multi.SubCellClass.testing.set = data.frame()
# for(i in 1:length(Multi.SubCellClass.testing.sequence.set)){
#   Multi.SubCellClass.testing.set = rbind(Multi.SubCellClass.testing.set, SequenceToCTDT(Multi.SubCellClass.testing.sequence.set[[i]]))
# }

Nucl.testing.set = data.frame()
for(i in 1:length(Nucl.testing.sequence.set)){
  Nucl.testing.set = rbind(Nucl.testing.set, SequenceToCTDT(Nucl.testing.sequence.set[[i]]))
}

# Other.Dual.testing.set = data.frame()
# for(i in 1:length(Other.Dual.testing.sequence.set)){
#   Other.Dual.testing.set = rbind(Other.Dual.testing.set, SequenceToCTDT(Other.Dual.testing.sequence.set[[i]]))
# }

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

write.table(Celmemb.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Celmemb_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Celwall.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Celwall_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Endoplasm.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Endoplasm_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Extracel.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Extracel_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Golgi.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Golgi_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Mito.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Mito_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Nucl.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Nucl_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Peroxi.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Peroxi_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Plastid.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Plastid_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Vacu.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Vacu_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Cyto_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.Golgi.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Cyto_Golgi_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Cyto.Nucl.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Cyto_Nucl_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
write.table(Mito.Plastid.testing.set, file = paste("testing/models/CTDT/CTDTfeature_Mito_Plastid_Inde.txt",sep=""), quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)
