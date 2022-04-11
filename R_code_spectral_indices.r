# richiamare le librerie che serviranno
library(raster) 
# install.packages("rgdal"), come Mac user mi veniva richiesta l'installazione di questo pacchetto
# install.packages("RStoolbox)
# install.packages(“rasterdiv”)
# libray(rgdal) non è da richiamare perchè fa parte del pacchetto raster
library(RStoolbox)
library(rasterdiv)

#settare la cartella di lavoro - working directory
setwd("/Users/sofiageminiani/desktop/lab") # Mac users
# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows

# importare/caricare l'immagine satellitare da analizzare nominandola l1992
l1992 <- brick("defor1_.jpg")
l1992 # cliccando invio si ottengo le informazioni sottostanti 
## class      : RasterBrick 
## dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers) 
## resolution : 1, 1  (x, y) 
## extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : defor1_.jpg 
## names      : defor1_.1, defor1_.2, defor1_.3 
## min values :         0,         0,         0 
## max values :       255,       255,       255 
# dalle informazioni possiamo trarre che abbiamo a disposizione tre bande
# che la risoluzione è di tipo immagine, perchè non è georeferenziata
# le bande si chiamano defor1_.1, defor1_.2 e defor1_.3 
# i valori massimi e minimi vanno da 0 a 255


# come facciamo a capire  quali sono le bande coinvolte? facciamo un plotRGB()
# scoprire quale banda porta la vegetazione a plottarla di colore rosso.

plotRGB(l1992, r=1, g=2, b=3, stretch="lin") # questa funzione fa parte del pacchetto raster; le componeneti sono ipotetiche perchè non sappiamo che bande abbiamo dentro
# essendo il plot rosso vuol dire che l'infrarosso vicino è nella componente 1, le successive in sequenza
# layer 1 = NIR
# layer 2 = red
# layer 3 = green

# importare la seconda immagine satellitare da analizzare nominandola l2006
l2006 <- brick("defor2_.jpg")
l2006 # cliccando invio si ottengo le informazioni riportate di seguito
## class      : RasterBrick 
## dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
## resolution : 1, 1  (x, y)
## extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : defor2_.jpg 
## names      : defor2_.1, defor2_.2, defor2_.3 
## min values :         0,         0,         0 
## max values :       255,       255,       255

# scoprire quale banda porta la vegetazione a plottarla di colore rosso.
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# plottare in un multiframe le immagini del 1992 e del 2006 una sopra l'altra
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")
# si vede bene la foresta del 1992, mentre nella immagine del 2006 si vedono bene i campi
# di solito l'acqua è nera perchè assorbe tutta la luce, mentre in queste immagini è di colore chiaro (simile a quella del suolo nudo) per via della presenza del sedimento


# calcoliamo un indice spettrale: il DVI, Difference Vegetation Index
# calcoliamo il DVI, la salute della vegetazione, per l'anno 1992
dvi1992 = l1992[[1]] - l1992[[2]] #in questo caso potevamo usare il simbolo di assegnazione "<-"
# oppure
dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
dvi1992 # cliccando invio si ottengo le informazioni riportate di seguito
## class      : RasterLayer 
## dimensions : 478, 714, 341292  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : memory
## names      : layer 
## values     : -114, 248  (min, max)

#plottiamo il dvi1992 utilizzando una palette di colori personalizzata per la legenda
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)
# visualizzazione imagine: tutto quello che è rosso scuro è in salute, mentre ciò che è giallo non è in salute
# il fiume è giallo per la presenza di sedimenti disciolti

# calcoliamo il DVI, la salute della vegetazione, per l'anno 2006
dvi2006 = l2006[[1]] - l2006[[2]]
# oppure
dvi2006 = l2006$defor2_.1 - l2006$defor2_.2
dvi2006 # cliccando invio si ottengo le informazioni riportate di seguito
## class      : RasterLayer 
## dimensions : 478, 717, 342726  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : memory
## names      : layer 
## values     : -103, 249  (min, max)

# plottiamo il dvi2006 utilizzando una palette di colori personalizzata per la legenda
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi2006, col=cl)
# molto giallo e quindi moltissima deforestazione, sono poche le parti in cui la vegetazione è ancora in salute 
# se frammentiamo molto l'habitat si andrà incontro alla estinzione di alcune specie

#DVI difference in time: differenza tra i valori DVI del 1992 rispetto a quello del 2006
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dvi_dif, col=cld)
# visualizzo una immagine in cui il rosso rappresenta una differenza alta, altissima deforestazione

#############
## giorno 2
#############

# range DVI (8 bit): -255 a 255
# range NDVI (8 bit): -1 a 1
# range DVI (16 bit): -65535 a 65535
# range NDVI (16 bit): -1 a 1
# NDVI è più utile rispetto al DVI perchè  permette di fare confronti tra figure con numero diverso di bit

# calcoliamo NDVI del 1992
# dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# oppure
ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])

# plottiamo il ndvi1992 utilizzando una palette di colori personalizzata per la legenda
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(ndvi1992, col=cl)

# realizziamo un multiframe con il plotRGB sopra e l'immagine NDVI sotto per l'anno 1992
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)
# visualizzazione multiframe delle due immagini; il fiume è di colore chiaro e non nera perchè sono presenti sedimenti disciolti al suo interno

# calcoliamo NDVI del 2006
# dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
# oppure
ndvi2006 = (l2006[[1]] - l2006[[2]]) / (l2006[[1]] + l2006[[2]])

# realizziamo un multiframe con l'immagine NDVI per l'anno 1992 sopra e sotto per l'anno 2006
# cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
# visualizzazione multiframe delle due immagini


# calcolare in automatico gli spectral indicices utilizzando la funzione spectralIndices

# calcolo inidici multi spettrali per l'anno 1992
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1) # apparirà un warning riguardo la riflettanza
plot(si1992, col=cl)
# visualizzo un plot con tutti gli indici potenzialmente visualizzabili

# calcolo inidici multi spettrali per l'anno 2006
si2006 <- spectralIndices(l2006, green=3, red=2, nir=1) # apparirà un warning riguardo la riflettanza
plot(si2006, col=cl)
# visualizzo un plot con tutti gli indici potenzialmente visualizzabili

### utilizziamo il pacchetto rasterdiv richiamato con la libreria
plot(copNDVI)
# visualizzazione mappa del globo
# le zone verdi sono caratterizzate da alta biomassa: foreste tropicali e foreste di conifere delle alte latitudini
