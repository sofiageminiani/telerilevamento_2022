# questo è il primo script che useremo a lezione

#installazione usando la funzione install.packages("raster")
library(raster) #richiamo la libreria precedentemente installata

#settiamo la cartella di lavoro che utilizzeremo
setwd("/Users/sofiageminiani/desktop/lab") #utilizzo questa funzione per settare il percorso alla cartella lab, nell'argomento devo inserire il nome utente perchè utilizzo un Mac

#caricamento/importare dati dalla cartella di lavoro (lab) in R
l2011 <- brick("p224r63_2011.grd") #244 path e 63 row, incrociate troviamo il punto di interesse
l2011 #se clicco invio otterrò una serie di informazioni

#plot, visualizzo l'immagine importata in R per ogni banda
plot(l2011) #visualizzo le immagini  per ogni banda con legenda di default
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #creo una palette di colori personalizzata per la legenda in sostituzione a quella di default precedente
plot(l2011, col = cl) #plot, visualizzo le immagini per ogni banda con la legenda personalizzata

# Landsat ETM+

# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino (NIR)
# ogni pixel della immagine avrà una certa riflettanza in ciascuna banda presente

# plottare l'immagine satellitare in una singola banda, in questo caso nella banda del blu; per prima cosa devo vedere come si chiama la prima banda, in questo caso si chiama B1_sre
plot(l2011$B1_sre) # plot immagine satellitare nella banda del blu legando l'immagine satellitare con la banda del blu di cui abbiamo ricavato precedentemente il nome
# oppure
plot(l2011[[1]]) # stesso plot di quello sopra, ma racchiudendo il primo elemento dell'immagine satellitare

# plotto la banda del blu con la variazione di colore dal nero al grigio chiaro
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #il (100) rappresenta quante variazioni di colori passano da un colore all'altro, in questo caso sono 100 variazioni
plot(l2011$B1_sre, col = cl)
#oppure
plot(l2011[[1]], col = cl)

# plotto la banda del blu con legenda in palette con variazioni di colore dal blu scuro al blu chiaro
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col = clb)
#oppure
plot(l2011[[1]], col = clb)

# esportiamo l'immagine ottenuta tramite l'utilizzo della funzione plot( x, y, ...) salvandola nella cartella di lavoro
pdf("banda1.pdf") # realizzo un file .pdf
plot(l2011[[1]], col = clb)
# per chiudere la finestra virtuale realizzata bisogna usare la funzione dev.off()
dev.off()

# esportiamo l'immagine ottenuta tramite l'utilizzo della funzione plot( x, y, ...) salvandola nella cartella di lavoro
png("banda1.png") # realizzo un file .png
plot(l2011[[1]], col = clb)
# per chiudere la finestra virtuale realizzata bisogna usare la funzione dev.off()
dev.off()

# plotto la banda del verde con legenda in palette con variazioni di colore dal verde scuro al verde chiaro
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col = clg)
#oppure
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
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100) # scelgo una palette di colori per la legenda con variazioni di colore dal rosso, passando dall'arancione al giallo
plot(l2011$B4_sre, col = clnir)
#oppure
plot(l2011[[4]], col = clnir)

#plot RGB layers
plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "lin")# argomento chiamato stretch, amplia i valori il più possibile per vedere meglio i colori, può essere a istogramma o lineare
# ottengo una immagine a colori naturali, parte nera in cui non sono stati registrati valori
# l'immagine rappresenta la riserva da 800 km di distanza come la vedrebbe l'occhio umano

# per visualizzare la banda NIR
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "lin") #visualizzo le bande NIR, rosso e verde ma non la banda del blu
# immagine visualizzata non a colori naturali, ma ciò che riflette molto l'infrarosso diventerà rosso

# mettiamo NIR nella componente green - verde
plotRGB(l2011, r = 3, g = 4, b = 2, stretch = "lin")
#tutto quello che riflette nell'infrarosso vicino - NIR - diventerà verde
