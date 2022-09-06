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

plot1<-ggRGB(mad2013, 4,3,2, stretch="lin")+labs(title="2013") #plot in RGB
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

plot3<-ggRGB(mad2016, 4,3,2, stretch="lin")+labs(title="2016") # plot in RGB
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

plot5<-ggRGB(mad2019, 4,3,2, stretch="lin")+labs(title="2019") # plot in RGB
plot6<-ggRGB(mad2019, 5,4,3, stretch="hist")+labs(title="2019 IR") # falsi colori IR

# 2021
rlist<-list.files(pattern="LC08_L1TP_160074_20210521_20210529_02_T1_B") #creo una lista cercando elementi comuni
import<-lapply(rlist,raster) #con lapply applico la funzione citata a tutta la lista
mad2021<-stack(import) #unisce in un singolo file quelli che erano in lista
mad2021 # cliccando invio ottengo le seguenti informazioni
## class      : RasterStack 
## dimensions : 7771, 7661, 59533631, 8  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 416985, 646815, -2353815, -2120685  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=38 +datum=WGS84 +units=m +no_defs 
## names      : LC08_L1TP//9_02_T1_B1, LC08_L1TP//9_02_T1_B2, LC08_L1TP//9_02_T1_B3, LC08_L1TP//9_02_T1_B4, LC08_L1TP//9_02_T1_B5, LC08_L1TP//9_02_T1_B6, LC08_L1TP//9_02_T1_B7, LC08_L1TP//9_02_T1_B9 
## min values :                     0,                     0,                     0,                     0,                     0,                     0,                     0,                     0 
## max values :                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535,                 65535 

plot7<-ggRGB(mad2021, 4,3,2, stretch="lin")+labs(title="2021") # plot in RGB
plot8<-ggRGB(mad2021, 5,4,3, stretch="hist")+labs(title="2021 IR") # falsi colori IR

#plotto le 4 immagini per presentarle
plot1+plot3+plot5+plot7

#plotto le 4 immagini per presentarle in IR
plot2+plot4+plot6+plot8

# calcolo DVI
dvi2013 = mad2013[[5]]-mad2013[[4]]
dvi2016 = mad2016[[5]]-mad2016[[4]]
dvi2019 = mad2019[[5]]-mad2019[[4]]
dvi2021 = mad2021[[5]]-mad2021[[4]]

# calcolo NDVI
ndvi2013 = dvi2013 / (mad2013[[5]]+mad2013[[4]])
ndvi2016 = dvi2016 / (mad2016[[5]]+mad2016[[4]])
ndvi2019 = dvi2019 / (mad2019[[5]]+mad2019[[4]])
ndvi2021 = dvi2021 / (mad2021[[5]]+mad2021[[4]])

# differenza NDVI tra gli anni 2013 e 2021
cl <- colorRampPalette(c("blue", "white", "red")) (200)
ndvi2013res<-resample(ndvi2013,ndvi2021,method="bilinear") # ricampionare per differente estensione dei due raster
ndvi_diff <- ndvi2013res-ndvi2021
par(mfrow=c(3,1)) # realizzo un multiframe
plot(ndvi2013, col=cl, main="NDVI 2013")
plot(ndvi2021, col=cl, main="NDVI 2021")
plot(ndvi_diff, col=cl, main="NDVI difference between 2013 and 2021")


# realizzazione di una mappa di Land cover
# unsuperClass dell'immagine 2013
set.seed(42) #rendo le classi discrete
m2013c <- unsuperClass(mad2013, nClasses=4) #applico la funzione unsuperclass con 4 classi
plot(m2013c$map, col=cl) #plot della mappa delle classi
freq(m2013c$map) # vedo la conta dei pixel

df1<-data.frame(freq(clasimm2013$map)) #creo un piccolo dataframe con i pixel categorizzati

sum2013<-sum(df1$count) #sommo tutta la colonna dei count
df1$perc_2013<-(df1$count/sum2013)*100 #aggiungo un vettore interno al dataframe con le percentuali del 2013
rownames(df1)<-c("classe_1","classe_2","classe_3","classe_4") #rinomino le righe
colnames(df1)<-c("classe","count","perc_2013") #rinomino le colonne
df1$classe<-c("Classe 1","Classe 2","Classe 3", "Classe 4") #aggiungo un vettore "classe" al dataframe
p9<-ggplot(df1,aes(x=classe,y=perc_2013, fill=classe))+
  geom_bar(stat="identity", color="black")+
  labs(x="Classi",y="Percentuale",title="Percentuale per Classe 2013")+
  theme(legend.position="bottom")
#geom_bar mi indica il tipo di grafico, labs sono i labels degli assi e theme mi dà delle opzioni su come posizionare la legenda



# 
