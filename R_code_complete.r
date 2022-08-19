# R code complete Telerilevamento Geo_Ecologico

#######################

# Sommario

# 1. R_code_RemoteSensing.r
# 2. R_code_spectral_indices.r
# 3. R_code_time_series_analysis.r
# 4. R_code_classification.r
# 5. R code Multivariate Analysis
# 6. R code ggplot2
# 7. R code Vegetation Indices
# 8. R code Land Cover
# 9. R code Variability

#######################

# 1. R_code_RemoteSensing.r

# questo è il primo script che useremo a lezione

# installazione pacchetto raster usando la funzione install.packages("raster")
library(raster) #richiamo la libreria precedentemente installata

# settiamo la cartella di lavoro - working directory - che utilizzeremo
# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
setwd("/Users/sofiageminiani/desktop/lab") # Mac

# importare dati dalla cartella di lavoro, denominata "lab", in R
l2011 <- brick("p224r63_2011.grd") #224 path e 63 row, incrociate troviamo il punto di interesse
l2011 # se clicco invio otterrò la seguente serie di informazioni
## class      : RasterBrick 
## dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
## source     : p224r63_2011.grd 
## names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
## min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
## max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 

# plot: visualizzo l'immagine importata in R per ogni banda
plot(l2011) #visualizzo le immagini  per ogni banda con legenda di default
# creo una palette di colori personalizzata per la legenda in sostituzione a quella di default precedente
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) 
plot(l2011, col = cl) # visualizzo le immagini per ogni banda con la legenda personalizzata

# Landsat ETM+

# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino (NIR)
# ogni pixel della immagine avrà una certa riflettanza in ciascuna banda presente

# esercizio: plottare l'immagine satellitare in una singola banda, in questo caso nella banda del blu 

# per prima cosa devo vedere come si chiama la prima banda, quella del blu
# in questo caso si chiama B1_sre
plot(l2011$B1_sre) # visualizzazione immagine satellitare nella banda del blu legandola all'immagine satellitare 
# oppure
plot(l2011[[1]]) # stesso plot di quello sopra, ma racchiudendo il primo elemento dell'immagine satellitare

# plotto l'immagine satellitare nella banda del blu con legenda dal nero al grigio chiaro
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) # il (100) rappresenta quante variazioni di colori passano da un colore all'altro, in questo caso sono 100 variazioni
plot(l2011$B1_sre, col = cl)
#oppure
plot(l2011[[1]], col = cl)

# plotto l'immagine satellitare nella banda del blu con legenda dal blu scuro al blu chiaro
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col = clb)
#oppure
plot(l2011[[1]], col = clb)

# esportiamo l'immagine ottenuta salvandola nella cartella di lavoro
pdf("banda1.pdf") # realizzo un file .pdf
plot(l2011[[1]], col = clb)
# per chiudere la finestra virtuale realizzata bisogna usare la funzione dev.off()
dev.off() # per chiudere la finestra di visualizzazione

# esportiamo l'immagine ottenuta tramite l'utilizzo della funzione plot( x, y, ...) salvandola nella cartella di lavoro
png("banda1.png") # realizzo un file .png
plot(l2011[[1]], col = clb)
# per chiudere la finestra virtuale realizzata bisogna usare la funzione dev.off()
dev.off() # per chiudere la finestra di visualizzazione

# plotto la banda del verde con legenda in palette di colori dal verde scuro al verde chiaro
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col = clg)
# oppure
plot(l2011[[2]], col = clg)

# per plottare più immagini insieme, ovvero realizzare un multiframe, utilizzo la funzione par(mfrow=c(riga, colonna))
par(mfrow = c(1, 2))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)
# otterrò un multiframe con a sinistra l'immagine nella banda del blu ed a destra nella banda del verde
dev.off() # per chiudere la finestra che visualizza il multiframe

# per esportare in pdf il multiframe ottenuto
pdf("multiframe.pdf")
par(mfrow = c(1, 2)) 
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)
# otterrò un multiframe di 1 riga e due colonne, quindi le due immagini una di fianco all'altra
dev.off()

# revert the multiframe: posizionare l'immagine nella banda del blu sopra a quella nella banda del verde
par(mfrow = c(2, 1)) 
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)
# otterrò un multiframe di 2 righe e una colonna 
dev.off()

# multiframe di 4 immagini satellitari per le bande B1_sre, B2_sre, B3_sre, B4_sre
par(mfrow = c(2, 1)) 
# plot nella banda del blu
plot(l2011$B1_sre, col = clb)
# plot nella banda del verde
plot(l2011$B2_sre, col = clg)
# plot nella banda del rosso
clr <- colorRampPalette(c("dark red", "red", "pink")) (100) # legenda in palette con variazioni di colore dal rosso scuro al rosa
plot(l2011$B3_sre, col = clr)
# plot nella banda NIR, vicino infrarosso
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100) # legenda in palette con variazioni di colore dal rosso, passando dall'arancione al giallo
plot(l2011$B4_sre, col = clnir)
# otterrò un multiframe con le immagini nelle bande del blu, verde, rosso e NIR

# plot dell'immagine l2011 nella banda NIR, infrarosso vicino
# scelgo una palette di colori per la legenda con variazioni di colore dal rosso, passando dall'arancione al giallo
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100) 
plot(l2011$B4_sre, col = clnir)
# oppure
plot(l2011[[4]], col = clnir)

# plot RGB layers
plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "lin") # argomento chiamato stretch, amplia i valori il più possibile per vedere meglio i colori, può essere a istogramma o lineare
# ottengo una immagine a colori naturali, parte nera in cui non sono stati registrati valori
# l'immagine rappresenta la riserva da 800 km di distanza come la vedrebbe l'occhio umano

# per visualizzare la banda NIR
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "lin") # visualizzo le bande NIR, rosso e verde ma non la banda del blu
# immagine visualizzata non a colori naturali, ma ciò che riflette molto l'infrarosso diventerà rosso

# mettiamo NIR nella componente green - verde
plotRGB(l2011, r = 3, g = 4, b = 2, stretch = "lin")
# tutto quello che riflette nell'infrarosso vicino, NIR, diventerà verde

# mettiamo NIR nella componente blu
plotRGB(l2011, r = 3, g = 2, b = 4, stretch = "lin")
# tutto che riflette nell'infrarosso vicino diventerà blu; si vedono bene le zone a suolo nudo (aree agricole più chiare)

# stesso plot del precedente, ma con stretch a istogramma
plotRGB(l2011, r = 3, g = 4, b = 2, stretch = "hist") # ottengo un plto con differenziazione altissima delle colorazioni rispetto la precedente immagine
# il nostro occhio è un sensore povero, ma lavorando con lo stretch e mettendo l'infrarosso vicino nella banda del verde riusciamo a vedere le zone interne della foresta

# esercizio: costruire un multiframe con visualizzazione in RGB (visualizzazione in colori naturali)
# (linear stretch) on top of false colors
# (histogram stretch)

par(mfrow=c(2, 1)) # 2 righe e 1 colonna
plotRGB(l2011, r=3, g=2, b=1, stretch = "lin")
plotRGB(l2011, r=3, g=4, b=2, stretch = "hist")
# ottengo un multiframe con due immagini, una sopra all'altra, quella sopra rappresenta ciò che vedrebbe l'occhi umano mentre l'altra è data dal sensore del satellite che ha una potenza risolutiva, a livello di bande e strretch, maggiore dell'occhio umanao 
 
# esercizio: caricare l'immagine del 1988, "p224r63_1988.gdr"

# importare l'immagine del 1988
l1988 <- brick("p224r63_1988.grd")
l1988
## class      : RasterBrick 
## dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
## source     : p224r63_1988.grd 
## names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
## min values : 0.000000e+00, 7.159799e-03, 1.300000e-03, 6.015250e-04, 0.000000e+00, 2.916000e+02, 0.000000e+00 
## max values :    1.0000000,    0.4799183,    0.4921374,    0.6595379,    0.6034456,  305.2000000,    0.5607360 

# realizzo un multiframe con NIR nella componente del rosso e confronto il 1988 ed il 2011
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch = "lin")
plotRGB(l2011, r=4, g=3, b=2, stretch = "lin")
# ottengo un multiframe con sopra l'immagine del 1988 e sotto quella del 2011
# i sensori usati per ottenere le due immagini sono diversi
# inoltre nell’immagine del 1988, rispetto a quella del 2011, si nota che in quel periodo l’uomo aveva appena iniziato a costruire alcune strade

#######################

# 2. R_code_spectral_indices

# install.packages("raster")
# install.packages("rgdal"), come Mac user mi veniva richiesta l'installazione di questo pacchetto
# install.packages("RStoolbox)
# install.packages(“rasterdiv”)
# richiamare le librerie che serviranno
library(raster)
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

#######################

# 3. R_code_time_series_analysis.r

# install.packages("raster")
library(raster) #richiamare la librearia necessaria

#settare la cartella di lavoro - working directory
setwd("/Users/sofiageminiani/desktop/lab/greenland") # Mac users
# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows

#importare immagini satellitari in R
lst2000 <- raster("lst_2000.tif")
lst2000 # premendo invio ottengo le informazioni sottostanti
## class      : RasterLayer 
## dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
## resolution : 1546.869, 1546.898  (x, y)
## extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
## crs        : +proj=stere +lat_0=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs 
## source     : lst_2000.tif 
## names      : lst_2000 
## values     : 0, 65535  (min, max)
plot(lst2000) #l'immagine plottata è caratterizzata nella parte centrale da temperature più fredde

# importare le restanti immagini
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# creo una palette personalizzata di colori per la legenda
cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)
#creo un multiframe delle 4 immagini usando la palette di colori personalizzata
par(mfrow=c(2,2))
plot(lst2000, col = cl)
plot(lst2005, col = cl)
plot(lst2010, col = cl)
plot(lst2015, col = cl)

# importiamo tutto il set di immagini insieme
rlist <- list.files(pattern = "lst")
rlist #premo invio e vedo in ordine tutti i file che ho dentro alla mia cartella di lavoro
lapply(rlist, raster)
import <- lapply(rlist, raster) # i singoli lst, le singole immagini, sono stata messe insieme
#faccio lo stack, ovvero creo un blocco comune di tutti i dati
tgr <- stack(import)
plot(tgr, col = cl) #ottengo il plot precedentemente ottenuto, ma in maniera più veloce

#per plottare una sola immagine usando lo stack
plot(tgr[[1]], col = cl)

# plottare lo stack in RGB, sovrapposizione delle immagini, analisi time series
plotRGB(tgr, r=1, g=2, b=3, stretch = "lin") #colori scuri indicano temperature più rigide, mentre colori chiari temperature più alte






#######################
#### Esempio 2: N02 - diossido di azoto - diminuisce durante il lockdown
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
cl <- colorRampPalette(c("red", "orange","yellow"))(100) 
plot(en01, col=cl) #gennaio 2020

en13 <- raster("EN_0013.png")
en13
## class      : RasterLayer 
## band       : 1  (of  3  bands)
## dimensions : 432, 768, 331776  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : EN_0013.png 
## names      : EN_0013 
## values     : 0, 255  (min, max)
plot(en13, col=cl)

# importiamo l'intero set di immagini insieme
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
plot(en[[13]], col=cl)
# oppure
en_1_13 <- stack(en[[1]], en[[13]])
plot(en_1_13, col=cl)

# facciamo la differenza
difen <- en[[1]] - en[[13]]
difen 
## class      : RasterLayer 
## dimensions : 432, 768, 331776  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 768, 0, 432  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : memory
## names      : layer 
## values     : -255, 255  (min, max)
cldif <- colorRampPalette(c("blue", "white", "red"))(100)
plot(difen, col=cldif)

#######################
