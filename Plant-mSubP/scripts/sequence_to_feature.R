library(protr)
library(stringr)

dir("testing/sequences")
source('scripts/getPseAACfeatures.R')


SequenceToPseAACNCCDipep <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    split = 25
    Nterminal = substring(sequence,1,split)
    Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    Ccenter = substring(sequence,(split+1),nchar(sequence)-split)
    
    NterminalAAC = extractAAC(Nterminal)
    CterminalAAC = extractAAC(Cterminal)
    CcenterAAC = extractAAC(Ccenter)
    NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    Dipep = extractDC(sequence)
    
    PseAAC = PseAACProfiling(sequence)
    #PseAAC = extractPAAC(sequence, lambda = 10)
    
    
    PseAACNCCDipep = as.data.frame(t(c(PseAAC, NCC, Dipep)))
    
    standard.colnames = paste('V', seq(1:490), sep = '')
    colnames(PseAACNCCDipep) = standard.colnames
    
    PseAACNCCDipep
  }
  
  
}


SequenceToAAC <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){

    
    AAC = extractAAC(sequence)
    #PseAAC = extractPAAC(sequence, lambda = 10)
    
    
    AACFeature = as.data.frame(t(AAC))
    
    standard.colnames = paste('V', seq(1:20), sep = '')
    colnames(AACFeature) = standard.colnames
    
    AACFeature
  }
  
  
}


SequenceToDipep <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    Dipep = extractDC(sequence)
    
    #PseAAC = extractPAAC(sequence, lambda = 10)
    
    
    DipepFeature = as.data.frame(t(Dipep))
    
    standard.colnames = paste('V', seq(1:400), sep = '')
    colnames(DipepFeature) = standard.colnames
    
    DipepFeature
  }
  
  
}


SequenceToNCC <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    split = 25
    Nterminal = substring(sequence,1,split)
    Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    Ccenter = substring(sequence,(split+1),nchar(sequence)-split)
    
    NterminalAAC = extractAAC(Nterminal)
    CterminalAAC = extractAAC(Cterminal)
    CcenterAAC = extractAAC(Ccenter)
    NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    
    NCC = as.data.frame(t(NCC))
    
    standard.colnames = paste('V', seq(1:60), sep = '')
    colnames(NCC) = standard.colnames
    
    NCC
  }
  
  
}

#SequenceToNCCDipep
SequenceToNCCDipep <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    split = 25
    Nterminal = substring(sequence,1,split)
    Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    Ccenter = substring(sequence,(split+1),nchar(sequence)-split)
    
    NterminalAAC = extractAAC(Nterminal)
    CterminalAAC = extractAAC(Cterminal)
    CcenterAAC = extractAAC(Ccenter)
    NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    Dipep = extractDC(sequence)
    
    #PseAAC = PseAACProfiling(sequence)
    #PseAAC = extractPAAC(sequence, lambda = 10)
    
    
    NCCDipep = as.data.frame(t(c(NCC, Dipep)))
    
    standard.colnames = paste('V', seq(1:460), sep = '')
    colnames(NCCDipep) = standard.colnames
    
    NCCDipep
  }
  
  
}


SequenceToPseAAC <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    PseAAC = PseAACProfiling(sequence)
    #PseAAC = extractPAAC(sequence, lambda = 10)
    
    
    PseAACNCC = as.data.frame(t(c(PseAAC)))
    
    standard.colnames = paste('V', seq(1:30), sep = '')
    colnames(PseAACNCC) = standard.colnames
    
    PseAACNCC
  }
  
  
}

#extractCTriad
SequenceToPseAACNCCDipepCTr <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    CTriad = as.data.frame(t(extractCTriad(sequence)))
    
    standard.colnames = paste('V', seq(1:343), sep = '')
    colnames(CTriad) = standard.colnames
    
    CTriad
  }
  
  
}

SequenceToPseAACNCCDipepAA <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    APAAC =as.data.frame(t(extractAPAAC(sequence)))

    standard.colnames = paste('V', seq(1:80), sep = '')
    colnames(APAAC) = standard.colnames
    
    APAAC
  }
  
  
}

SequenceToNCCDipepCTDCCTDTQSO <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    split = 25
    Nterminal = substring(sequence,1,split)
    Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    Ccenter = substring(sequence,(split+1),nchar(sequence)-split)
    
    NterminalAAC = extractAAC(Nterminal)
    CterminalAAC = extractAAC(Cterminal)
    CcenterAAC = extractAAC(Ccenter)
    NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    Dipep = extractDC(sequence)
    
    CTDC = extractCTDC(sequence)
    CTDT = extractCTDT(sequence)
    QSO = extractQSO(sequence)

    
    
    NCCDipepCTDCCTDTQSO = as.data.frame(t(c(CTDC, CTDT, QSO, NCC, Dipep)))
    
    standard.colnames = paste('V', seq(1:602), sep = '')
    colnames(NCCDipepCTDCCTDTQSO) = standard.colnames
    
    NCCDipepCTDCCTDTQSO
  }
  
  
}

SequenceToQSO <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    QSO = extractQSO(sequence)
    
    QSO = as.data.frame(t(c(QSO)))
    
    standard.colnames = paste('V', seq(1:100), sep = '')
    colnames(QSO) = standard.colnames
    
    QSO
  }
  
  
}

SequenceToCTDT <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    CTDT = extractCTDT(sequence)
    
    CTDT = as.data.frame(t(c(CTDT)))
    
    standard.colnames = paste('V', seq(1:21), sep = '')
    colnames(CTDT) = standard.colnames
    
    CTDT
  }
  
  
}

SequenceToCTDC <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    
    CTDC = extractCTDC(sequence)
    
    CTDC = as.data.frame(t(c(CTDC)))
    
    standard.colnames = paste('V', seq(1:21), sep = '')
    colnames(CTDC) = standard.colnames
    
    CTDC
  }
  
  
}

SequenceToPseAACCTDCCTDTQSOmoreauNCC <- function(sequence) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    split = 25
    # Nterminal = substring(sequence,1,split)
    # Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    # Ccenter = substring(sequence,(split+1),nchar(sequence)-split)
    # 
    # NterminalAAC = extractAAC(Nterminal)
    # CterminalAAC = extractAAC(Cterminal)
    # CcenterAAC = extractAAC(Ccenter)
    # NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    # CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    # CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    # NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    Tripep = extractTC(sequence)
    
    PseAAC = PseAACProfiling(sequence)
    #CTDC = extractCTDC(sequence)
    CTDT = extractCTDT(sequence)
    #QSO = extractQSO(sequence)
    #moreau = extractMoreauBroto(sequence)
    
    
    
    PseAACCTDCCTDTQSOmoreauNCC = as.data.frame(t(c(PseAAC,Tripep,CTDT)))
    
    standard.colnames = paste('V', seq(1:8051), sep = '')
    colnames(PseAACCTDCCTDTQSOmoreauNCC) = standard.colnames
    
    PseAACCTDCCTDTQSOmoreauNCC
  }
  
  
}

SequenceToTest <- function(sequence, testFeature) {
  
  if(protcheck(sequence) && nchar(sequence)>50){
    split = 25
    Nterminal = substring(sequence,1,split)
    Cterminal = substring(sequence,nchar(sequence)-(split-1),nchar(sequence))
    Ccenter = substring(sequence,(split+1),nchar(sequence)-split)

    NterminalAAC = extractAAC(Nterminal)
    CterminalAAC = extractAAC(Cterminal)
    CcenterAAC = extractAAC(Ccenter)
    NterminalAAC= NterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CterminalAAC= CterminalAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    CcenterAAC= CcenterAAC[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
    NCC = c(NterminalAAC,CcenterAAC,CterminalAAC)
    
    sequence = Celmemb.training.sequence.set[[1]]
    #Tripep = extractTC(sequence)
    length(extractCTriad(sequence))
    PseAAC = PseAACProfiling(sequence)
    #CTDC = extractCTDC(sequence)
    #CTDT = extractCTDT(sequence)
    QSO = extractQSO(sequence)
    moreau = extractMoreauBroto(sequence)
    
    
    
    PseAACCTDCCTDTQSOmoreauNCC = as.data.frame(t(c(PseAAC,moreau,NCC,QSO)))
    
    standard.colnames = paste('V', seq(1:430), sep = '')
    colnames(PseAACCTDCCTDTQSOmoreauNCC) = standard.colnames
    
    PseAACCTDCCTDTQSOmoreauNCC
  }
  
  
}


