# questo è il primo script che useremo a lezione

# installazione pacchetto raster usando la funzione install.packages("raster")
library(raster) #richiamo la libreria precedentemente installata

# settiamo la cartella di lavoro - working directory - che utilizzeremo
# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
setwd("/Users/sofiageminiani/desktop/lab") # Mac

# importare dati dalla cartella di lavoro, denominata "lab", in R
l2011 <- brick("p224r63_2011.grd") #244 path e 63 row, incrociate troviamo il punto di interesse
l2011 #se clicco invio otterrò la seguente serie di informazioni
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
#creo una palette di colori personalizzata per la legenda in sostituzione a quella di default precedente
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
