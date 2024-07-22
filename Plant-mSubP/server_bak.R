library(protr)
library(e1071)
library(seqinr)
library(shinyjs)
library(stringr)

source("./scripts/sequence_to_feature.R")
#TODO CHANGE THIS FOR SVMLIGHT MODELS
svm.model.AAC = readRDS("./training/models/svmModel_SequenceToAAC.rds")
svm.model.Dipep = readRDS("./training/models/svmModel_SequenceToDipep.rds")
svm.model.PseAACNCCDipep = readRDS("./training/models/svmModel_SequenceToPseAACNCCDipep.rds")
#svm.model.NCCDipepCTDCCTDTQSO = readRDS("./training/models/Model_SequenceToNCCDipepCTDCCTDTQSO.rds")
svm.model.NCCDipepCTDCCTDTQSO = readRDS("./training/models/svmModel_SequenceToNCCDipepCTDCCTDTQSO.rds")

isValidEmail <- function(x) {
  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(x), 
        ignore.case=TRUE)
}

###AAC
# 
# AAC.Celmemb.model.filename = paste("./training/models/AAC/Celmemb_svmModel.txt")
# AAC.Celwall.model.filename = paste("./training/models/AAC/Celwall_svmModel.txt")
# AAC.Cyto.Golgi.model.filename = paste("./training/models/AAC/Cyto.Golgi_svmModel.txt")
# AAC.Cyto.Nucl.model.filename = paste("./training/models/AAC/Cyto.Nucl_svmModel.txt")
# AAC.Cyto.model.filename = paste("./training/models/AAC/Cyto_svmModel.txt")
# AAC.Endoplasm.model.filename = paste("./training/models/AAC/Endoplasm_svmModel.txt")
# AAC.Extracel.model.filename = paste("./training/models/AAC/Extracel_svmModel.txt")
# AAC.Golgi.model.filename = paste("./training/models/AAC/Golgi_svmModel.txt")
# AAC.Mito.Plastid.model.filename = paste("./training/models/AAC/Mito.Plastid_svmModel.txt")
# AAC.Mito.model.filename = paste("./training/models/AAC/Mito_svmModel.txt")
# AAC.Nucl.model.filename = paste("./training/models/AAC/Nucl_svmModel.txt")
# AAC.Peroxi.model.filename = paste("./training/models/AAC/Peroxi_svmModel.txt")
# AAC.Plastid.model.filename = paste("./training/models/AAC/Plastid_svmModel.txt")
# AAC.Vacu.model.filename = paste("./training/models/AAC/Vacu_svmModel.txt")
# 
# 
# ###Dipep
# 
# Dipep.Celmemb.model.filename = paste("./training/models/Dipep/Celmemb_svmModel.txt")
# Dipep.Celwall.model.filename = paste("./training/models/Dipep/Celwall_svmModel.txt")
# Dipep.Cyto.Golgi.model.filename = paste("./training/models/Dipep/Cyto.Golgi_svmModel.txt")
# Dipep.Cyto.Nucl.model.filename = paste("./training/models/Dipep/Cyto.Nucl_svmModel.txt")
# Dipep.Cyto.model.filename = paste("./training/models/Dipep/Cyto_svmModel.txt")
# Dipep.Endoplasm.model.filename = paste("./training/models/Dipep/Endoplasm_svmModel.txt")
# Dipep.Extracel.model.filename = paste("./training/models/Dipep/Extracel_svmModel.txt")
# Dipep.Golgi.model.filename = paste("./training/models/Dipep/Golgi_svmModel.txt")
# Dipep.Mito.Plastid.model.filename = paste("./training/models/Dipep/Mito.Plastid_svmModel.txt")
# Dipep.Mito.model.filename = paste("./training/models/Dipep/Mito_svmModel.txt")
# Dipep.Nucl.model.filename = paste("./training/models/Dipep/Nucl_svmModel.txt")
# Dipep.Peroxi.model.filename = paste("./training/models/Dipep/Peroxi_svmModel.txt")
# Dipep.Plastid.model.filename = paste("./training/models/Dipep/Plastid_svmModel.txt")
# Dipep.Vacu.model.filename = paste("./training/models/Dipep/Vacu_svmModel.txt")
# 
# 
# 
# #DEFAULT
# Celmemb.model.filename = AAC.Celmemb.model.filename
# Celwall.model.filename = AAC.Celwall.model.filename
# Cyto.Golgi.model.filename = AAC.Cyto.Golgi.model.filename
# Cyto.Nucl.model.filename = AAC.Cyto.Nucl.model.filename
# Cyto.model.filename = AAC.Cyto.model.filename
# Endoplasm.model.filename = AAC.Endoplasm.model.filename
# Extracel.model.filename = AAC.Extracel.model.filename
# Golgi.model.filename = AAC.Golgi.model.filename
# Mito.Plastid.model.filename = AAC.Mito.Plastid.model.filename
# Mito.model.filename = AAC.Mito.model.filename
# Nucl.model.filename = AAC.Nucl.model.filename
# Peroxi.model.filename = AAC.Peroxi.model.filename
# Plastid.model.filename = AAC.Plastid.model.filename
# Vacu.model.filename = AAC.Vacu.model.filename



svm.model = svm.model.PseAACNCCDipep

predicitionModel = NULL

insecticide = TRUE


server <- function(input, output, session) {
  
  #timesClicked = 0
  good.sequences.number <- reactiveValues(sequences.number = NULL)
  in_data <- reactiveValues(data = NULL)
  values <- reactiveValues(upload_state = NULL)
  alignments <- reactiveValues(data = NULL)
  shinyjs::hide("downloadData")
  shinyjs::hide("downloadBlastAlign")
  hideTab(inputId = "inTabset", target = "Results")
  
  
  
  observeEvent(input$fastaFile, {
    values$upload_state <- 'uploaded'
  })
  
  observeEvent(input$submitButton,{
    
    inFile <- input$fastaFile 
    inTextbox <- input$sequenceTextArea
    inFeature <- input$feature 
    sequences = NULL
    blastp.result = NULL
    
    time.file = tempfile("plant-msubp-")
    
    if(inFeature == "Hybrid PseAAC, NCC and Dipep"){
      svm.model = svm.model.PseAACNCCDipep
    } else if(inFeature == "Hybrid NCC, Dipep, CTDC, CTDT and QSO"){
      svm.model = svm.model.NCCDipepCTDCCTDTQSO
    } else if(inFeature == "Amino Acid composition"){
      svm.model = svm.model.AAC
      # Celmemb.model.filename = AAC.Celmemb.model.filename
      # Celwall.model.filename = AAC.Celwall.model.filename
      # Cyto.Golgi.model.filename = AAC.Cyto.Golgi.model.filename
      # Cyto.Nucl.model.filename = AAC.Cyto.Nucl.model.filename
      # Cyto.model.filename = AAC.Cyto.model.filename
      # Endoplasm.model.filename = AAC.Endoplasm.model.filename
      # Extracel.model.filename = AAC.Extracel.model.filename
      # Golgi.model.filename = AAC.Golgi.model.filename
      # Mito.Plastid.model.filename = AAC.Mito.Plastid.model.filename
      # Mito.model.filename = AAC.Mito.model.filename
      # Nucl.model.filename = AAC.Nucl.model.filename
      # Peroxi.model.filename = AAC.Peroxi.model.filename
      # Plastid.model.filename = AAC.Plastid.model.filename
      # Vacu.model.filename = AAC.Vacu.model.filename
    } else if(inFeature == "Dipeptide composition"){
      svm.model = svm.model.Dipep
      # Celmemb.model.filename = Dipep.Celmemb.model.filename
      # Celwall.model.filename = Dipep.Celwall.model.filename
      # Cyto.Golgi.model.filename = Dipep.Cyto.Golgi.model.filename
      # Cyto.Nucl.model.filename = Dipep.Cyto.Nucl.model.filename
      # Cyto.model.filename = Dipep.Cyto.model.filename
      # Endoplasm.model.filename = Dipep.Endoplasm.model.filename
      # Extracel.model.filename = Dipep.Extracel.model.filename
      # Golgi.model.filename = Dipep.Golgi.model.filename
      # Mito.Plastid.model.filename = Dipep.Mito.Plastid.model.filename
      # Mito.model.filename = Dipep.Mito.model.filename
      # Nucl.model.filename = Dipep.Nucl.model.filename
      # Peroxi.model.filename = Dipep.Peroxi.model.filename
      # Plastid.model.filename = Dipep.Plastid.model.filename
      # Vacu.model.filename = Dipep.Vacu.model.filename
    }
    
    
    if(!is.null(inFile) && values$upload_state== 'uploaded'){
      tryCatch({
        sequences = readFASTA(inFile$datapath)
      }, error=function(e) {
        showModal(modalDialog(
          title = "Format file error",
          "Please select/upload FASTA sequence(s)",
          easyClose = TRUE
        ))
      })

      Sys.time()
    }else if(!is.null(inTextbox)){
      dataFasta = inTextbox
      write(dataFasta, file = paste(time.file,".fasta", sep = ""))
      tryCatch({
      sequences = readFASTA(paste(time.file,".fasta", sep = ""))
      }, error=function(e) {
        showModal(modalDialog(
          title = "Format file error",
          "Please select/upload FASTA sequence(s)",
          easyClose = TRUE
        ))
      })
      file.remove(paste(time.file,".fasta", sep = ""))

    }
    if(!is.null(sequences)){
      if(length(sequences) > 1000 & (inFeature == "Hybrid PseAAC, NCC and Dipep"  | inFeature == "Hybrid NCC, Dipep, CTDC, CTDT and QSO" | inFeature == "Protein Blast")){
        showModal(modalDialog(
          title = "Number of sequences error",
          "You have exceed the limit of sequences (1000)",
          easyClose = TRUE
        ))
      } else if(length(sequences) > 30000  & ( inFeature == "Amino Acid composition" | inFeature == "Dipeptide composition" )){
        showModal(modalDialog(
          title = "Number of sequences error",
          "You have exceed the limit of sequences (30000)",
          easyClose = TRUE
        ))
      } else {
        good.sequences = c()
        for(j in 1:length(sequences)){
          if(protcheck(sequences[[j]]) && nchar(sequences[[j]])>50){
            good.sequences = c(good.sequences,j)
          }
        }
        sequences = sequences[good.sequences]
        features = data.frame()
        good.sequences.number$sequences.number = length(sequences)
        predicitionModel = as.character(inFeature)
        column.feature.number = 0
        if(inFeature != "Protein Blast"){
          withProgress(message = 'Calculation in progress',
                       detail = 'This may take a while...', value = 0, {
            for(i in 1:length(sequences)){
              if(inFeature == "Hybrid PseAAC, NCC and Dipep"){
                features = rbind(features, SequenceToPseAACNCCDipep(sequences[[i]]))
                column.feature.number = 490
              } else if(inFeature == "Hybrid NCC, Dipep, CTDC, CTDT and QSO"){
                features = rbind(features, SequenceToNCCDipepCTDCCTDTQSO(sequences[[i]]))
                column.feature.number = 602
              } else if(inFeature == "Amino Acid composition"){
                features = rbind(features, SequenceToAAC(sequences[[i]]))
                column.feature.number = 20
              } else if(inFeature == "Dipeptide composition"){
                features = rbind(features, SequenceToDipep(sequences[[i]]))
                column.feature.number = 400
              }
              
              incProgress(1/length(sequences))
            }
          })

        }
        
        SubCellClasses = c("Celmemb", "Celwall", "Cyto","Cyto.Golgi", "Cyto.Nucl", "Endoplasm", "Extracel", "Golgi", "Mito",
                           "Mito.Plastid", "Nucl", "Peroxi", "Plastid", "Vacu")
        
        if(inFeature != "Protein Blast"){
          
          # if(inFeature == "Amino Acid composition" || inFeature == "Dipeptide composition"){
          #   
          #   features$SubCellClass = -1
          #   for(j in 1:(ncol(features)-1)){
          #     features[,j] = paste(j,features[,j],sep = ":")
          #   }
          #   
          #   features= features[,c((column.feature.number+1),1:column.feature.number)]
          #   
          #   query.filename = paste(time.file,"svmlight.txt", sep = "")
          #   
          #   
          #   
          #   Celmemb.prediction.result.filename = paste(time.file,"_result","_Celmemb_prediction.txt", sep = "")
          #   Celwall.prediction.result.filename = paste(time.file,"_result","_Celwall_prediction.txt", sep = "")
          #   Cyto.Golgi.prediction.result.filename = paste(time.file,"_result","_Cyto.Golgi_prediction.txt", sep = "")
          #   Cyto.Nucl.prediction.result.filename = paste(time.file,"_result","_Cyto.Nucl_prediction.txt", sep = "")
          #   Cyto.prediction.result.filename = paste(time.file,"_result","_Cyto_prediction.txt", sep = "")
          #   Endoplasm.prediction.result.filename = paste(time.file,"_result","_Endoplasm_prediction.txt", sep = "")
          #   Extracel.prediction.result.filename = paste(time.file,"_result","_Extracel_prediction.txt", sep = "")
          #   Golgi.prediction.result.filename = paste(time.file,"_result","_Golgi_prediction.txt", sep = "")
          #   Mito.Plastid.prediction.result.filename = paste(time.file,"_result","_Mito.Plastid_prediction.txt", sep = "")
          #   Mito.prediction.result.filename = paste(time.file,"_result","_Mito_prediction.txt", sep = "")
          #   Nucl.prediction.result.filename = paste(time.file,"_result","_Nucl_prediction.txt", sep = "")
          #   Peroxi.prediction.result.filename = paste(time.file,"_result","_Peroxi_prediction.txt", sep = "")
          #   Plastid.prediction.result.filename = paste(time.file,"_result","_Plastid_prediction.txt", sep = "")
          #   Vacu.prediction.result.filename = paste(time.file,"_result","_Vacu_prediction.txt", sep = "")
          #   prediction.result.filename = paste(time.file,"_result","final_prediction.txt", sep = "")
          #   
          #   
          #   write.table(features, file = query.filename, quote = FALSE,
          #               sep = " ", row.names = FALSE, col.names = FALSE)
          #   
          #   system(paste("svm_classify ",query.filename,Celmemb.model.filename,Celmemb.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Celwall.model.filename,Celwall.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Cyto.Golgi.model.filename,Cyto.Golgi.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Cyto.Nucl.model.filename,Cyto.Nucl.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Cyto.model.filename,Cyto.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Endoplasm.model.filename,Endoplasm.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Extracel.model.filename,Extracel.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Golgi.model.filename,Golgi.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Mito.Plastid.model.filename,Mito.Plastid.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Mito.model.filename,Mito.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Nucl.model.filename,Nucl.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Peroxi.model.filename,Peroxi.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Plastid.model.filename,Plastid.prediction.result.filename))
          #   system(paste("svm_classify ",query.filename,Vacu.model.filename,Vacu.prediction.result.filename))
          #   
          #   
          #   system(paste("paste -d , ",Celmemb.prediction.result.filename,Celwall.prediction.result.filename,Cyto.Golgi.prediction.result.filename,
          #                Cyto.Nucl.prediction.result.filename, Cyto.prediction.result.filename, Endoplasm.prediction.result.filename,
          #                Extracel.prediction.result.filename, Golgi.prediction.result.filename, Mito.Plastid.prediction.result.filename,
          #                Mito.prediction.result.filename, Nucl.prediction.result.filename, Peroxi.prediction.result.filename,
          #                Plastid.prediction.result.filename, Vacu.prediction.result.filename," > ", prediction.result.filename))
          #   
          #   
          #   prediction = read.csv(prediction.result.filename,header = FALSE)
          #   
          #   file.remove(query.filename)
          #   file.remove(Celmemb.prediction.result.filename)
          #   file.remove(Celwall.prediction.result.filename)
          #   file.remove(Cyto.Golgi.prediction.result.filename)
          #   file.remove(Cyto.Nucl.prediction.result.filename)
          #   file.remove(Cyto.prediction.result.filename)
          #   file.remove(Endoplasm.prediction.result.filename)
          #   file.remove(Extracel.prediction.result.filename)
          #   file.remove(Golgi.prediction.result.filename)
          #   file.remove(Mito.Plastid.prediction.result.filename)
          #   file.remove(Mito.prediction.result.filename)
          #   file.remove(Nucl.prediction.result.filename)
          #   file.remove(Peroxi.prediction.result.filename)
          #   file.remove(Plastid.prediction.result.filename)
          #   file.remove(Vacu.prediction.result.filename)
          #   file.remove(prediction.result.filename)
          # 
          #   for(i in 1:nrow(prediction)){
          #     for(j in 1:ncol(prediction)){
          #       prediction[i,j] = signif(prediction[i,j], digits = 3)
          #     }
          #   }
          #   
          #   
          #   prediction$Prediction = "None"
          #   prediction = prediction[,c(15,seq(1,14))]
          #   i = 1
          #   for(i in 1:nrow(prediction)){
          #     prediction.index = as.numeric(which.max( prediction[i,seq(2,15)] ) )
          #     if(prediction[i,prediction.index+1]>0){
          #       prediction[i,1] = SubCellClasses[prediction.index]
          #     }
          #   }
          #   
          #   
          #   
          #   
          #   prediction$Sequence_id = names(sequences)
          #   prediction = prediction[,c(16,seq(1,15))]
          #   colnames(prediction) = c("Sequence_id","Prediction", SubCellClasses)
          #   result = prediction
          #   
          #   
          # } else {
          prediction = predict(svm.model, features, probability = TRUE)
          probabilities = as.data.frame((signif(attr(prediction,"probabilities"), digits = 3)))
          for(i in 1:nrow(probabilities)){
            for(j in 1:ncol(probabilities)){
              probabilities[i,j] = paste(probabilities[i,j], " (",signif(as.numeric(probabilities[i,j])*100, digits = 2),"%)", sep="")
            }
          }
          
          probabilities$Sequence_id = names(sequences)
          probabilities$Prediction = SubCellClasses[prediction]
          # if(inFeature == "Hybrid NCC, Dipep, CTDC, CTDT and QSO"){
          #   probabilities$Prediction = prediction
          # }  else {
          #   probabilities$Prediction = SubCellClasses[prediction]
          # }
          predicition_index = ncol(probabilities)
          sequence_id_index = predicition_index - 1
          last_feature_index = sequence_id_index - 1
          result = probabilities[c(sequence_id_index,predicition_index,1:last_feature_index)]
         # }
          
          showTab(inputId = "inTabset", target = "Results")
          shinyjs::hide("downloadBlastAlign")
          shinyjs::show("downloadData")
          #shinyjs::reset('fastaFile')
          updateTabsetPanel(session, "inTabset",
                            selected = "Results")
          in_data$data = result
        } else {
          
          time.file = tempfile("plant-msubp-")
          
          query.filename = paste(time.file,".fasta", sep = "")
          blastp.result.filename = paste(time.file,"_result",".blastp", sep = "")
          blastf.result.filename = paste(time.file,"_simple_result",".blastp", sep = "")
          blastf.align.filename = paste(time.file,"_align",".blastp", sep = "")
          
          write.fasta(sequences, names(sequences), file = query.filename)
          
          blastp.command = paste("blastp -query ",query.filename,"-db /opt/blast_db/subcellular_localization_db ","-evalue=0.001 ",
                                 '-outfmt 11'," -out ", blastp.result.filename," -max_target_seqs=1 ")
          blastf.result.command = paste("blast_formatter -archive ",blastp.result.filename,' -outfmt="6 qseqid stitle evalue bitscore "',
                                 " -out ", blastf.result.filename)
          blastf.align.command = paste("blast_formatter -archive ",blastp.result.filename,' -outfmt 1',
                                       " -out ", blastf.align.filename)
          withProgress(message = 'Calculation in progress',
                       detail = 'This may take a while...', value = 20, {
          system(blastp.command)
          incProgress(80)
          system(blastf.result.command)
          incProgress(10)
          system(blastf.align.command)
          incProgress(10)  
          })
          
          blastp.result = read.delim(blastf.result.filename,header = FALSE)
          
          detail.blastp.result = as.data.frame(str_split_fixed(blastp.result$V2, "::", 3))
          blastp.result$V5 = detail.blastp.result$V1
          blastp.result$V6 = detail.blastp.result$V2
          blastp.result$V7 = detail.blastp.result$V3
          
          blastp.result = blastp.result[,c(-2,-7)]
          blastp.result = blastp.result[,c(1,4,5,3,2)]
          colnames(blastp.result) = c("Query ID", "Hit ID", "Blastp based Subcellular Prediction", "Score (bits)"," E-value")
          blastp.result[,5]= signif(blastp.result[,5] , digits = 1)
          blastp.result[ 5] = as.character(blastp.result[,5])
          
          blastp.alignments = readChar(blastf.align.filename, nchars = file.info(blastf.align.filename)$size)
          
          file.remove(query.filename)
          file.remove(blastp.result.filename)
          file.remove(blastf.result.filename)
          file.remove(blastf.align.filename)
          showTab(inputId = "inTabset", target = "Results")
          shinyjs::show("downloadData")
          shinyjs::show("downloadBlastAlign")
          #shinyjs::reset('fastaFile')
          updateTabsetPanel(session, "inTabset",
                            selected = "Results")
          
          
          alignments$data = blastp.alignments
          in_data$data = blastp.result
        }
        
        
      }
    } else {
      in_data$data =NULL
    }
    
    
    
    
  })
  
  observeEvent(input$clearButton, {
    
    shinyjs::reset('fastaFile')
    shinyjs::reset('sequenceTextArea')
    values$upload_state <- 'reset'
    in_data$data =NULL
    shinyjs::hide("downloadData")
    shinyjs::hide("downloadBlastAlign")
    hideTab(inputId = "inTabset", target = "Results")
  })
  
  observeEvent(input$demoDataButton, {

    demoFastaFile = readFASTA("Demo.fasta")
    demoData = HTML(paste(">",names(demoFastaFile),'\n',as.character(demoFastaFile),"\n",sep=""))
    demoData = gsub(" >", ">", demoData)
    updateTextAreaInput(session, "sequenceTextArea", value = demoData)
  })
  
  output$prediction_results <- renderUI({
    inFeature <- input$feature
    
    if (is.null(in_data$data)) return()
    #resultTable=isolate(in_data())
    if(inFeature != "Protein Blast"){
      tagList(
        HTML("Your prediction results are as under:"),
        HTML("<br>"),
        HTML("Fourteen different value corresponding to each Fourteen localizations are displayed for each of the query sequence. The final location is the corresponding highest value sorted within the fourteen locations."),
        HTML("<br>"),
        HTML("<br>"),
        HTML(paste("     <strong>Prediction approach followed: </strong>",inFeature)),
        HTML("<br>"),
        HTML(paste("     <strong>Number of sequences processed : </strong>",good.sequences.number$sequences.number)),
        HTML("<br>"),
        HTML(paste("     <strong>Predicted on :</strong> ",Sys.time()))
        #DT::renderDataTable(DT::datatable((in_data$data)))
        
      )
    } else {
      tagList(
        HTML("Your blastp prediction results are as under:"),
        HTML("<br>"),
        HTML("The current target database contains 217,967 protein sequences those having 'SUBCELLULAR LOCALIZATION' information available in the Swiss-Prot database (release 56.4 as of December, 2008). The default E-value is set at 0.001"),
        HTML("<br>"),
        HTML("<br>"),
        HTML(paste("     <strong>Number of sequences processed : </strong>",good.sequences.number$sequences.number)),
        HTML("<br>"),
        HTML(paste("     <strong>Predicted on :</strong> ",Sys.time()))
        #DT::renderDataTable(DT::datatable((in_data$data)))
        
      ) 
    }

  })
  
  output$mytable = DT::renderDataTable({DT::datatable(
    in_data$data,
    options = list(rowCallback = DT::JS(
      'function(row, data) {
        // Bold cells for those >= 5 in the first column
        //if (parseFloat(data[1]) >= 5.0)
        $("td:eq(2)", row).css("font-weight", "bold");
        $("td:eq(2)", row).css("background-color", "lightblue");
      }'
    ))
    )
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(in_data$data, file)
    }
  )
  
  output$downloadBlastAlign <- downloadHandler(
    filename = function() {
      paste("aligments-", Sys.Date(), ".txt", sep="")
    },
    content = function(file) {
      write(alignments$data, file)
    }
  )
  
  IP <- reactive({ input$getIP })
  
  observe({
    loc.info = IP()
    
    #as.Sys.time()
    
    date.time.access = as.character(Sys.time())
    if(!is.null(loc.info)){
      cat(paste(date.time.access,loc.info[[1]],loc.info[[2]],loc.info[[3]],loc.info[[4]],loc.info[[5]],loc.info[[6]]), file="www/log/log_entries.txt", append=TRUE, sep = "\n")
      
    }
    

    #loc.info = paste(IP$ip,IP$hostname,IP$org,IP$loc,IP$country,IP$region,IP$city)
    #loc.info[[1]]

  })
  
  
  
}