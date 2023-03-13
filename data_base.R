#--------------------------------------Construction de la base de donnée---------------------------------------------------------
{
  library(readxl)
  library(tidyr)
  library(dplyr)
}

# Importation individuelle de chaque base de donnée
WTI <- read.csv2("base_STU/WTI.csv", sep = ",")

EPU_USA <- read.csv2("base_STU/EPU_USA.csv", sep = ",")
EPU_China <- read.csv2("base_STU/EPU_China.csv", sep = ",")
CPU <- read_xlsx("base_STU/CPU.xlsx")

EMV_USA <- read.csv2("base_STU/EMV.csv", sep = ",")
EMV_commodity <- read.csv2("base_STU/EMV_commodity.csv", sep = ",")
EMV_energy <- read.csv2("base_STU/EMV_energy_regulation.csv", sep = ",")
EMV_elections <- read.csv2("base_STU/EMV_elections.csv", sep = ",")

CS <- read.csv2("base_STU/Consumer_sentiment.csv", sep = ",")

US_EUR <- read.csv2("base_STU/Exchange_rate.csv", sep = ",")
FED <- read.csv2("base_STU/FED_rate.csv", sep = ",")
CPI_USA <- read.csv2("base_STU/CPI_USA.csv", sep = ",")

GAS <- read.csv2("base_STU/Gas_price.csv", sep = ",")
IRON <- read.csv2("base_STU/Iron_ore.csv", sep = ",")
GOLD <- read.csv2("base_STU/GOLD.csv", sep = ",")
PPI_sand <- read.csv2("base_STU/PPI_hydraulic_sand.csv", sep = ",")

#####
colnames(GOLD) <- c("DATE", "GOLD", "f", "f", "f", "f", "f")
GOLD <- GOLD[,c(1,2)]

GOLD$Date <- as.Date(GOLD$Date, format="m%-%d-%y")

GOLD <- GOLD[order(GOLD$Date),]
colnames(CPU) <- c("DATE", "CPU")

str(GOLD$Date)

# Format de date pour série temporelle
WTI$DATE <- as.Date(WTI$DATE,format="%Y-%m-%d")

CPU$DATE <- as.Date(CPU$DATE, format="%Y-%m-%d")
EPU_China$DATE <- as.Date(EPU_China$DATE,format="%Y-%m-%d")
EPU_USA$DATE <- as.Date(EPU_USA$DATE,format="%Y-%m-%d")

CS$DATE <- as.Date(CS$DATE,format="%Y-%m-%d")

EMV_commodity$DATE <- as.Date(EMV_commodity$DATE,format="%Y-%m-%d")
EMV_elections$DATE <- as.Date(EMV_elections$DATE,format="%Y-%m-%d")
EMV_energy$DATE <- as.Date(EMV_energy$DATE,format="%Y-%m-%d")
EMV_USA$DATE <- as.Date(EMV_USA$DATE,format="%Y-%m-%d")

US_EUR$DATE <- as.Date(US_EUR$DATE,format="%Y-%m-%d")
CPI_USA$DATE  <- as.Date(CPI_USA$DATE,format="%Y-%m-%d")
FED$DATE <- as.Date(FED$DATE,format="%Y-%m-%d")

IRON$DATE <- as.Date(IRON$DATE,format="%Y-%m-%d")
GOLD$DATE <- as.Date(GOLD$DATE,format="%-%m-%d")
GAS$DATE <- as.Date(GAS$DATE,format="%Y-%m-%d")

# Merge des différentes variables en une seule base de donnée 

data_frames <- list(US_EUR, WTI, EMV_USA, EPU_China, CPU, EMV_commodity, EMV_elections,EMV_energy, CS, FED, CPI_USA, GAS, IRON,PPI_sand)
base <- data_frames[[1]]

for (i in 2:length(data_frames)) {
  base <- left_join(base, data_frames[[i]], by = "DATE")
}
str(GAS$DATE)
str
colnames(base)

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