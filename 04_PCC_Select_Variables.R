#PCC select environmental variables
Species_RDdata_file<-c("~/Hosky/ECE_Revision/Species_DRT_Data/Ageratum3137.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Alocasia683.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Camellia1406.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Ceratopteris1387.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Chamaecyparis1316.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cinnamomum7405.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Conyza4050.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cypripedium72.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Gymnogrammitis60.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Herminium6321.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Impatiens2976.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Lycoris1947.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_horridula252.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_integrifolia283.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_punicea113.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Metasequoia4517.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Oxalis5509.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Passiflora78.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinellia930.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinus375.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Prunus2846.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Sphagnum19710.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Taiwania123.RData")

for (species_num in 1:length(Species_RDdata_file)) {
  load(Species_RDdata_file[species_num])
  data_cor<-cor(Select_Env[,4:48])
  Slect_PC_1<-c()
  num<-c()
  
  for (i in 1:45) {
    PC7<-which( abs(data_cor[i:45,i]) >0.7 )
    num<-c(num,length(PC7))
    Slect_PC_1<-c(Slect_PC_1,colnames(data_cor)[PC7+i-1])
  }
  
  Slect_PC_2<-colnames(data_cor)[which(num==1)]
  sum<-0
  
  for (j in 1:45) {
    n<-0
    if (num[j]!=1) {
      for  (k in 1:length(Slect_PC_2)) {
        if (Slect_PC_2[k] %in% Slect_PC_1[(sum+1):(sum+num[j])]) {
          #print(Slect_PC_2[k])
          n<-n+1      
        } 
      }
      
      if (n<1) {
        Slect_PC_2<-c(Slect_PC_2,sample(Slect_PC_1[(sum+1):(sum+num[j])],1))
      }
      
      sum<-sum(num[1:j])
    }
  }
  print(Slect_PC_2)
  write.table(Slect_PC_2,"~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.70_Species_Select_Variable.txt",append=T)
}

Species_RDdata_file<-c("~/Hosky/ECE_Revision/Species_DRT_Data/Ageratum3137.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Alocasia683.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Camellia1406.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Ceratopteris1387.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Chamaecyparis1316.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cinnamomum7405.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Conyza4050.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cypripedium72.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Gymnogrammitis60.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Herminium6321.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Impatiens2976.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Lycoris1947.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_horridula252.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_integrifolia283.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_punicea113.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Metasequoia4517.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Oxalis5509.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Passiflora78.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinellia930.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinus375.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Prunus2846.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Sphagnum19710.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Taiwania123.RData")

for (species_num in 1:length(Species_RDdata_file)) {
  load(Species_RDdata_file[species_num])
  data_cor<-cor(Select_Env[,4:48])
  Slect_PC_1<-c()
  num<-c()
  
  for (i in 1:45) {
    PC7<-which( abs(data_cor[i:45,i]) >0.75 )
    num<-c(num,length(PC7))
    Slect_PC_1<-c(Slect_PC_1,colnames(data_cor)[PC7+i-1])
  }
  
  Slect_PC_2<-colnames(data_cor)[which(num==1)]
  sum<-0
  
  for (j in 1:45) {
    n<-0
    if (num[j]!=1) {
      for  (k in 1:length(Slect_PC_2)) {
        if (Slect_PC_2[k] %in% Slect_PC_1[(sum+1):(sum+num[j])]) {
          #print(Slect_PC_2[k])
          n<-n+1      
        } 
      }
      
      if (n<1) {
        Slect_PC_2<-c(Slect_PC_2,sample(Slect_PC_1[(sum+1):(sum+num[j])],1))
      }
      
      sum<-sum(num[1:j])
    }
  }
  print(Slect_PC_2)
  write.table(Slect_PC_2,"~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.75_Species_Select_Variable.txt",append=T)
}


Species_RDdata_file<-c("~/Hosky/ECE_Revision/Species_DRT_Data/Ageratum3137.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Alocasia683.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Camellia1406.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Ceratopteris1387.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Chamaecyparis1316.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cinnamomum7405.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Conyza4050.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Cypripedium72.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Gymnogrammitis60.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Herminium6321.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Impatiens2976.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Lycoris1947.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_horridula252.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_integrifolia283.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/M_punicea113.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Metasequoia4517.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Oxalis5509.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Passiflora78.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinellia930.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Pinus375.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Prunus2846.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Sphagnum19710.RData",
                       "~/Hosky/ECE_Revision/Species_DRT_Data/Taiwania123.RData")

for (species_num in 1:length(Species_RDdata_file)) {
  load(Species_RDdata_file[species_num])
  data_cor<-cor(Select_Env[,4:48])
  Slect_PC_1<-c()
  num<-c()
  
  for (i in 1:45) {
    PC7<-which( abs(data_cor[i:45,i]) >0.8 )
    num<-c(num,length(PC7))
    Slect_PC_1<-c(Slect_PC_1,colnames(data_cor)[PC7+i-1])
  }
  
  Slect_PC_2<-colnames(data_cor)[which(num==1)]
  sum<-0
  
  for (j in 1:45) {
    n<-0
    if (num[j]!=1) {
      for  (k in 1:length(Slect_PC_2)) {
        if (Slect_PC_2[k] %in% Slect_PC_1[(sum+1):(sum+num[j])]) {
          #print(Slect_PC_2[k])
          n<-n+1      
        } 
      }
      
      if (n<1) {
        Slect_PC_2<-c(Slect_PC_2,sample(Slect_PC_1[(sum+1):(sum+num[j])],1))
      }
      
      sum<-sum(num[1:j])
    }
  }
  print(Slect_PC_2)
  write.table(Slect_PC_2,"~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.80_Species_Select_Variable.txt",append=T)
}