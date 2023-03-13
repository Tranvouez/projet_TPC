#--------------------------------------Construction de la base de donnée---------------------------------------------------------
{
  library(readxl)
  library(tidyr)
  library(dplyr)
}

# Importation des bases : 

WTI <- read.csv2("Parties/Base/WTI.csv", sep = ",")
WTI$DATE <- as.Date(WTI$DATE,format="%Y-%m-%d")
colnames(WTI)[2]<-"WTISPOT"
str(WTI)

EPU_USA <- read.csv2("Parties/Base/EPU_USA.csv", sep = ",")
EPU_USA$DATE <- as.Date(EPU_USA$DATE,format="%Y-%m-%d")
colnames(EPU_USA)[2]<-"EPU_USA"
str(EPU_USA)


EPU_China <- read.csv2("Parties/Base/EPU_China.csv", sep = ",")
EPU_China$DATE <- as.Date(EPU_China$DATE,format="%Y-%m-%d")
colnames(EPU_China)[2] <- "EPU_China"
str(EPU_China)


EMV_USA <- read.csv2("Parties/Base/EMV.csv", sep = ",")
EMV_USA$DATE <- as.Date(EMV_USA$DATE,format="%Y-%m-%d")
colnames(EMV_USA)[2] <- "EMV_USA"
str(EMV_USA)


EMV_commodity <- read.csv2("Parties/Base/EMV_commodity.csv", sep = ",")
EMV_commodity$DATE <- as.Date(EMV_commodity$DATE,format="%Y-%m-%d")
colnames(EMV_commodity)[2] <- "EMV_commodity"
str(EMV_commodity)


EMV_energy <- read.csv2("Parties/Base/EMV_energy_regulation.csv", sep = ",")
EMV_energy$DATE <- as.Date(EMV_energy$DATE,format="%Y-%m-%d")
colnames(EMV_energy)[2] <- "EMV_energy"
str(EMV_energy)

EMV_elections <- read.csv2("Parties/Base/EMV_elections.csv", sep = ",")
EMV_elections$DATE <- as.Date(EMV_elections$DATE,format="%Y-%m-%d")
colnames(EMV_elections)[2] <- "EMV_elections"
str(EMV_elections)

CS <- read.csv2("Parties/Base/Consumer_sentiment.csv", sep = ",")
CS$DATE <- as.Date(CS$DATE,format="%Y-%m-%d")
colnames(CS)[2] <- "Consumer_sentiment"
str(CS)

US_EUR <- read.csv2("Parties/Base/Exchange_rate.csv", sep = ",")
US_EUR$DATE <- as.Date(US_EUR$DATE,format="%Y-%m-%d")
colnames(US_EUR)[2] <- "US_EUR"
str(US_EUR)


FED <- read.csv2("Parties/Base/FED_rate.csv", sep = ",")
FED$DATE <- as.Date(FED$DATE,format="%Y-%m-%d")
colnames(FED)[2] <- "FED"
str(FED)


CPI_USA <- read.csv2("Parties/Base/CPI_USA.csv", sep = ",")
CPI_USA$DATE <- as.Date(CPI_USA$DATE,format="%Y-%m-%d")
colnames(CPI_USA)[2] <- "CPI_USA"
str(CPI_USA)

GAS <- read.csv2("Parties/Base/Gas_price.csv", sep = ",")
GAS$DATE <- as.Date(GAS$DATE,format="%Y-%m-%d")
colnames(GAS)[2] <- "GAS"
str(GAS)

IRON <- read.csv2("Parties/Base/Iron_ore.csv", sep = ",")
IRON$DATE <- as.Date(IRON$DATE,format="%Y-%m-%d")
colnames(IRON)[2] <- "IRON"
str(IRON)


PPI_sand <- read.csv2("Parties/Base/PPI_hydraulic_sand.csv", sep = ",")
PPI_sand$DATE <- as.Date(PPI_sand$DATE,format="%Y-%m-%d")
colnames(PPI_sand)[2] <- "PPI_sand"
str(PPI_sand)

CPU <- read_xlsx("Parties/Base/CPU.xlsx")
CPU$Date <- as.Date(CPU$Date,format="%Y-%m-%d")
colnames(CPU) <- c("DATE","CPU")
str(CPU)


# Merge des différentes variables en une seule base de donnée 

data_frames <- list( US_EUR, WTI, CPI_USA, CPU , CS, EMV_commodity, EMV_elections, EMV_energy, EMV_USA, EPU_China, EPU_USA, FED, GAS, IRON, PPI_sand)
base <- data_frames[[1]]

for (i in 2:length(data_frames)) {
  base <- left_join(base, data_frames[[i]], by = "DATE")
}
str(base)

base[,2:ncol(base)] <- lapply(base[,2:ncol(base)], as.numeric)
str(base)

##### Valeurs manquantes #############
base <- slice(base, -c(285:290))
str(base)
apply(base_brut, 2, function(x) any(is.na(x)))
###### Exportation ##############
write.csv2(base,"Parties/Base/base_complete.csv", row.names = FALSE)

##### Fin ###### 

base <- read.csv2("Parties/Base/base_complete.csv")
View(base)
