# Run from the repository root with: Rscript tests/smoke.R
setwd("Plant-mSubP")
source("server.R")
ui <- source("ui.R")$value
stopifnot(is.function(server), length(ui) > 0)

sequences <- protr::readFASTA("Demo.fasta")[1:2]
fasta <- paste(paste0(">", names(sequences), "\n", unlist(sequences)), collapse = "\n")
modules <- c("Amino Acid composition", "Dipeptide composition",
             "Hybrid PseAAC, NCC and Dipep", "Hybrid NCC, Dipep, CTDC, CTDT and QSO")

for (module in modules) {
  shiny::testServer(server, {
    session$setInputs(feature = module, sequenceTextArea = fasta)
    session$setInputs(submitButton = 1)
    stopifnot(nrow(in_data$data) == 2L, ncol(in_data$data) == 16L,
              identical(as.character(in_data$data$Sequence_id), names(sequences)),
              all(!is.na(in_data$data$Prediction)))
    session$setInputs(clearButton = 1)
    stopifnot(is.null(in_data$data))
  })
  cat("PASS pasted FASTA and clear:", module, "\n")
}

upload <- tempfile(fileext = ".fasta")
writeLines(fasta, upload)
shiny::testServer(server, {
  session$setInputs(feature = modules[1], fastaFile = data.frame(
    name = "demo.fasta", size = file.info(upload)$size,
    type = "text/plain", datapath = upload
  ))
  session$setInputs(submitButton = 1)
  stopifnot(nrow(in_data$data) == 2L)
})
unlink(upload)
cat("PASS uploaded FASTA\n")

shiny::testServer(server, {
  session$setInputs(feature = modules[1], sequenceTextArea = ">invalid\nXXXXX")
  session$setInputs(submitButton = 1)
  stopifnot(is.null(in_data$data))
})
cat("PASS invalid sequence input\n")

# Exercise the missing-database branch without running a similarity search.
blast.database <- tempfile("missing-plant-msubp-database-")
shiny::testServer(server, {
  session$setInputs(feature = "Protein Blast", sequenceTextArea = fasta)
  session$setInputs(submitButton = 1)
  stopifnot(is.null(in_data$data), is.null(alignments$data))
})
cat("PASS unavailable BLAST database\n")
