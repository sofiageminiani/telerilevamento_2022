# esame di telerilevamento geo-ecologico 2022, Prof. Duccio Rocchini

# area di studio: Madagascar in particular Kirindy-Ambadira Forest Complex (KAFC), path 160 and raw 74

# install.packages("rgdal")
# install.packages("raster")
# install.packages("RStoolbox")
# install.packages("rasterdiv")
# install.packages("ggplot2")
# install.packages("patchwork")

# richiamo le librerie necessarie previa installazione dei relativi pacchetti
library(rgdal) 
library(raster)
library(RStoolbox)
library(rasterdiv)
library(ggplot2)
library(patchwork)

# settaggio della working directory (Mac user)
setwd("/Users/sofiageminiani/desktop/lab/Esame_telerilevamento") 

# importazione delle immagini da analizzare

# 2013
rlist<-list.files(pattern="LC08_L1TP_160074_20130515_20200912_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2013<-stack(import) #unisce in un singolo file quelli che erano in lista
mad2013 # cliccando invio ottengo le seguenti informazioni
## class      : RasterStack 
## dimensions : 7331, 7571, 55503001, 8  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 419085, 646215, -2347215, -2127285  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
## names      : LC08_L1TP//2_02_T1_B1, LC08_L1TP//2_02_T1_B2, LC08_L1TP//2_02_T1_B3, LC08_L1TP//2_02_T1_B4, LC08_L1TP//2_02_T1_B5, LC08_L1TP//2_02_T1_B6, LC08_L1TP//2_02_T1_B7, LC08_L1TP//2_02_T1_B9 
## min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
## max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

plot1<-ggRGB(mad2013, 4,3,2, stretch="hist")+labs(title="2013") #plot in RGB
plot2<-ggRGB(mad2013, 5,4,3, stretch="hist")+labs(title="2013 IR") #falsi colori IR

# 2016
rlist<-list.files(pattern="LC08_L1TP_160074_20160523_20200906_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2016<-stack(import) #unisce in un singolo file quelli che erano in lista
mad2016 # cliccando invio ottengo le seguenti informazioni
## class      : RasterStack 
## dimensions : 7771, 7671, 59611341, 8  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 418485, 648615, -2353815, -2120685  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
## names      : LC08_L1TP//6_02_T1_B1, LC08_L1TP//6_02_T1_B2, LC08_L1TP//6_02_T1_B3, LC08_L1TP//6_02_T1_B4, LC08_L1TP//6_02_T1_B5, LC08_L1TP//6_02_T1_B6, LC08_L1TP//6_02_T1_B7, LC08_L1TP//6_02_T1_B9 
## min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
## max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

plot3<-ggRGB(mad2016, 4,3,2, stretch="hist")+labs(title="2016") # plot in RGB
plot4<-ggRGB(mad2016, 5,4,3, stretch="hist")+labs(title="2016 IR") # falsi colori IR

# 2019
rlist<-list.files(pattern="LC08_L1TP_160074_20190430_20200829_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2019<-stack(import) #unisce in un singolo file quelli che erano in lista
mad2019 # cliccando invio ottengo le seguenti informazioni
## class      : RasterStack 
## dimensions : 7771, 7661, 59533631, 8  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 419385, 649215, -2353815, -2120685  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
## names      : LC08_L1TP//9_02_T1_B1, LC08_L1TP//9_02_T1_B2, LC08_L1TP//9_02_T1_B3, LC08_L1TP//9_02_T1_B4, LC08_L1TP//9_02_T1_B5, LC08_L1TP//9_02_T1_B6, LC08_L1TP//9_02_T1_B7, LC08_L1TP//9_02_T1_B9 
## min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
## max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

plot5<-ggRGB(mad2019, 4,3,2, stretch="hist")+labs(title="2019") # plot in RGB
plot6<-ggRGB(mad2019, 5,4,3, stretch="hist")+labs(title="2019 IR") # falsi colori IR

# 2021
rlist<-list.files(pattern="LC08_L1TP_160074_20210521_20210529_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2021<-stack(import) #unisce in un solo file le bande presenti nella lista
mad2021 # cliccando invio ottengo le seguenti informazioni
## class      : RasterStack 
## dimensions : 7771, 7661, 59533631, 8  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 416985, 646815, -2353815, -2120685  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
## names      : LC08_L1TP//9_02_T1_B1, LC08_L1TP//9_02_T1_B2, LC08_L1TP//9_02_T1_B3, LC08_L1TP//9_02_T1_B4, LC08_L1TP//9_02_T1_B5, LC08_L1TP//9_02_T1_B6, LC08_L1TP//9_02_T1_B7, LC08_L1TP//9_02_T1_B9 
## min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
## max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

plot7<-ggRGB(mad2021, 4,3,2, stretch="hist")+labs(title="2021") # plot in RGB
plot8<-ggRGB(mad2021, 5,4,3, stretch="hist")+labs(title="2021 IR") # falsi colori IR

#plotto le 4 immagini per presentarle
plot1+plot3+plot5+plot7

#plotto le 4 immagini per presentarle in IR
plot2+plot4+plot6+plot8


### SPECTRAL INDICES ###

# calcolo indice spettrale DVI
dvi2013 = mad2013[[5]]-mad2013[[4]]
dvi2016 = mad2016[[5]]-mad2016[[4]]
dvi2019 = mad2019[[5]]-mad2019[[4]]
dvi2021 = mad2021[[5]]-mad2021[[4]]

# calcolo indice spettrale NDVI
ndvi2013 = dvi2013 / (mad2013[[5]]+mad2013[[4]])
ndvi2016 = dvi2016 / (mad2016[[5]]+mad2016[[4]])
ndvi2019 = dvi2019 / (mad2019[[5]]+mad2019[[4]])
ndvi2021 = dvi2021 / (mad2021[[5]]+mad2021[[4]])
# differenza dell'indice spettrale NDVI tra gli anni 2013 e 2021
cl <- colorRampPalette(c("blue", "white", "red")) (200)
ndvi2013res<-resample(ndvi2013,ndvi2021,method="bilinear") # ricampionare per differente estensione dei due raster
ndvi_diff <- ndvi2013res-ndvi2021
par(mfrow=c(3,1)) # realizzo un multiframe
plot(ndvi2013, col=cl, main="NDVI 2013")
plot(ndvi2021, col=cl, main="NDVI 2021")
plot(ndvi_diff, col=cl, main="NDVI difference between 2013 and 2021")

# calcolo indice spettrale GEMI
# GEMI 2013
n = (2 * ( mad2013[[5]] ^2 - mad2013[[4]] ^2) + 1.5 * mad2013[[5]] + 0.5 * mad2013[[4]] ) / ( mad2013[[5]] + mad2013[[4]] + 0.5 )
gemi_2013 = (n*(1-0.25*n)-((mad2013[[4]]-0.125)/(1-mad2013[[4]])))
# NIR = mad2013[[5]]
# red = mad2013[[4]]

# GEMI 2021
n = (2 * ( mad2021[[5]] ^2 - mad2021[[4]] ^2) + 1.5 * mad2021[[5]] + 0.5 * mad2021[[4]] ) / ( mad2021[[5]] + mad2021[[4]] + 0.5 )
gemi_2021 = (n*(1-0.25*n)-((mad2021[[4]]-0.125)/(1-mad2021[[4]])))
# NIR = mad2021[[5]]
# red = mad2021[[4]]
# GEMI difference between 2013 and 2021
gemi2013res<-resample(gemi_2013,gemi_2021,method="bilinear") # ricampionare per differente estensione dei due raster
gemi_diff <- gemi2013res-gemi_2021
par(mfrow=c(3,1)) # realizzo un multiframe
plot(gemi_2013, col=cl, main="GEMI 2013")
plot(gemi_2021, col=cl, main="GEMI 2021")
plot(gemi_diff, col=cl, main="GEMI difference between 2013 and 2021")

# GVMI 2013 and 2021
gvmi_2013 <- ((mad2013[[5]]+0.1)-(mad2013[[7]]+0.02))/((mad2013[[5]]+0.1)+(mad2013[[7]]+0.02))
gvmi_2021 <- ((mad2021[[5]]+0.1)-(mad2021[[7]]+0.02))/((mad2021[[5]]+0.1)+(mad2021[[7]]+0.02))
par(mfrow=c(2,1))
plot(gvmi_2013)
plot(gvmi_2021)
# GVMI difference between 2013 and 2021
gvmi2013res<-resample(gvmi_2013,gvmi_2021,method="bilinear") # ricampionare per differente estensione dei due raster
gvmi_diff <- gvmi2013res-gvmi_2021
par(mfrow=c(3,1)) # realizzo un multiframe
plot(gvmi_2013, col=cl, main="GVMI 2013")
plot(gvmi_2021, col=cl, main="GVMI 2021")
plot(gvmi_diff, col=cl, main="GVMI difference between 2013 and 2021")

# NDMI 2013 and 2021
ndmi_2013 <- (mad2013[[5]]- mad2013[[6]])/(mad2013[[5]]+mad2013[[6]])
ndmi_2021 <- (mad2021[[5]]- mad2021[[6]])/(mad2021[[5]]+mad2021[[6]])
par(mfrow=c(2,1))
plot(ndmi_2013)
plot(ndmi_2021)
# NDMI difference between 2013 and 2021
ndmi2013res<-resample(ndmi_2013,ndmi_2021,method="bilinear") # ricampionare per differente estensione dei due raster
ndmi_diff <- ndmi2013res-ndmi_2021
par(mfrow=c(3,1)) # realizzo un multiframe
plot(ndmi_2013, col=cl, main="NDMI 2013")
plot(ndmi_2021, col=cl, main="NDMI 2021")
plot(ndmi_diff, col=cl, main="NDMI difference between 2013 and 2021")

# correlo gli indici analizzati usando la tecnica della pca
box<-stack(ndvi_diff, gemi_diff, gvmi_diff, ndmi_diff) # associo ad un oggetto lo stack degli indici
plot(box, col=cl)
pairs(box) # da mettere alla fine con tutti gli indici
varpca<-rasterPCA(box) # faccio la pca
summary(varpca$model)
##Importance of components:
##                         Comp.1       Comp.2       Comp.3
##Standard deviation     13889064 5.353152e-02 2.405277e-02
##Proportion of Variance        1 1.485502e-17 2.999054e-18
##Cumulative Proportion         1 1.000000e+00 1.000000e+00
##                             Comp.4
##Standard deviation     2.398946e-02
##Proportion of Variance 2.983287e-18
##Cumulative Proportion  1.000000e+00
# La prima banda spiega il 100%
# associo ad una variabile la mappa normalizzata al suo max valore
varpcaN<-varpca$map$PC1/maxValue(varpca$map$PC1)
plot(varpcaN,col=cl)


### MAPPA DI LAND COVER ###
# Realizzazione di una mappa di Land cover:
# A causa di una problematica legata alla classificazione dei pixel tra le immagini satellitari del 2013 e 2021
# ho creato una seconda working directory(LAND_COVER) con dentro le bande del BLU(B2) e del NIR(B5) per ciascuno dei due anni indagati
# La decisione delle bande è stata fatta per tentativi

# settaggio di una seconda working directory
setwd("/Users/sofiageminiani/desktop/lab/Esame_telerilevamento/LAND_COVER") 

# unsuperClass dell'immagine 2013
# 2013
rlist<-list.files(pattern="LC08_L1TP_160074_20130515_20200912_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2013lc<-stack(import) #unisce in un singolo file quelli che erano in lista
mad2013lc # cliccando invio ottengo le seguenti informazioni
##class      : RasterStack 
##dimensions : 7331, 7571, 55503001, 2  (nrow, ncol, ncell, nlayers)
##resolution : 30, 30  (x, y)
##extent     : 419085, 646215, -2347215, -2127285  (xmin, xmax, ymin, ymax)
##crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
##names      : LC08_L1TP_160074_20130515_20200912_02_T1_B2, LC08_L1TP_160074_20130515_20200912_02_T1_B5 
##min values :                                           0,                                           0 
##max values :                                       65535,                                       65535 

set.seed(17) #rendo le classi discrete
mad2013c <- unsuperClass(mad2013lc, nClasses=3) # applico la funzione unsuperclass con 3 classi
mad2013c # premendo invio ottengo le seguenti informazioni
##unsuperClass results

##*************** Model ******************
##$model
##K-means clustering with 3 clusters of sizes 2131, 5692, 2177

##Cluster centroids:
##  LC08_L1TP_160074_20130515_20200912_02_T1_B2
##1                                    8197.514
##2                                    8355.064
##3                                    9110.116
##  LC08_L1TP_160074_20130515_20200912_02_T1_B5
##1                                    10525.80
##2                                    13078.83
##3                                    15475.32

##Within cluster sum of squares by cluster:
##[1] 3960132478 3637265000 5570786720

##*************** Map ******************
##$map
##class      : RasterLayer 
##dimensions : 7331, 7571, 55503001  (nrow, ncol, ncell)
##resolution : 30, 30  (x, y)
##extent     : 419085, 646215, -2347215, -2127285  (xmin, xmax, ymin, ymax)
##crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
##source     : r_tmp_2022-09-08_003442_2506_43357.grd 
##names      : class 
##values     : 1, 3  (min, max)

# plotto la mappa classificata 
plot(mad2013c$map)

# realizzazione della mappa di land cover
freq(mad2013c$map)# ottengo le seguenti informazioni
##     value    count
##[1,]     1  8456870
##[2,]     2 21912311
##[3,]     3  8408679
##[4,]    NA 16725141
# la classe 1 ha 8456870 pixel di 55503001 (fiumi+suolo)
# la classe 2 ha 21912311 pixel di 55503001 (foresta)
# la classe 3 ha 8408679 pixel di 55503001 (nuvole)
# tolgo la classe NA=16725141 dal calcolo, quindi:
tot2013 <- 38777860 # numero di pixel totali dell'immagine satellitare, tolti i pixel di NA
# calcolo la percentuale di foresta nel 2013:
perc_forest2013 <- (21912311*100)/tot2013
# 56.50727% di foresta
perc_water2013 <- (8456870*100)/tot2013
# 21.8085% di acqua(laghi, fiumi privi di elevata sedimentazione, mare)
perc_soil2013 <- (8408679*100)/tot2013
# 21.68423% di suolo+nuvole


#unsuperClass dell'immagine 2021
# 2021
rlist<-list.files(pattern="LC08_L1TP_160074_20210521_20210529_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2021lc<-stack(import) #unisce in un solo file le bande presenti nella lista
mad2021lc # cliccando invio ottengo le seguenti informazioni
##class      : RasterStack 
##dimensions : 7771, 7661, 59533631, 2  (nrow, ncol, ncell, nlayers)
##resolution : 30, 30  (x, y)
##extent     : 416985, 646815, -2353815, -2120685  (xmin, xmax, ymin, ymax)
##crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
##names      : LC08_L1TP_160074_20210521_20210529_02_T1_B2, LC08_L1TP_160074_20210521_20210529_02_T1_B5 
##min values :                                           0,                                           0 
##max values :                                       65535,                                       65535 

set.seed(17) #rendo le classi discrete
mad2021c <- unsuperClass(mad2021lc, nClasses=3) # applico la funzione unsuperclass con 3 classi
mad2021c# cliccando invio ottengo le seguenti informazioni
##unsuperClass results

##*************** Model ******************
##$model
##K-means clustering with 3 clusters of sizes 2809, 5792, 1399

##Cluster centroids:
##  LC08_L1TP_160074_20210521_20210529_02_T1_B2
##1                                    8815.032
##2                                    8353.814
##3                                    8198.325
##  LC08_L1TP_160074_20210521_20210529_02_T1_B5
##1                                    15047.68
##2                                    12904.35
##3                                    10305.93

##Within cluster sum of squares by cluster:
##[1] 4453885777 3059523949 2901942398

##*************** Map ******************
##$map
##class      : RasterLayer 
##dimensions : 7771, 7661, 59533631  (nrow, ncol, ncell)
##resolution : 30, 30  (x, y)
##extent     : 416985, 646815, -2353815, -2120685  (xmin, xmax, ymin, ymax)
##crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
##source     : r_tmp_2022-09-08_003850_2506_43357.grd 
##names      : class 
##values     : 1, 3  (min, max)
plot(mad2021c$map)

# realizzazione della mappa di land cover
freq(mad2021c$map) # ottengo le seguenti informazioni
##     value    count
##[1,]     1 11716094
##[2,]     2 23950305
##[3,]     3  5963854
##[4,]    NA 17903378
# la classe 1 ha 5963854 pixel di 59533631 (acqua)
# la classe 2 ha 23950305 pixel di 59533631 (foresta)
# tolgo la classe NA=17903378 dal calcolo quindi:
tot2021 <-(11716094+23950305+5963854)
# calcolo la percentuale di foresta nel 2021:
perc_forest2021 <- (23950305*100)/tot2021
# 57.53101% di foresta
perc_water2021 <- (5963854*100)/tot2021
# 14.32577% di acqua(laghi, fiumi privi di elevata sedimentazione, mare)
perc_soil2021 <- (11716094*100)/tot2021
# 28.14322% di suolo+nuvole

### DATI FINALI ###
# perc_forest2013 <- 56.50727%
# perc_water2013 <- 21.8085%
# perc_soil2013 <- 21.68423% 
# perc_forest2021 <- 57.53101% 
# perc_water2021 <- 14.32577% 
# perc_soil2021 <- 28.14322%  
### ###

# costruisco un dataframe
class <- c("Forest", "Water", "Soil")
perc_2013 <- c(56.50727, 21.8085, 21.68423)
perc_2021 <- c(57.53101, 14.32577, 28.14322)
multitemporal <- data.frame(class, perc_2013, perc_2021)
multitemporal # cliccando invio ottengo la seguente tabella
##   class perc_2013 perc_2021
##1 Forest  56.50727  57.53101
##2  Water  21.80850  14.32577
##3   Soil  21.68423  28.14322
p9<-ggplot(multitemporal,aes(x=class,y=perc_2013, color=class))+
  geom_bar(stat="identity", color="black")+
  labs(x="Class",y="Percentage",title="Percentages for classification map of 2013")+
  theme(legend.position="bottom")

p10<-ggplot(multitemporal,aes(x=class,y=perc_2021, color=class))+
   geom_bar(stat="identity", color="black")+
   labs(x="Class",y="Percentage",title="Percentages for classification map of 2021")+
   theme(legend.position="bottom")
# plotto insieme i due istogrammi
p9+p10
