
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
Multi.SubCellClass.testing.sequence.set = readFASTA("testing/sequences/Multi_Class_Inde.fasta")
Nucl.testing.sequence.set = readFASTA("testing/sequences/Nucl_Inde.fasta")
Other.Dual.testing.sequence.set = readFASTA("testing/sequences/Other_Dual_Inde.fasta")
Peroxi.testing.sequence.set = readFASTA("testing/sequences/Peroxi_Inde.fasta")
Plastid.testing.sequence.set = readFASTA("testing/sequences/Plastid_Inde.fasta")
Vacu.testing.sequence.set = readFASTA("testing/sequences/Vacu_Inde.fasta")

Celmemb.testing.set = data.frame()
for(i in 1:length(Celmemb.testing.sequence.set)){
  Celmemb.testing.set = rbind(Celmemb.testing.set, SequenceToNCC(Celmemb.testing.sequence.set[[i]]))
}

Celwall.testing.set = data.frame()
for(i in 1:length(Celwall.testing.sequence.set)){
  Celwall.testing.set = rbind(Celwall.testing.set, SequenceToNCC(Celwall.testing.sequence.set[[i]]))
}

Cyto.Golgi.testing.set = data.frame()
for(i in 1:length(Cyto.Golgi.testing.sequence.set)){
  Cyto.Golgi.testing.set = rbind(Cyto.Golgi.testing.set, SequenceToNCC(Cyto.Golgi.testing.sequence.set[[i]]))
}

Cyto.Nucl.testing.set = data.frame()
for(i in 1:length(Cyto.Nucl.testing.sequence.set)){
  Cyto.Nucl.testing.set = rbind(Cyto.Nucl.testing.set, SequenceToNCC(Cyto.Nucl.testing.sequence.set[[i]]))
}

Cyto.testing.set = data.frame()
for(i in 1:length(Cyto.testing.sequence.set)){
  Cyto.testing.set = rbind(Cyto.testing.set, SequenceToNCC(Cyto.testing.sequence.set[[i]]))
}

Endoplasm.testing.set = data.frame()
for(i in 1:length(Endoplasm.testing.sequence.set)){
  Endoplasm.testing.set = rbind(Endoplasm.testing.set, SequenceToNCC(Endoplasm.testing.sequence.set[[i]]))
}

Extracel.testing.set = data.frame()
for(i in 1:length(Extracel.testing.sequence.set)){
  Extracel.testing.set = rbind(Extracel.testing.set, SequenceToNCC(Extracel.testing.sequence.set[[i]]))
}

Golgi.testing.set = data.frame()
for(i in 1:length(Golgi.testing.sequence.set)){
  Golgi.testing.set = rbind(Golgi.testing.set, SequenceToNCC(Golgi.testing.sequence.set[[i]]))
}

Mito.Plastid.testing.set = data.frame()
for(i in 1:length(Mito.Plastid.testing.sequence.set)){
  Mito.Plastid.testing.set = rbind(Mito.Plastid.testing.set, SequenceToNCC(Mito.Plastid.testing.sequence.set[[i]]))
}

Mito.testing.set = data.frame()
for(i in 1:length(Mito.testing.sequence.set)){
  Mito.testing.set = rbind(Mito.testing.set, SequenceToNCC(Mito.testing.sequence.set[[i]]))
}


Nucl.testing.set = data.frame()
for(i in 1:length(Nucl.testing.sequence.set)){
  Nucl.testing.set = rbind(Nucl.testing.set, SequenceToNCC(Nucl.testing.sequence.set[[i]]))
}


Peroxi.testing.set = data.frame()
for(i in 1:length(Peroxi.testing.sequence.set)){
  Peroxi.testing.set = rbind(Peroxi.testing.set, SequenceToNCC(Peroxi.testing.sequence.set[[i]]))
}

Plastid.testing.set = data.frame()
for(i in 1:length(Plastid.testing.sequence.set)){
  Plastid.testing.set = rbind(Plastid.testing.set, SequenceToNCC(Plastid.testing.sequence.set[[i]]))
}

Vacu.testing.set = data.frame()
for(i in 1:length(Vacu.testing.sequence.set)){
  Vacu.testing.set = rbind(Vacu.testing.set, SequenceToNCC(Vacu.testing.sequence.set[[i]]))
}

features.vector.size = ncol(Vacu.testing.set)

# Celmemb.testing.set = as.data.frame(scale(Celmemb.testing.set))
# Celwall.testing.set = as.data.frame(scale(Celwall.testing.set))
# Cyto.Golgi.testing.set = as.data.frame(scale(Cyto.Golgi.testing.set))
# Cyto.Nucl.testing.set = as.data.frame(scale(Cyto.Nucl.testing.set))
# Cyto.testing.set = as.data.frame(scale(Cyto.testing.set))
# Endoplasm.testing.set = as.data.frame(scale(Endoplasm.testing.set))
# Extracel.testing.set = as.data.frame(scale(Extracel.testing.set))
# Golgi.testing.set = as.data.frame(scale(Golgi.testing.set))
# Mito.Plastid.testing.set = as.data.frame(scale(Mito.Plastid.testing.set))
# Mito.testing.set = as.data.frame(scale(Mito.testing.set))
# Nucl.testing.set = as.data.frame(scale(Nucl.testing.set))
# Peroxi.testing.set = as.data.frame(scale(Peroxi.testing.set))
# Plastid.testing.set = as.data.frame(scale(Plastid.testing.set))
# Vacu.testing.set = as.data.frame(scale(Vacu.testing.set))
# 
Celmemb.testing.set$SubCellClass = "Celmemb"
Celwall.testing.set$SubCellClass = "Celwall"
Cyto.Golgi.testing.set$SubCellClass = "Cyto.Golgi"
Cyto.Nucl.testing.set$SubCellClass = "Cyto.Nucl"
Cyto.testing.set$SubCellClass = "Cyto"
Endoplasm.testing.set$SubCellClass = "Endoplasm"
Extracel.testing.set$SubCellClass = "Extracel"
Golgi.testing.set$SubCellClass = "Golgi"
Mito.Plastid.testing.set$SubCellClass = "Mito.Plastid"
Mito.testing.set$SubCellClass = "Mito"
Nucl.testing.set$SubCellClass = "Nucl"
Peroxi.testing.set$SubCellClass = "Peroxi"
Plastid.testing.set$SubCellClass = "Plastid"
Vacu.testing.set$SubCellClass = "Vacu"


Celmemb.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Celmemb.testing.set)-1)){
  Celmemb.testing.set[,i] = paste(Celmemb.testing.set.colnames[i],Celmemb.testing.set[,i],sep = ":")
}
Celmemb.testing.set[,(features.vector.size+1)] = 1
Celmemb.testing.set= Celmemb.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Celwall.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Celwall.testing.set)-1)){
  Celwall.testing.set[,i] = paste(Celwall.testing.set.colnames[i],Celwall.testing.set[,i],sep = ":")
}
Celwall.testing.set[,(features.vector.size+1)] = 2
Celwall.testing.set= Celwall.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Cyto.Golgi.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Cyto.Golgi.testing.set)-1)){
  Cyto.Golgi.testing.set[,i] = paste(Cyto.Golgi.testing.set.colnames[i],Cyto.Golgi.testing.set[,i],sep = ":")
}
Cyto.Golgi.testing.set[,(features.vector.size+1)] = 3
Cyto.Golgi.testing.set= Cyto.Golgi.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Cyto.Nucl.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Cyto.Nucl.testing.set)-1)){
  Cyto.Nucl.testing.set[,i] = paste(Cyto.Nucl.testing.set.colnames[i],Cyto.Nucl.testing.set[,i],sep = ":")
}
Cyto.Nucl.testing.set[,(features.vector.size+1)] = 4
Cyto.Nucl.testing.set= Cyto.Nucl.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Cyto.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Cyto.testing.set)-1)){
  Cyto.testing.set[,i] = paste(Cyto.testing.set.colnames[i],Cyto.testing.set[,i],sep = ":")
}
Cyto.testing.set[,(features.vector.size+1)] = 5
Cyto.testing.set= Cyto.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Endoplasm.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Endoplasm.testing.set)-1)){
  Endoplasm.testing.set[,i] = paste(Endoplasm.testing.set.colnames[i],Endoplasm.testing.set[,i],sep = ":")
}
Endoplasm.testing.set[,(features.vector.size+1)] = 6
Endoplasm.testing.set= Endoplasm.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Extracel.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Extracel.testing.set)-1)){
  Extracel.testing.set[,i] = paste(Extracel.testing.set.colnames[i],Extracel.testing.set[,i],sep = ":")
}
Extracel.testing.set[,(features.vector.size+1)] = 7
Extracel.testing.set= Extracel.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Golgi.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Golgi.testing.set)-1)){
  Golgi.testing.set[,i] = paste(Golgi.testing.set.colnames[i],Golgi.testing.set[,i],sep = ":")
}
Golgi.testing.set[,(features.vector.size+1)] = 8
Golgi.testing.set= Golgi.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Mito.Plastid.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Mito.Plastid.testing.set)-1)){
  Mito.Plastid.testing.set[,i] = paste(Mito.Plastid.testing.set.colnames[i],Mito.Plastid.testing.set[,i],sep = ":")
}
Mito.Plastid.testing.set[,(features.vector.size+1)] = 9
Mito.Plastid.testing.set= Mito.Plastid.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Mito.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Mito.testing.set)-1)){
  Mito.testing.set[,i] = paste(Mito.testing.set.colnames[i],Mito.testing.set[,i],sep = ":")
}
Mito.testing.set[,(features.vector.size+1)] = 10
Mito.testing.set= Mito.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Nucl.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Nucl.testing.set)-1)){
  Nucl.testing.set[,i] = paste(Nucl.testing.set.colnames[i],Nucl.testing.set[,i],sep = ":")
}
Nucl.testing.set[,(features.vector.size+1)] = 11
Nucl.testing.set= Nucl.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Peroxi.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Peroxi.testing.set)-1)){
  Peroxi.testing.set[,i] = paste(Peroxi.testing.set.colnames[i],Peroxi.testing.set[,i],sep = ":")
}
Peroxi.testing.set[,(features.vector.size+1)] = 12
Peroxi.testing.set= Peroxi.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Plastid.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Plastid.testing.set)-1)){
  Plastid.testing.set[,i] = paste(Plastid.testing.set.colnames[i],Plastid.testing.set[,i],sep = ":")
}
Plastid.testing.set[,(features.vector.size+1)] = 13
Plastid.testing.set= Plastid.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Vacu.testing.set.colnames = c(1:features.vector.size,"SubCellClass")
for(i in 1:(ncol(Vacu.testing.set)-1)){
  Vacu.testing.set[,i] = paste(Vacu.testing.set.colnames[i],Vacu.testing.set[,i],sep = ":")
}
Vacu.testing.set[,(features.vector.size+1)] = 14
Vacu.testing.set= Vacu.testing.set[,c((features.vector.size+1),1:features.vector.size)]

Total.testing.set = rbind(Celmemb.testing.set, Celwall.testing.set, Cyto.Golgi.testing.set, Cyto.Nucl.testing.set,
                          Cyto.testing.set, Endoplasm.testing.set, Extracel.testing.set, Golgi.testing.set,
                          Mito.Plastid.testing.set, Mito.testing.set, Nucl.testing.set, Peroxi.testing.set, Plastid.testing.set, Vacu.testing.set)

Class.testing.set = Total.testing.set
Class.testing.set.colnames = colnames(Class.testing.set)

#92,5,4,20,39,28,14,23,13,52,63,6,247,20,626
testing.set = Class.testing.set
testing.set$SubCellClass = -1
write.table(testing.set, file = "testing/models/NCC/SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)


testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 1,1] = -1
testing.set[ testing.set$SubCellClass == 1,1] = 1
write.table(testing.set, file = "testing/models/NCC/Celmemb_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 2,1] = -1
testing.set[ testing.set$SubCellClass == 2,1] = 1
write.table(testing.set, file = "testing/models/NCC/Celwall_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 3,1] = -1
testing.set[ testing.set$SubCellClass == 3,1] = 1
write.table(testing.set, file = "testing/models/NCC/Cyto.Golgi_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 4,1] = -1
testing.set[ testing.set$SubCellClass == 4,1] = 1
write.table(testing.set, file = "testing/models/NCC/Cyto.Nucl_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 5,1] = -1
testing.set[ testing.set$SubCellClass == 5,1] = 1
write.table(testing.set, file = "testing/models/NCC/Cyto_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 6,1] = -1
testing.set[ testing.set$SubCellClass == 6,1] = 1
write.table(testing.set, file = "testing/models/NCC/Endoplasm_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 7,1] = -1
testing.set[ testing.set$SubCellClass == 7,1] = 1
write.table(testing.set, file = "testing/models/NCC/Extracel_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 8,1] = -1
testing.set[ testing.set$SubCellClass == 8,1] = 1
write.table(testing.set, file = "testing/models/NCC/Golgi_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 9,1] = -1
testing.set[ testing.set$SubCellClass == 9,1] = 1
write.table(testing.set, file = "testing/models/NCC/Mito.Plastid_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 10,1] = -1
testing.set[ testing.set$SubCellClass == 10,1] = 1
write.table(testing.set, file = "testing/models/NCC/Mito_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 11,1] = -1
testing.set[ testing.set$SubCellClass == 11,1] = 1
write.table(testing.set, file = "testing/models/NCC/Nucl_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 12,1] = -1
testing.set[ testing.set$SubCellClass == 12,1] = 1
write.table(testing.set, file = "testing/models/NCC/Peroxi_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 13,1] = -1
testing.set[ testing.set$SubCellClass == 13,1] = 1
write.table(testing.set, file = "testing/models/NCC/Plastid_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)

testing.set = Class.testing.set
testing.set[ testing.set$SubCellClass != 14,1] = -1
testing.set[ testing.set$SubCellClass == 14,1] = 1
write.table(testing.set, file = "testing/models/NCC/Vacu_SequenceToNCC_Singletesting_svmlight.txt", quote = FALSE,
            sep = " ", row.names = FALSE, col.names = FALSE)