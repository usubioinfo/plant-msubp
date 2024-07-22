library('e1071')

dir("training/features/")

Celmemb.training.set = read.csv("training/features/PseAACNCCDIPEP_Celmemb_train.csv", header = FALSE)
Celwall.training.set = read.csv("training/features/PseAACNCCDIPEP_Celwall_train.csv", header = FALSE)
Cyto.Golgi.training.set = read.csv("training/features/PseAACNCCDIPEP_Cyto_Golgi_train.csv", header = FALSE)
Cyto.Nucl.training.set = read.csv("training/features/PseAACNCCDIPEP_Cyto_Nucl_train.csv", header = FALSE)
Cyto.training.set = read.csv("training/features/PseAACNCCDIPEP_Cyto_train.csv", header = FALSE)
Endoplasm.training.set = read.csv("training/features/PseAACNCCDIPEP_Endoplasm_train.csv", header = FALSE)
Extracel.training.set = read.csv("training/features/PseAACNCCDIPEP_Extracel_train.csv", header = FALSE)
Golgi.training.set = read.csv("training/features/PseAACNCCDIPEP_Golgi_train.csv", header = FALSE)
Mito.Plastid.training.set = read.csv("training/features/PseAACNCCDIPEP_Mito_Plastid_train.csv", header = FALSE)
Mito.training.set = read.csv("training/features/PseAACNCCDIPEP_Mito_train.csv", header = FALSE)
Multi.SubCellClass.training.set = read.csv("training/features/PseAACNCCDIPEP_Multi_Class_train.csv", header = FALSE)
Nucl.training.set = read.csv("training/features/PseAACNCCDIPEP_Nucl_train.csv", header = FALSE)
Other.Dual.training.set = read.csv("training/features/PseAACNCCDIPEP_Other_Dual_train.csv", header = FALSE)
Peroxi.training.set = read.csv("training/features/PseAACNCCDIPEP_Peroxi_train.csv", header = FALSE)
Plastid.training.set = read.csv("training/features/PseAACNCCDIPEP_Plastid_train.csv", header = FALSE)
Vacu.training.set = read.csv("training/features/PseAACNCCDIPEP_Vacu_train.csv", header = FALSE)

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
Other.Dual.training.set$SubCellClass = "Other.Dual"
Peroxi.training.set$SubCellClass = "Peroxi"
Plastid.training.set$SubCellClass = "Plastid"
Vacu.training.set$SubCellClass = "Vacu"


SubCellClasses = c("Celmemb", "Celwall", "Cyto.Golgi", "Cyto.Nucl","Cyto", "Endoplasm", "Extracel", "Golgi",
                 "Mito.Plastid", "Mito", "Multi.SubCellClass", "Nucl", "Other.Dual", "Peroxi", "Plastid", "Vacu")

Total.training.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
                  Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
                  Mito.Plastid.training.set, Mito.training.set, Multi.SubCellClass.training.set, Nucl.training.set,
                  Other.Dual.training.set, Peroxi.training.set, Plastid.training.set, Vacu.training.set)

Training.set <- subset(Total.training.set, select=-SubCellClass)
Class.labels <- Total.training.set$SubCellClass


svm.model = svm(SubCellClass ~ ., data=Total.training.set, cost = 5, type = 'C', probability = TRUE)
saveRDS(svm.model, file = "training/models/svmModel_APAAC.rds")

Total.training.set$SubCellClass = as.factor(Total.training.set$SubCellClass)
tuning = tune(svm, SubCellClass~., data = Total.training.set, type = 'C',
              kernel="radial", ranges=list(cost=cost.values, gamma=gamma.values))

# Save an object to a file
saveRDS(svm.model, file = "training/models/svmModel_APAAC.rds")

summary(svm.model)
svm.model$levels

indepedent.test.set = read.csv("training/features/PseAACNCCDIPEP_Nucl_train.csv", header = FALSE)

prediction = predict(svm.model, Total.training.set, probability = TRUE)

saveRDS(svm.model, file = "training/models/svmModel_PseAACNCCDipep.rds")
predicdad = summary(prediction)
names(predicdad)
as.numeric(predicdad)
