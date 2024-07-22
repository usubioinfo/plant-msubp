library('e1071')

dir("training/features")

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
Multi.Class.training.set = read.csv("training/features/PseAACNCCDIPEP_Multi_Class_train.csv", header = FALSE)
Nucl.training.set = read.csv("training/features/PseAACNCCDIPEP_Nucl_train.csv", header = FALSE)
Other.Dual.training.set = read.csv("training/features/PseAACNCCDIPEP_Other_Dual_train.csv", header = FALSE)
Peroxi.training.set = read.csv("training/features/PseAACNCCDIPEP_Peroxi_train.csv", header = FALSE)
Plastid.training.set = read.csv("training/features/PseAACNCCDIPEP_Plastid_train.csv", header = FALSE)
Vacu.training.set = read.csv("training/features/PseAACNCCDIPEP_Vacu_train.csv", header = FALSE)

Total.set = rbind(Celmemb.training.set, Celwall.training.set, Cyto.Golgi.training.set, Cyto.Nucl.training.set,
                  Cyto.training.set, Endoplasm.training.set, Extracel.training.set, Golgi.training.set,
                  Mito.Plastid.training.set, Mito.training.set, Multi.Class.training.set, Nucl.training.set,
                  Other.Dual.training.set, Peroxi.training.set, Plastid.training.set, Vacu.training.set, all = TRUE)

nucl.svm.model = svm(Celmemb.training.set ~ Total.set, degree = 50, kernel = "radial", cost = 500 )
prediction = predict(nucl.svm.model, nucl.training.set)
length(prediction[prediction == TRUE])
