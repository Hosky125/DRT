
nCV<-30
AUC_results<-as.data.frame(matrix(0, ncol = 147, nrow = nCV))
names(AUC_results)<-c("GLM_0.70", "GLM_0.75","GLM_0.80",
                      "GLM_PCA6","GLM_KPCA6","GLM_ICA6","GLM_UMAP6", 
                      "GLM1_0.70","GLM1_0.75","GLM1_0.80",
                      "GLM1_PCA6","GLM1_KPCA6","GLM1_ICA6","GLM1_UMAP6", 
                      "GLM2_0.70","GLM2_0.75","GLM2_0.80",
                      "GLM2_PCA6","GLM2_KPCA6","GLM2_ICA6","GLM2_UMAP6", 
                      
                      "GBM_ntrees_0.70","GBM_ntrees_0.75","GBM_ntrees_0.80",
                      "GBM_ntrees_PCA6","GBM_ntrees_KPCA6","GBM_ntrees_ICA6","GBM_ntrees_UMAP6", 
                      "GBM1_ntrees_0.70","GBM1_ntrees_0.75","GBM1_ntrees_0.80",
                      "GBM1_ntrees_PCA6","GBM1_ntrees_KPCA6","GBM1_ntrees_ICA6","GBM1_ntrees_UMAP6", 
                      "GBM2_ntrees_0.70","GBM2_ntrees_0.75","GBM2_ntrees_0.80",
                      "GBM2_ntrees_PCA6","GBM2_ntrees_KPCA6","GBM2_ntrees_ICA6","GBM2_ntrees_UMAP6",
                      
                      "GBM_interaction_depth_0.70","GBM_interaction_depth_0.75","GBM_interaction_depth_0.80",
                      "GBM_interaction_depth_PCA6","GBM_interaction_depth_KPCA6","GBM_interaction_depth_ICA6","GBM_interaction_depth_UMAP6", 
                      "GBM1_interaction_depth_0.70","GBM1_interaction_depth_0.75","GBM1_interaction_depth_0.80",
                      "GBM1_interaction_depth_PCA6","GBM1_interaction_depth_KPCA6","GBM1_interaction_depth_ICA6","GBM1_interaction_depth_UMAP6", 
                      "GBM2_interaction_depth_0.70","GBM2_interaction_depth_0.75","GBM2_interaction_depth_0.80",
                      "GBM2_interaction_depth_PCA6","GBM2_interaction_depth_KPCA6","GBM2_interaction_depth_ICA6","GBM2_interaction_depth_UMAP6",
                      
                      "RF_nodesize_0.70","RF_nodesize_0.75","RF_nodesize_0.80",
                      "RF_nodesize_PCA6","RF_nodesize_KPCA6","RF_nodesize_ICA6","RF_nodesize_UMAP6", 
                      "RF1_nodesize_0.70","RF1_nodesize_0.75","RF1_nodesize_0.80",
                      "RF1_nodesize_PCA6","RF1_nodesize_KPCA6","RF1_nodesize_ICA6","RF1_nodesize_UMAP6", 
                      "RF2_nodesize_0.70","RF2_nodesize_0.75","RF2_nodesize_0.80",
                      "RF2_nodesize_PCA6","RF2_nodesize_KPCA6","RF2_nodesize_ICA6","RF2_nodesize_UMAP6", 
                      
                      "RF_mtry_0.70","RF_mtry_0.75","RF_mtry_0.80",
                      "RF_mtry_PCA6","RF_mtry_KPCA6","RF_mtry_ICA6","RF_mtry_UMAP6", 
                      "RF1_mtry_0.70","RF1_mtry_0.75","RF1_mtry_0.80",
                      "RF1_mtry_PCA6","RF1_mtry_KPCA6","RF1_mtry_ICA6","RF1_mtry_UMAP6", 
                      "RF2_mtry_0.70","RF2_mtry_0.75","RF2_mtry_0.80",
                      "RF2_mtry_PCA6","RF2_mtry_KPCA6","RF2_mtry_ICA6","RF2_mtry_UMAP6", 
                      
                      "FDA_0.70","FDA_0.75","FDA_0.80",
                      "FDA_PCA6","FDA_KPCA6","FDA_ICA6","FDA_UMAP6", 
                      "FDA1_0.70","FDA1_0.75","FDA1_0.80",
                      "FDA1_PCA6","FDA1_KPCA6","FDA1_ICA6","FDA1_UMAP6", 
                      "FDA2_0.70","FDA2_0.75","FDA2_0.80",
                      "FDA2_PCA6","FDA2_KPCA6","FDA2_ICA6","FDA2_UMAP6",
                      
                      "ANN_0.70", "ANN_0.75","ANN_0.80",
                      "ANN_PCA6","ANN_KPCA6","ANN_ICA6","ANN_UMAP6", 
                      "ANN1_0.70","ANN1_0.75","ANN1_0.80",
                      "ANN1_PCA6","ANN1_KPCA6","ANN1_ICA6","ANN1_UMAP6", 
                      "ANN2_0.70","ANN2_0.75","ANN2_0.80",
                      "ANN2_PCA6","ANN2_KPCA6","ANN2_ICA6","ANN2_UMAP6")


Kappa_results<-as.data.frame(matrix(0, ncol = 147, nrow = nCV))
names(Kappa_results)<-c("GLM_0.70", "GLM_0.75","GLM_0.80",
                        "GLM_PCA6","GLM_KPCA6","GLM_ICA6","GLM_UMAP6", 
                        "GLM1_0.70","GLM1_0.75","GLM1_0.80",
                        "GLM1_PCA6","GLM1_KPCA6","GLM1_ICA6","GLM1_UMAP6", 
                        "GLM2_0.70","GLM2_0.75","GLM2_0.80",
                        "GLM2_PCA6","GLM2_KPCA6","GLM2_ICA6","GLM2_UMAP6", 
                        
                        "GBM_ntrees_0.70","GBM_ntrees_0.75","GBM_ntrees_0.80",
                        "GBM_ntrees_PCA6","GBM_ntrees_KPCA6","GBM_ntrees_ICA6","GBM_ntrees_UMAP6", 
                        "GBM1_ntrees_0.70","GBM1_ntrees_0.75","GBM1_ntrees_0.80",
                        "GBM1_ntrees_PCA6","GBM1_ntrees_KPCA6","GBM1_ntrees_ICA6","GBM1_ntrees_UMAP6", 
                        "GBM2_ntrees_0.70","GBM2_ntrees_0.75","GBM2_ntrees_0.80",
                        "GBM2_ntrees_PCA6","GBM2_ntrees_KPCA6","GBM2_ntrees_ICA6","GBM2_ntrees_UMAP6",
                        
                        "GBM_interaction_depth_0.70","GBM_interaction_depth_0.75","GBM_interaction_depth_0.80",
                        "GBM_interaction_depth_PCA6","GBM_interaction_depth_KPCA6","GBM_interaction_depth_ICA6","GBM_interaction_depth_UMAP6", 
                        "GBM1_interaction_depth_0.70","GBM1_interaction_depth_0.75","GBM1_interaction_depth_0.80",
                        "GBM1_interaction_depth_PCA6","GBM1_interaction_depth_KPCA6","GBM1_interaction_depth_ICA6","GBM1_interaction_depth_UMAP6", 
                        "GBM2_interaction_depth_0.70","GBM2_interaction_depth_0.75","GBM2_interaction_depth_0.80",
                        "GBM2_interaction_depth_PCA6","GBM2_interaction_depth_KPCA6","GBM2_interaction_depth_ICA6","GBM2_interaction_depth_UMAP6",
                        
                        "RF_nodesize_0.70","RF_nodesize_0.75","RF_nodesize_0.80",
                        "RF_nodesize_PCA6","RF_nodesize_KPCA6","RF_nodesize_ICA6","RF_nodesize_UMAP6", 
                        "RF1_nodesize_0.70","RF1_nodesize_0.75","RF1_nodesize_0.80",
                        "RF1_nodesize_PCA6","RF1_nodesize_KPCA6","RF1_nodesize_ICA6","RF1_nodesize_UMAP6", 
                        "RF2_nodesize_0.70","RF2_nodesize_0.75","RF2_nodesize_0.80",
                        "RF2_nodesize_PCA6","RF2_nodesize_KPCA6","RF2_nodesize_ICA6","RF2_nodesize_UMAP6", 
                        
                        "RF_mtry_0.70","RF_mtry_0.75","RF_mtry_0.80",
                        "RF_mtry_PCA6","RF_mtry_KPCA6","RF_mtry_ICA6","RF_mtry_UMAP6", 
                        "RF1_mtry_0.70","RF1_mtry_0.75","RF1_mtry_0.80",
                        "RF1_mtry_PCA6","RF1_mtry_KPCA6","RF1_mtry_ICA6","RF1_mtry_UMAP6", 
                        "RF2_mtry_0.70","RF2_mtry_0.75","RF2_mtry_0.80",
                        "RF2_mtry_PCA6","RF2_mtry_KPCA6","RF2_mtry_ICA6","RF2_mtry_UMAP6", 
                        
                        "FDA_0.70","FDA_0.75","FDA_0.80",
                        "FDA_PCA6","FDA_KPCA6","FDA_ICA6","FDA_UMAP6", 
                        "FDA1_0.70","FDA1_0.75","FDA1_0.80",
                        "FDA1_PCA6","FDA1_KPCA6","FDA1_ICA6","FDA1_UMAP6", 
                        "FDA2_0.70","FDA2_0.75","FDA2_0.80",
                        "FDA2_PCA6","FDA2_KPCA6","FDA2_ICA6","FDA2_UMAP6",
                        
                        "ANN_0.70", "ANN_0.75","ANN_0.80",
                        "ANN_PCA6","ANN_KPCA6","ANN_ICA6","ANN_UMAP6", 
                        "ANN1_0.70","ANN1_0.75","ANN1_0.80",
                        "ANN1_PCA6","ANN1_KPCA6","ANN1_ICA6","ANN1_UMAP6", 
                        "ANN2_0.70","ANN2_0.75","ANN2_0.80",
                        "ANN2_PCA6","ANN2_KPCA6","ANN2_ICA6","ANN2_UMAP6")



TSS_results<-as.data.frame(matrix(0, ncol = 147, nrow = nCV))
names(TSS_results)<-c("GLM_0.70", "GLM_0.75","GLM_0.80",
                      "GLM_PCA6","GLM_KPCA6","GLM_ICA6","GLM_UMAP6", 
                      "GLM1_0.70","GLM1_0.75","GLM1_0.80",
                      "GLM1_PCA6","GLM1_KPCA6","GLM1_ICA6","GLM1_UMAP6", 
                      "GLM2_0.70","GLM2_0.75","GLM2_0.80",
                      "GLM2_PCA6","GLM2_KPCA6","GLM2_ICA6","GLM2_UMAP6", 
                      
                      "GBM_ntrees_0.70","GBM_ntrees_0.75","GBM_ntrees_0.80",
                      "GBM_ntrees_PCA6","GBM_ntrees_KPCA6","GBM_ntrees_ICA6","GBM_ntrees_UMAP6", 
                      "GBM1_ntrees_0.70","GBM1_ntrees_0.75","GBM1_ntrees_0.80",
                      "GBM1_ntrees_PCA6","GBM1_ntrees_KPCA6","GBM1_ntrees_ICA6","GBM1_ntrees_UMAP6", 
                      "GBM2_ntrees_0.70","GBM2_ntrees_0.75","GBM2_ntrees_0.80",
                      "GBM2_ntrees_PCA6","GBM2_ntrees_KPCA6","GBM2_ntrees_ICA6","GBM2_ntrees_UMAP6",
                      
                      "GBM_interaction_depth_0.70","GBM_interaction_depth_0.75","GBM_interaction_depth_0.80",
                      "GBM_interaction_depth_PCA6","GBM_interaction_depth_KPCA6","GBM_interaction_depth_ICA6","GBM_interaction_depth_UMAP6", 
                      "GBM1_interaction_depth_0.70","GBM1_interaction_depth_0.75","GBM1_interaction_depth_0.80",
                      "GBM1_interaction_depth_PCA6","GBM1_interaction_depth_KPCA6","GBM1_interaction_depth_ICA6","GBM1_interaction_depth_UMAP6", 
                      "GBM2_interaction_depth_0.70","GBM2_interaction_depth_0.75","GBM2_interaction_depth_0.80",
                      "GBM2_interaction_depth_PCA6","GBM2_interaction_depth_KPCA6","GBM2_interaction_depth_ICA6","GBM2_interaction_depth_UMAP6",
                      
                      "RF_nodesize_0.70","RF_nodesize_0.75","RF_nodesize_0.80",
                      "RF_nodesize_PCA6","RF_nodesize_KPCA6","RF_nodesize_ICA6","RF_nodesize_UMAP6", 
                      "RF1_nodesize_0.70","RF1_nodesize_0.75","RF1_nodesize_0.80",
                      "RF1_nodesize_PCA6","RF1_nodesize_KPCA6","RF1_nodesize_ICA6","RF1_nodesize_UMAP6", 
                      "RF2_nodesize_0.70","RF2_nodesize_0.75","RF2_nodesize_0.80",
                      "RF2_nodesize_PCA6","RF2_nodesize_KPCA6","RF2_nodesize_ICA6","RF2_nodesize_UMAP6", 
                      
                      "RF_mtry_0.70","RF_mtry_0.75","RF_mtry_0.80",
                      "RF_mtry_PCA6","RF_mtry_KPCA6","RF_mtry_ICA6","RF_mtry_UMAP6", 
                      "RF1_mtry_0.70","RF1_mtry_0.75","RF1_mtry_0.80",
                      "RF1_mtry_PCA6","RF1_mtry_KPCA6","RF1_mtry_ICA6","RF1_mtry_UMAP6", 
                      "RF2_mtry_0.70","RF2_mtry_0.75","RF2_mtry_0.80",
                      "RF2_mtry_PCA6","RF2_mtry_KPCA6","RF2_mtry_ICA6","RF2_mtry_UMAP6", 
                      
                      "FDA_0.70","FDA_0.75","FDA_0.80",
                      "FDA_PCA6","FDA_KPCA6","FDA_ICA6","FDA_UMAP6", 
                      "FDA1_0.70","FDA1_0.75","FDA1_0.80",
                      "FDA1_PCA6","FDA1_KPCA6","FDA1_ICA6","FDA1_UMAP6", 
                      "FDA2_0.70","FDA2_0.75","FDA2_0.80",
                      "FDA2_PCA6","FDA2_KPCA6","FDA2_ICA6","FDA2_UMAP6",
                      
                      "ANN_0.70", "ANN_0.75","ANN_0.80",
                      "ANN_PCA6","ANN_KPCA6","ANN_ICA6","ANN_UMAP6", 
                      "ANN1_0.70","ANN1_0.75","ANN1_0.80",
                      "ANN1_PCA6","ANN1_KPCA6","ANN1_ICA6","ANN1_UMAP6", 
                      "ANN2_0.70","ANN2_0.75","ANN2_0.80",
                      "ANN2_PCA6","ANN2_KPCA6","ANN2_ICA6","ANN2_UMAP6")

################################################################################

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

Species_Result_AUC_file<-c("~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ageratum3137_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Alocasia683_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Camellia1406_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ceratopteris1387_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Chamaecyparis1316_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cinnamomum7405_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Conyza4050_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cypripedium72_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Gymnogrammitis60_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Herminium6321_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Impatiens2976_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Lycoris1947_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_horridula252_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_integrifolia283_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_punicea113_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Metasequoia4517_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Oxalis5509_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Passiflora78_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinellia930_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinus375_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Prunus2846_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Sphagnum19710_AUC_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Taiwania123_AUC_results75.csv")

Species_Result_KAPPA_file<-c("~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ageratum3137_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Alocasia683_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Camellia1406_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ceratopteris1387_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Chamaecyparis1316_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cinnamomum7405_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Conyza4050_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cypripedium72_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Gymnogrammitis60_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Herminium6321_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Impatiens2976_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Lycoris1947_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_horridula252_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_integrifolia283_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_punicea113_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Metasequoia4517_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Oxalis5509_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Passiflora78_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinellia930_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinus375_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Prunus2846_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Sphagnum19710_KAPPA_results75.csv",
                             "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Taiwania123_KAPPA_results75.csv")

Species_Result_TSS_file<-c("~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ageratum3137_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Alocasia683_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Camellia1406_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Ceratopteris1387_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Chamaecyparis1316_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cinnamomum7405_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Conyza4050_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Cypripedium72_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Gymnogrammitis60_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Herminium6321_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Impatiens2976_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Lycoris1947_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_horridula252_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_integrifolia283_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/M_punicea113_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Metasequoia4517_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Oxalis5509_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Passiflora78_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinellia930_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Pinus375_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Prunus2846_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Sphagnum19710_TSS_results75.csv",
                           "~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Taiwania123_TSS_results75.csv")

save.image("~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Null_Variable.RData")
#################################################################################
for (species_num in c(2,3,4,5,8,9,13,14,15,18,19,20,23)) {
  t1<-Sys.time()
  print(t1)
  
  load("~/Hosky/ECE_Revision/SDM_Species_Result/GLM_makeFormula/Null_Variable.RData")
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
    t2<-Sys.time()
    print(t2)
    library(biomod2, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    a<-SampleMat2(ref = MP_DataSpecies$M_punicea,ratio = 0.8) 
    calib<-MP_DataSpecies[a$calibration, ]
    eval<-MP_DataSpecies[a$evaluation, ] 
    ###############################SDM:GLM######################################
    ##################################GLM_0.70##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                                MP_DataSpecies[,c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])],
                               "simple",interaction.level = 1)
    library(MASS, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(survival, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    library(ggplot2, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_0.70"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence, lib.loc = "/ifs1/User/wangwenting/miniconda3/lib/R/library")
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_0.70"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_0.70"]<-SE+SP-1
    ##################################GLM_0.75##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_0.75"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_0.75"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_0.75"]<-SE+SP-1
    ##################################GLM_0.80##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_0.80"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    library(dismo)
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_0.80"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_0.80"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM_PCA6##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PC_index[1:num])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_PCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_PCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_PCA6"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM_KPCA6#################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(KPC_index[1:num])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_KPCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_KPCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_KPCA6"]<-SE+SP-1
    ###########################################################################
  
    ##################################GLM_UMAP##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(UMAP_index[1:num])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_UMAP6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ###########################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_UMAP6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_UMAP6"]<-SE+SP-1
    ###########################################################################
  
    ##################################GLM_ICA###################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(ICA_index[1:num])],
                               "simple",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM_ICA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM_ICA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM_ICA6"]<-SE+SP-1
    ############################################################################
    t3<-Sys.time()
    print(t3)
    ###########################GLM1_0.70######################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_0.70"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_0.70"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_0.70"]<-SE+SP-1
    ###########################GLM1_0.75######################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_0.75"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_0.75"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_0.75"]<-SE+SP-1
    ###########################GLM1_0.80######################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_0.80"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
    
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_0.80"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_0.80"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM1-PCA6#################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(PC_index[1:num])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_PCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
 
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_PCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_PCA6"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM1_KPCA6################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(KPC_index[1:num])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_KPCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_KPCA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_KPCA6"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM1_UMAP#################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                                MP_DataSpecies[,c(UMAP_index[1:num])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_UMAP6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_UMAP6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_UMAP6"]<-SE+SP-1
    ############################################################################
  
    ##################################GLM1_ICA##################################
    glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
    glm.formula <- makeFormula("M_punicea", 
                               MP_DataSpecies[,c(ICA_index[1:num])],
                               "quadratic",interaction.level = 1)
    library(MASS)
    glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                         direction = "both", trace = FALSE, k = 2,
                         control = glm.control(maxit = 100))
    library(Hmisc)
    # prediction on the evaluation data and evaluation using the AUC approach
    Pred_test <- predict(glmModAIC, eval, type = "response")
    AUC_results[i,"GLM1_ICA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
    ############################################################################
    p<-Pred_test[which(eval$M_punicea==1)]
    a<-Pred_test[which(eval$M_punicea==0)]
    e<-dismo::evaluate(p=p ,a=a )
    t<-threshold(e,sensitivity=0.9)
  
    library(PresenceAbsence)
    Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
    Kappa_results[i,"GLM1_ICA6"]<-Kappa(Table,st.dev = FALSE)
    SE<-sensitivity(Table, st.dev = FALSE)
    SP<-specificity(Table, st.dev = FALSE)
    TSS_results[i,"GLM1_ICA6"]<-SE+SP-1
  ##############################################################################
    t4<-Sys.time()
    print(t4)
  ###############################GLM2_0.70######################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(PCC_index_0.70[(PCC_index_0.70_index[species_num]+1):(PCC_index_0.70_index[species_num+1]-1),2])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_0.70"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_0.70"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_0.70"]<-SE+SP-1
  ###############################GLM2_0.75######################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(PCC_index_0.75[(PCC_index_0.75_index[species_num]+1):(PCC_index_0.75_index[species_num+1]-1),2])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_0.75"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_0.75"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_0.75"]<-SE+SP-1
  ###############################GLM2_0.80######################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(PCC_index_0.80[(PCC_index_0.80_index[species_num]+1):(PCC_index_0.80_index[species_num+1]-1),2])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_0.80"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_0.80"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_0.80"]<-SE+SP-1
  ##############################################################################
  
  ####################################GLM2-PCA6#################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(PC_index[1:num])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_PCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_PCA6"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_PCA6"]<-SE+SP-1
  ##############################################################################
  
  ####################################GLM2_KPCA6################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(KPC_index[1:num])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_KPCA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_KPCA6"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_KPCA6"]<-SE+SP-1
  ##############################################################################
  
  ####################################GLM2_UMAP#################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(UMAP_index[1:num])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_UMAP6"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
 
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_UMAP6"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_UMAP6"]<-SE+SP-1
  ##############################################################################
  
  ####################################GLM2_ICA##################################
  glmStart <- glm(M_punicea ~ 1, data = calib, family = binomial)
  glm.formula <- makeFormula("M_punicea", 
                             MP_DataSpecies[,c(ICA_index[1:num])],
                             "polynomial",interaction.level = 1)
  library(MASS)
  glmModAIC <- stepAIC(glmStart, glm.formula, data = calib,
                       direction = "both", trace = FALSE, k = 2,
                       control = glm.control(maxit = 100))
  library(Hmisc)
  # prediction on the evaluation data and evaluation using the AUC approach
  Pred_test <- predict(glmModAIC, eval, type = "response")
  AUC_results[i,"GLM2_ICA6"] <- somers2(Pred_test,eval$M_punicea)["C"]
  ##############################################################################
  p<-Pred_test[which(eval$M_punicea==1)]
  a<-Pred_test[which(eval$M_punicea==0)]
  e<-dismo::evaluate(p=p ,a=a )
  t<-threshold(e,sensitivity=0.9)
  
  library(PresenceAbsence)
  Table<-cmx(cbind(1:length(eval$M_punicea),eval$M_punicea, Pred_test),threshold=abs(t[1,1]),na.rm=T)
  Kappa_results[i,"GLM2_ICA6"]<-Kappa(Table,st.dev = FALSE)
  SE<-sensitivity(Table, st.dev = FALSE)
  SP<-specificity(Table, st.dev = FALSE)
  TSS_results[i,"GLM2_ICA6"]<-SE+SP-1
  ##############################################################################
}
  t5<-Sys.time()
  print(t5)
  write.csv(AUC_results,file=Species_Result_AUC_file[species_num])
  write.csv(Kappa_results,file=Species_Result_KAPPA_file[species_num])
  write.csv(TSS_results,file=Species_Result_TSS_file[species_num])

  rm(list=ls())
}