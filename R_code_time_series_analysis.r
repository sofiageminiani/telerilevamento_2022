# Time series analysis of Greenland LST data

library(raster) #richiamo la librearia che mi serve
setwd("/Users/sofiageminiani/Desktop/lab_greenland") # setto/preparo la cartella di lavoro, uso la funzione con questo argomento perchè uso un Mac

lst2000 <- raster("lst_2000.tif")
lst2000 # premo invio e otterrò una serie di informazioni
plot(lst2000) #l'immagine plottata è caratterizzata nella parte centrale da temperature più fredde

# importo anche le restanti immagini

lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# creo una palette personalizzata di colori per la legenda
cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)
#creo un multiframe di 4 immagini usando la palette di colori per la legenda creata
par(mfrow=c(2,2))
plot(lst2000, col = cl)
plot(lst2005, col = cl)
plot(lst2010, col = cl)
plot(lst2015, col = cl)

# importiamo tutto il set di immagini insieme
rlist <- list.files(pattern = "lst")
rlist #premo invio e vedo in ordine tutti i file che ho dentro alla mia cartella di lavoro
lapply(rlist, raster)
import <- lapply(rlist, raster) # abbiamo messo insieme i singoli lst, le singole immagini
#faccio lo stack ovvero creo un blocco comune di tutti i dati
tgr <- stack(import)
plot(tgr, col = cl) #ottengo il plot precedentemente ottenuto, ma in maniera più veloce

#per plottare una sola immagine usando lo stack
plot(tgr[[1]], col = cl)

# plottare lo stack in RGB, sovrapposizione delle immagini, analisi time series
plotRGB(tgr, r=1, g=2, b=3, stretch = "lin") #colori scuri indicano temperature più rigide, mentre colori chiari temperature più alte




#######################
#### Esempio 2: N02 diminuisce durante il lockdown
#######################

# la libreria raster ci serve ed è stata richiamata sopra 
# library(raster)
# setwd("Users/sofiageminiani/desktop/lab_european") #setto/preparo la cartella di lavoro
en01 <- raster("EN_0001.png")
en01 # cliccando invio ottengo le seguenti informazioni:
## class      : RasterLayer 
## band       : 1  (of  3  bands)
## dimensions : 432, 768, 331776  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : EN_0001.png 
## names      : EN_0001 
## values     : 0, 255  (min, max)
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(en01, col=cl) #gennaio 2020

en13 <- raster("EN_0013.png")
en13
class      : RasterLayer 
band       : 1  (of  3  bands)
dimensions : 432, 768, 331776  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : EN_0013.png 
names      : EN_0013 
values     : 0, 255  (min, max)
plot(en13, col=cl)

#Importiamo l'intero set di immagini insieme
# seguendo gli step: list.files, lapply, stack

rlist <- list.files(pattern="EN") # definisco un pattern comune per tutti
# non definisco il path in list.files() perchè abbiamo già settato la working directory/cartella di lavoro
lapply(rlist, raster)
rimp <- lapply(rlist, raster) # abbiamo messo insieme i singoli "EN", le singole immagini
#faccio lo stack ovvero creo un blocco comune di tutti i dati
en <- stack(rimp)
#plottiamo tutte le immagini
plot(en, col=cl) #otteniamo un plot in cui visualizziamo tutte le 13 immagini satellitari

# esercizio: plottiamo EN01 di fianco a EN13
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl

# oppure

en_1_13 <- stack(en[[1]], en[[13]])
plot(en_1_13, col=cl)

# facciamo la differenza
difen <- en[[1]] - en[[13]]
difen 
class      : RasterLayer 
dimensions : 432, 768, 331776  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      : layer 
values     : -255, 255  (min, max)
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)


