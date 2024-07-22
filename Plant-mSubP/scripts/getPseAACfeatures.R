library('protr')

Hydrophobic <- function(seq){
  seq.length = nchar(seq)
  hydrophobic.dict = list('L'=1.06,'I'=1.38,'N'=-0.78,'G'=0.48,'V'=1.08,'E'=-0.74,'P'=0.12,
                          'H'=-0.40,'K'=-1.50,'A'=0.62,'Y'=0.26,'W'=0.81,'Q'=-0.85,'M'=0.64,
                          'S'=-0.18,'C'=0.29,'T'=-0.05,'F'=1.19,'R'=-2.53, 'D'=-0.90)
  hydrophobic.profile = c()
  for(i in 1:seq.length){
    hydrophobic.profile = c(hydrophobic.profile, hydrophobic.dict[[substr(seq,i,i)]])
  }
  
  hydrophobic.profile
}

Hydrophilic <- function(seq){
  seq.length = nchar(seq)
  hydrophilic.dict = list('L'=-1.8,'I'=-1.8,'N'=0.2,'G'=0.0,'V'=-1.5,'E'=3.0,'P'=0.0,
                          'H'=-0.5,'K'=3.0,'A'=-0.5,'Y'=-2.3,'W'=-3.4,'Q'=0.2,'M'=-1.3,
                          'S'=-0.3,'C'=-1.0,'T'=-0.4,'F'=-2.5,'R'=3.0, 'D'=3.0)
  hydrophilic.profile = c()
  for(i in 1:seq.length){
    hydrophilic.profile = c(hydrophilic.profile, hydrophilic.dict[[substr(seq,i,i)]])
  }
  
  hydrophilic.profile
}



PseAACProfiling <- function(sequence){
  hphobic.seq=Hydrophobic(sequence)
  hphilic.seq=Hydrophilic(sequence)
  
  
  ########################## Normalization  for Hydrophobic value#############################
  hphobic.norm=(0.62+0.29-0.90-0.74+1.19+0.48-0.40+1.38-1.50+1.06+0.64-0.78+0.12-0.85-2.53-0.18-0.05+1.08+0.81+0.26)/20;
  hphobic.norm.aux=((0.62-hphobic.norm)^2+(0.29-hphobic.norm)^2+(-0.90-hphobic.norm)^2+(-0.74-hphobic.norm)^2+(1.19-hphobic.norm)^2+(0.48-hphobic.norm)^2+(-0.40-hphobic.norm)^2+(1.38-hphobic.norm)^2+(-1.50-hphobic.norm)^2+(1.06-hphobic.norm)^2+(0.64-hphobic.norm)^2+(-0.78-hphobic.norm)^2+(0.12-hphobic.norm)^2+(-0.85-hphobic.norm)^2+(-2.53-hphobic.norm)^2+(-0.18-hphobic.norm)^2+(-0.05-hphobic.norm)^2+(1.08-hphobic.norm)^2+(0.81-hphobic.norm)^2+(0.26-hphobic.norm)^2);
  hphobic.norm.res=sqrt(hphobic.norm.aux/20);
  hphobic.seq.norm=(hphobic.seq-hphobic.norm)/hphobic.norm.res;
  
  ########################## Normalization  for Hydrophilic value#############################
  hphilic.norm=(-0.5-1.0+3.0+3.0-2.5+0-0.5-1.8+3.0-1.8-1.3+0.2+0+0.2+3.0+0.3-0.4-1.5-3.4-2.3)/20;
  hphilic.norm.aux=((-0.5-hphilic.norm)^2+(-1.0-hphilic.norm)^2+(3.0-hphilic.norm)^2+(3.0-hphilic.norm)^2+(-2.5-hphilic.norm)^2+(0-hphilic.norm)^2+(-0.5-hphilic.norm)^2+(-1.8-hphilic.norm)^2+(3.0-hphilic.norm)^2+(-1.8-hphilic.norm)^2+(-1.3-hphilic.norm)^2+(0.2-hphilic.norm)^2+(0-hphilic.norm)^2+(0.2-hphilic.norm)^2+(3.0-hphilic.norm)^2+(0.3-hphilic.norm)^2+(-0.4-hphilic.norm)^2+(-1.5-hphilic.norm)^2+(-3.4-hphilic.norm)^2+(-2.3-hphilic.norm)^2);
  hphilic.norm.res=sqrt(hphilic.norm.aux/20);
  hphilic.seq.norm=(hphilic.seq-hphilic.norm)/hphilic.norm.res
  
  ############################Hydrophobic Correlation factors##########################################
  
  hphobic.size=length(hphobic.seq.norm);
  lambda=5;
  hphobic.corr.factor = c()
  for(k in 1:lambda){
    hphobic.corr.iter=0;
    for(i in 1:(hphobic.size-k)){
      hphobic.corr.iter=hphobic.corr.iter+(hphobic.seq.norm[i]*hphobic.seq.norm[k+i]);
    }
    hphobic.corr.factor=c(hphobic.corr.factor,hphobic.corr.iter/(hphobic.size-k));
  }
  
  ############################Hydrophilic Correlation factors##########################################
  hphilic.size=length(hphilic.seq.norm);
  lambda=5;
  hydrophilic.corr.factor = c()
  
  for(k in 1:lambda){
    hphilic.corr.iter=0
    for(i in 1:(hphilic.size-k)){
      hphilic.corr.iter=hphilic.corr.iter+(hphilic.seq.norm[i]*hphilic.seq.norm[k+i]);
    }
    hydrophilic.corr.factor=c(hydrophilic.corr.factor,hphilic.corr.iter/(hphilic.size-k))
  }
  
  correlation.factors=c(hphobic.corr.factor, hydrophilic.corr.factor)
  ################ PseAAC Computation ###########################
  weight=0.1;
  AAC.features=extractAAC(sequence)
  AAC.features=AAC.features[c(2,11,16,17,15,1,8,20,12,3,7,9,6,4,19,5,14,10,13,18)]
  first.features = c()
  lambda.features = c()
  #A1=A(z,:);
  for(i in 1:20){
    first.features=c(first.features,AAC.features[i]/(sum(AAC.features)+weight*sum(correlation.factors)))
  }
  
  for(k in 1:(2*lambda)){
    lambda.features=c(lambda.features,(weight*correlation.factors[k])/(sum(AAC.features)+weight*sum(correlation.factors)))
  }
  
  PseAACfeatures=c(first.features,lambda.features)
  
  PseAACfeatures
  
}
