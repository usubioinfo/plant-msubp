
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


Celmemb.prediction = predict(svm.model, Celmemb.testing.set)
Celwall.prediction = predict(svm.model, Celwall.testing.set)
Cyto.Golgi.prediction = predict(svm.model, Cyto.Golgi.testing.set)
Cyto.Nucl.prediction = predict(svm.model, Cyto.Nucl.testing.set)
Cyto.prediction = predict(svm.model, Cyto.testing.set)
Endoplasm.prediction = predict(svm.model, Endoplasm.testing.set)
Extracel.prediction = predict(svm.model, Extracel.testing.set)
Golgi.prediction = predict(svm.model, Golgi.testing.set)
Mito.Plastid.prediction = predict(svm.model, Mito.Plastid.testing.set)
Mito.prediction = predict(svm.model, Mito.testing.set)
#Multi.SubCellClass.prediction = predict(svm.model, Multi.SubCellClass.testing.set)
Nucl.prediction = predict(svm.model, Nucl.testing.set)
#Other.Dual.prediction = predict(svm.model, Other.Dual.testing.set)
Peroxi.prediction = predict(svm.model, Peroxi.testing.set)
Plastid.prediction = predict(svm.model, Plastid.testing.set)
Vacu.prediction = predict(svm.model, Vacu.testing.set)

predicted = 0
total = 0
# predicted = predicted + sum(Celmemb.prediction == "Celmemb")
# predicted = predicted + sum(Celwall.prediction == "Celwall")
# predicted = predicted + sum(Cyto.Golgi.prediction == "Cyto.Golgi")
# predicted = predicted + sum(Cyto.Nucl.prediction == "Cyto.Nucl")
# predicted = predicted + sum(Cyto.prediction == "Cyto")
# predicted = predicted + sum(Endoplasm.prediction == "Endoplasm")
# predicted = predicted + sum(Extracel.prediction == "Extracel")
# predicted = predicted + sum(Golgi.prediction == "Golgi")
# predicted = predicted + sum(Mito.Plastid.prediction == "Mito.Plastid")
# predicted = predicted + sum(Mito.prediction == "Mito")
# #predicted = predicted + sum(Multi.SubCellClass.prediction == "Multi.SubCellClass")
# predicted = predicted + sum(Nucl.prediction == "Nucl")
# #predicted = predicted + sum(Other.Dual.prediction == "Other.Dual")
# predicted = predicted + sum(Peroxi.prediction == "Peroxi")
# predicted = predicted + sum(Plastid.prediction == "Plastid")
# predicted = predicted + sum(Vacu.prediction == "Vacu")

predicted = predicted + sum(Celmemb.prediction == "1")
predicted = predicted + sum(Celwall.prediction == "2")
predicted = predicted + sum(Cyto.Golgi.prediction == "3")
predicted = predicted + sum(Cyto.Nucl.prediction == "4")
predicted = predicted + sum(Cyto.prediction == "5")
predicted = predicted + sum(Endoplasm.prediction == "6")
predicted = predicted + sum(Extracel.prediction == "7")
predicted = predicted + sum(Golgi.prediction == "8")
predicted = predicted + sum(Mito.Plastid.prediction == "9")
predicted = predicted + sum(Mito.prediction == "10")
#predicted = predicted + sum(Multi.SubCellClass.prediction == "Multi.SubCellClass")
predicted = predicted + sum(Nucl.prediction == "11")
#predicted = predicted + sum(Other.Dual.prediction == "Other.Dual")
predicted = predicted + sum(Peroxi.prediction == "12")
predicted = predicted + sum(Plastid.prediction == "13")
predicted = predicted + sum(Vacu.prediction == "14")

# total = length(Celmemb.prediction)+length(Celwall.prediction)+length(Cyto.Golgi.prediction)+
#   length(Cyto.Nucl.prediction)+length(Cyto.prediction)+length(Endoplasm.prediction)+length(Extracel.prediction)+
#   length(Golgi.prediction)+length(Mito.Plastid.prediction)+length(Mito.Plastid.prediction)+length(Multi.SubCellClass.prediction)+
#   length(Nucl.prediction)+length(Other.Dual.prediction)+length(Peroxi.prediction)+length(Plastid.prediction)+
#   length(Vacu.prediction)

total = length(Celmemb.prediction)+length(Celwall.prediction)+length(Cyto.Golgi.prediction)+
  length(Cyto.Nucl.prediction)+length(Cyto.prediction)+length(Endoplasm.prediction)+length(Extracel.prediction)+
  length(Golgi.prediction)+length(Mito.Plastid.prediction)+length(Mito.prediction)+length(Plastid.prediction)+
  length(Nucl.prediction)+length(Peroxi.prediction)+length(Vacu.prediction)


sum(Celmemb.prediction == "1")/length(Celmemb.prediction)
sum(Celwall.prediction == "2")/length(Celwall.prediction)
sum(Cyto.Golgi.prediction == "3")/length(Cyto.Golgi.prediction)
sum(Cyto.Nucl.prediction == "4")/length(Cyto.Nucl.prediction)
sum(Cyto.prediction == "5")/length(Cyto.prediction)
sum(Endoplasm.prediction == "6")/length(Endoplasm.prediction)
sum(Extracel.prediction == "7")/length(Extracel.prediction)
sum(Golgi.prediction == "8")/length(Golgi.prediction)
sum(Mito.Plastid.prediction == "9")/length(Mito.Plastid.prediction)
sum(Mito.prediction == "10")/length(Mito.prediction)
sum(Plastid.prediction == "13")/length(Plastid.prediction)
sum(Nucl.prediction == "11")/length(Nucl.prediction)
sum(Peroxi.prediction == "12")/length(Peroxi.prediction)
sum(Vacu.prediction == "14")/length(Vacu.prediction)
predicted/total