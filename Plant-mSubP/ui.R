library(shiny)
library(markdown)
library(shinythemes)
library(shinyjs)
library(DT)


#Load our terms content to put into the terms popup

navbarPage(theme = shinytheme("flatly"),id = "inTabset",
  title = div("Plant-mSubP"),
  tabPanel("Submit",class = "jumbotron",
     fluidPage (
       div(class = "card",  
           id ="submit",
           div(class = "card",  
               id ="mainpanel",
             tags$h3("Submit",id="ex1"),
             div(id ="auxiliarpane",
               fileInput("fastaFile", "Upload query protein sequence(s) in FASTA format:",
                         accept = c(".fa",
                                    ".pep",
                                    ".fasta"),
                         width = '50%'),
               HTML("OR"),
               textAreaInput("sequenceTextArea", HTML("Paste sequences below <i>(FASTA only)</i>"), "", width = '200%', rows = 5,resize = 'none'),
               actionLink("demoDataButton", "Load demo data"),
               
               # Horizontal line ----
               tags$hr(),
               # Input: Select separator ----
               radioButtons("feature", "Select prediction module",
                            choices = c("AAC" = "Amino Acid composition",
                                        "Dipep" = "Dipeptide composition",
                                        "PseAACNCCDipep" = "Hybrid PseAAC, NCC and Dipep",
                                        "NCCDipepCTDCCTDTQSO" = "Hybrid NCC, Dipep, CTDC, CTDT and QSO",
                                        "Protein Blast (simmilarity search)" = "Protein Blast"),
                            selected = "Hybrid PseAAC, NCC and Dipep",
                            width = '80%'),
               #textInput("email","Email Address (Optional):"),
               fluidRow(
                 actionButton("submitButton", "Submit"),
                 actionButton("clearButton", "Clear")
               )
           )
         )
       )
       )
        
      
      # Output: Data file ----
     # downloadLink("downloadData", "Download"),
    #tableOutput("prediction_results")
      
     #end fluidpage
  ),
  tabPanel("Results",
           fluidPage(width = 1,
             # Output: Data file ----
             downloadLink("downloadData", "Download"),
             tags$hr(),
             downloadLink("downloadBlastAlign", "Download Blast Alignments"),
             tags$hr(),
             tableOutput("prediction_results"),
             tags$hr(),
             DT::dataTableOutput("mytable")
          )
  ),
  tabPanel("Datasets",class = "jumbotron",
           fluidPage(
             div(id = "dataset", class = "card",  
                 includeHTML("./dataset.html")
             )
           )
  ),
  tabPanel("About",class = "jumbotron",
           fluidPage(
             div(id = "about", class = "card",  
                 includeHTML("./about.html")
             )
           )
  ),
  tabPanel("Help",class = "jumbotron",
           fluidPage(
             div(class = "card",  
                 includeHTML("./help.html")
             )
           )
  ),
  collapsible = TRUE,
  windowTitle = "Plant subcellular location predictor",
  header = tagList(
  useShinyjs(),
  if (file.exists("google-analytics.js")) tags$head(includeScript("google-analytics.js")),
  if (nzchar(Sys.getenv("PLANT_MSUBP_ACCESS_LOG"))) tags$head(includeScript("getIP.js")),
  tags$head(
    tags$style(
      HTML(".shiny-notification {
           position:fixed;
           top: 33%;;
           left: 36%;;
           font-size: 200%;;
           text-align: center;;
           background-color: lightblue;;
           }
           #mainpanel {
              margin-right: 10%;
              margin-left: 10%;
              background-color: #EEEFF1;
           }
           #auxiliarpane {
              
              margin-left: 30%;
              background-color: #EEEFF1;
           }
           #ex1{
              text-align: center;
              background-color: #D3D3D3;
              color:gray;
              
           }
           "
      )
    )
  )
  )
)
