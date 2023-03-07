#--------------------------------------Construction de la base de donnée---------------------------------------------------------
{
  library(readxl)
  library(tidyr)
  library(dplyr)
}

# Importation individuelle de chaque base de donnée

EPU <- read.csv2("EPU.csv", sep = ",")
EMV <- read.csv2("EMV.csv", sep = ",")
CS <- read.csv2("CS.csv", sep = ",")
WTI <- read.csv2("WTISPLC.csv", sep = ",")
UR <- read.csv2("UNRATE.csv", sep = ",")
CPU <- read_xlsx("CPU.xlsx")

# Format de date pour série temporelle
CPU$DATE <- as.Date(CPU$DATE, format="%Y-%m-%d")
EPU$DATE <- as.Date(EPU$DATE,format="%Y-%m-%d")
EMV$DATE <- as.Date(EMV$DATE,format="%Y-%m-%d")
CS$DATE <- as.Date(CS$DATE,format="%Y-%m-%d")
WTI$DATE <- as.Date(WTI$DATE,format="%Y-%m-%d")
UR$DATE <- as.Date(UR$DATE,format="%Y-%m-%d")

# Merge des différentes variables en une seule base de donnée 

data_frames <- list(EPU, EMV, CS, WTI, UR)
base <- data_frames[[1]]

for (i in 2:length(data_frames)) {
  base <- left_join(base, data_frames[[i]], by = "DATE")
}

# On renomme les variables 

colnames(base) <- c("Date", "EPU","EMV","CS", "WTI", "UR")

# Base de donnée finale  : Transformation dans les bons formats
base[,c("EPU", "EMV", "CS", "WTI", "UR")] <- lapply(base[,c("EPU", "EMV", "CS",  "WTI", "UR")],as.numeric)
base$Date <- as.Date(base$Date, format="%Y-%m-%d")

# Vérification NA
is.na(base)
base <- slice(base,-456)
write.csv2(base2, file = "/Users/gabammour/Desktop/my_desk /S2/Dorota/Dossier_ST/R/base_dorota.csv", row.names = FALSE)
#-------------------Exportation des bases de données---------------------------


WTI_baseadj <- read.csv2("WTI_adj.csv", sep = ",")
EPU_baseadj <- read.csv2("EPU_adj.csv", sep = ",")
CPU_baseadj <- read.csv2("CPU_adj.csv", sep = ",")


base_adj <- cbind(WTI_baseadj, EPU_baseadj, CPU_baseadj)
write.csv2(base_adj, file = "/Users/gabammour/Desktop/my_desk /S2/Dorota/Dossier_ST/R/base_adj.csv", row.names = FALSE)
