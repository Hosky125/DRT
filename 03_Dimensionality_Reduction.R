#Dimensionality reduction

library(raster)
library(rgdal)
library(dismo)
library(psych)
library(kernlab)
library(fastICA)
library(umap)

library(raster)
load("~/Hosky/ECE_Revision/Environment_Data/Environment_Data.RData")
####################################################################
Species_data_file<-list.files(path = "~/Hosky/ECE_Revision/Species_Data/")
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

for (i in 1:length(Species_data_file)) {
  t0<-Sys.time()
  t0
  M_punicea_pre<-read.csv(Species_data_file[i])[,-1]
  M_punicea_pre<-na.omit(M_punicea_pre)
  names(M_punicea_pre)[3]<-c("M_punicea")
  names(M_punicea_pre)[1:2]<-c("Longitude","Latitude")
  
  Select_Env<- extract(Env_Var, M_punicea_pre[, c(1, 2)])
  Select_Env<- cbind(M_punicea_pre, Select_Env)
  Select_Env<- data.frame(na.omit(Select_Env))
  
  #data_cor<-cor(Select_Env[,4:48])
  #library(corrplot)
  #corrplot.mixed(data_cor,tl.col="black",tl.pos = "d",number.cex = 0.8)
  #BIO2、BIO7、BIO10、BIO11、BIO16、BIO17

#1. Identify the study area
#2. Extract environmental data according to the study area
#3. Generate pseudo-missing points in the study area according to species existing data, and build training and test data sets
#4. Dimensionality reduction of data set
#4.1 Principal component analysis, PCA
#4.2 Independent component analysis, ICA
#4.3 Core principal component analysis, KPCA
#4.4Uniform Manifold Approximation and Projection, UMAP

  TP.ext<-extent(floor(min(M_punicea_pre[,1]))-0.99,floor(max(M_punicea_pre[,1]))+0.99,
                 floor(min(M_punicea_pre[,2]))-0.99,floor(max(M_punicea_pre[,2]))+0.99)
  TP.ext

  Env_Var_TP<-crop(Env_Var,TP.ext)
  Env_Var_TP_df<-as.data.frame(Env_Var_TP,xy=T)
  Env_Var_TP_df<-na.omit(Env_Var_TP_df)

  library(dismo)
  BIO4.crop<-crop(BIO4,TP.ext)
  M.matrix.p<-data.matrix(M_punicea_pre[,1:2])

  n<-nrow(M_punicea_pre)
  M.pse_abs<-randomPoints(BIO4.crop, n*3,p=M.matrix.p,ext=TP.ext,excludep=TRUE)
  M.pse_abs<-transform(M.pse_abs,M_punicea=0)##追加一列，表示物种数为0
  names(M.pse_abs)[1:2]<-c("Longitude","Latitude")

  DataSpecies<-rbind(M_punicea_pre,M.pse_abs)

  Env<- extract(Env_Var, DataSpecies[, c(1, 2)])
  DataSpecies <- cbind(DataSpecies, Env)
  MP_DataSpecies<- data.frame(na.omit(DataSpecies))


  library(psych)
  MP_standard<-scale(MP_DataSpecies[,4:48],scale=T,center=T)
  head(MP_standard)
  MP_standard<-as.data.frame(MP_standard)

  MP_Prcomp<-princomp(MP_standard,scores = T,fix_sign = TRUE)
  #eigen(cov(MP_standard))
  summary(MP_Prcomp,loadings=T)

  for (j in 1:length(MP_Prcomp$sdev)){
    if (MP_Prcomp$sdev[j]<1)
      break
    num<-j
    }
  pre<-predict(MP_Prcomp)

  for (k in 1:num){
    MP_DataSpecies<-cbind(MP_DataSpecies,pre[,k])
    }
  PC_index<-c("PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10",
            "PC11","PC12","PC13","PC14","PC15","PC16","PC17","PC18","PC19","PC20",
            "PC21","PC22","PC23","PC24","PC25","PC26","PC27","PC28","PC29","PC30",
            "PC31","PC32","PC33","PC34","PC35","PC36","PC37","PC38","PC39","PC40",
            "PC41","PC42","PC43","PC44","PC45")
  names(MP_DataSpecies)[49:(49+num-1)]<-PC_index[1:num]

###############################################################
  #rbfdot #Radial Basis kernel function "Gaussian"
  #polydot #Polynomial kernel function
  #vanilladot #Linear kernel function
  #tanhdot #Hyperbolic tangent kernel function
  #laplacedot #Laplacian kernel function
  #besseldot #Bessel kernel function
  #anovadot #ANOVA RBF kernel function
  #splinedot #Spline kernel
  library(kernlab)
  KPC<- kpca(~.,data=MP_standard,
             kernel="rbfdot",
             kpar=list(sigma=0.1),
             features=num)

  #predict(KPC,MP_DataSpecies[4:48])=KPC@rotated
  for (k in 1:num){
    MP_DataSpecies<-cbind(MP_DataSpecies,KPC@rotated[,k])
    }
  KPC_index<-c("KPC1","KPC2","KPC3","KPC4","KPC5","KPC6","KPC7","KPC8","KPC9","KPC10",
               "KPC11","KPC12","KPC13","KPC14","KPC15","KPC16","KPC17","KPC18","KPC19","KPC20",
               "KPC21","KPC22","KPC23","KPC24","KPC25","KPC26","KPC27","KPC28","KPC29","KPC30",
               "KPC31","KPC32","KPC33","KPC34","KPC35","KPC36","KPC37","KPC38","KPC39","KPC40",
               "KPC41","KPC42","KPC43","KPC44","KPC45")
  names(MP_DataSpecies)[(49+num):(49+num+num-1)]<-KPC_index[1:num]

  ########################################################
  library(fastICA)
  ICA<-fastICA(MP_standard,
               n.comp=num,
               alg.typ = "parallel", 
               fun = "logcosh", 
               alpha = 1, 
               method = "R", 
               row.norm = FALSE, 
               maxit = 200, 
               tol = 0.0001, 
               verbose = TRUE)
  ##A list containing the following components
  #X	pre-processed data matrix
  #K	pre-whitening matrix that projects data onto the first n.comp principal components.
  #W	estimated un-mixing matrix (see definition in details)
  #A	estimated mixing matrix
  #S	estimated source matrix
  for (k in 1:num){
    MP_DataSpecies<-cbind(MP_DataSpecies,ICA$S[,k])
    }
  ICA_index<-c("ICA1","ICA2","ICA3","ICA4","ICA5","ICA6","ICA7","ICA8","ICA9","ICA10",
               "ICA11","ICA12","ICA13","ICA14","ICA15","ICA16","ICA17","ICA18","ICA19","ICA20",
               "ICA21","ICA22","ICA23","ICA24","ICA25","ICA26","ICA27","ICA28","ICA29","ICA30",
               "ICA31","ICA32","ICA33","ICA34","ICA35","ICA36","ICA37","ICA38","ICA39","ICA40",
               "ICA41","ICA42","ICA43","ICA44","ICA45")
  names(MP_DataSpecies)[(49+num+num):(49+num+num+num-1)]<-ICA_index[1:num]

  ##################################################################
  library(umap)
  UMAP<-umap(MP_standard,n_components=num)
  for (k in 1:num){
    MP_DataSpecies<-cbind(MP_DataSpecies,UMAP$layout[,k])
    }
  UMAP_index<-c("UMAP1","UMAP2","UMAP3","UMAP4","UMAP5","UMAP6","UMAP7","UMAP8","UMAP9","UMAP10",
                "UMAP11","UMAP12","UMAP13","UMAP14","UMAP15","UMAP16","UMAP17","UMAP18","UMAP19","UMAP20",
                "UMAP21","UMAP22","UMAP23","UMAP24","UMAP25","UMAP26","UMAP27","UMAP28","UMAP29","UMAP30",
                "UMAP31","UMAP32","UMAP33","UMAP34","UMAP35","UMAP36","UMAP37","UMAP38","UMAP39","UMAP40",
                "UMAP41","UMAP42","UMAP43","UMAP44","UMAP45")
  names(MP_DataSpecies)[(49+num+num+num):(49+num+num+num+num-1)]<-UMAP_index[1:num]
################################################################################
  t1<-Sys.time()
  t1
  save.image(Species_RDdata_file[i])
}
