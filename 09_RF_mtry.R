for (species_num in 1:23) {
  t1<-Sys.time()
  t1
  
  load("~/Hosky/ECE_Revision/SDM_Species_Result/RF_mtry/Null_Variable.RData")
  load(Species_RDdata_file[species_num])
  ##############################################################################
  PCC_index_0.70<-read.table("~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.70_Species_Select_Variable.txt")
  PCC_index_0.70_index<-which(PCC_index_0.70[,1]=="x")
  
  
  PCC_index_0.75<-read.table("~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.75_Species_Select_Variable.txt")
  PCC_index_0.75_index<-which(PCC_index_0.75[,1]=="x")
  
  PCC_index_0.80<-read.table("~/Hosky/ECE_Revision/Pearson_Select_Variable_Code/Pearson_0.80_Species_Select_Variable.txt")
  PCC_index_0.80_index<-which(PCC_index_0.80[,1]=="x")
  ##############################################################################
  for (i in 1:nCV) {
    library(biomod2, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    a<-SampleMat2(ref = MP_DataSpecies$M_punicea,ratio = 0.8) 
    calib<-MP_DataSpecies[a$calibration, ]##
    eval<-MP_DataSpecies[a$evaluation, ]##
    ####################################SDM:RF##################################
    #nodesize:Minimum size of terminal nodes. Setting this number larger causes smaller trees to be grown (and thus take less time). Note that the default values are different for classification (1) and regression (5).
    #nodesize=40,20,1
    #mtry:Number of variables randomly sampled as candidates at each split. Note that the default values are different for classification (sqrt(p) where p is number of variables in x) and regression (p/3)
    #mtry=15,10,5
    #######################################RF_0.7###################################
    library(randomForest, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
    library(survival, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    library(ggplot2, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_0.70"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_0.70"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_0.70"]<-SE+SP-1
    
    #######################################RF_0.75###################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_0.75"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_0.75"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_0.75"]<-SE+SP-1
    #######################################RF_0.80##############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_0.80"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_0.80"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_0.80"]<-SE+SP-1

    #######################################RF_PCA6##############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_PCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_PCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_PCA6"]<-SE+SP-1
    ############################################################################

    ####################################RF_KPCA6################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(KPC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_KPCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_KPCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_KPCA6"]<-SE+SP-1
    ############################################################################

    ####################################RF_UMAP#################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(UMAP_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_UMAP6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_UMAP6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_UMAP6"]<-SE+SP-1
    ############################################################################

    ####################################RF_ICA##################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(ICA_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=5)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF_mtry_ICA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF_mtry_ICA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF_mtry_ICA6"]<-SE+SP-1
    ############################################################################

    #######################################RF1_0.70##################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_0.70"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_0.70"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_0.70"]<-SE+SP-1
    #######################################RF1_0.75##################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
    
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_0.75"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_0.75"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_0.75"]<-SE+SP-1
    #######################################RF1_0.80##################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
    
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_0.80"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_0.80"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_0.80"]<-SE+SP-1
    ############################################################################

    ######################################RF1_PCA6##############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_PCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_PCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_PCA6"]<-SE+SP-1
    ############################################################################
 
    ####################################RF1_KPCA6###############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(KPC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_KPCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_KPCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_KPCA6"]<-SE+SP-1
    ############################################################################
 
    ####################################RF1_UMAP################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(UMAP_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_UMAP6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_UMAP6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_UMAP6"]<-SE+SP-1
    ############################################################################

    ####################################RF1_ICA#################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(ICA_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=10)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF1_mtry_ICA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF1_mtry_ICA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF1_mtry_ICA6"]<-SE+SP-1
    ############################################################################

    #######################################RF2_0.70#############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
    
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_0.70"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_0.70"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_0.70"]<-SE+SP-1
    #######################################RF2_0.75#############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
    
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_0.75"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_0.75"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_0.75"]<-SE+SP-1
    #######################################RF2_0.80#############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
    
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_0.80"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_0.80"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_0.80"]<-SE+SP-1
    ############################################################################

    #######################################RF2_PCA6##############################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(PC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_PCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_PCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_PCA6"]<-SE+SP-1
    ############################################################################
 
    ###################################RF2_KPCA6################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(KPC_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_KPCA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_KPCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_KPCA6"]<-SE+SP-1
    ############################################################################

    ###################################RF2_UMAP#################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(UMAP_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_UMAP6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_UMAP6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_UMAP6"]<-SE+SP-1
    ############################################################################
  
    ###################################RF2_ICA##################################
    library(randomForest)
    RF_mod <- randomForest(x = calib[, c(ICA_index[1:num])], 
                           y = as.factor(calib$M_punicea), 
                           ntree = 1000, nodesize=20,importance = TRUE, mtry=15)
  
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(RF_mod, eval, type = "prob")[, 2]
    AUC_results[i,"RF2_mtry_ICA6"] <- somers2(Pred_test, eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)

    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"RF2_mtry_ICA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"RF2_mtry_ICA6"]<-SE+SP-1
    ############################################################################
 }

  t2<-Sys.time()
  t2
  write.csv(AUC_results,file=Species_Result_AUC_file[species_num])
  write.csv(Kappa_results,file=Species_Result_KAPPA_file[species_num])
  write.csv(TSS_results,file=Species_Result_TSS_file[species_num])

  rm(list=ls())
}
