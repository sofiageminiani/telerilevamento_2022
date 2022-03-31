# questo è il primo script che useremo a lezione

#installazione usando la funzione install.packages("raster")
library(raster) #richiamo la libreria precedentemente installata
#settiamo la cartella di lavoro che utilizzeremo
setwd("/Users/sofiageminiani/desktop/lab") #utilizzo questa funzione per settare il percorso alla cartella lab, nell'argomento devo inserire il nome utente perchè utilizzo un Mac

#caricamento/importare dati dalla cartella di lavoro (lab) in R
l2011 <- brick("p224r63_2011.grd")
l2011 #se clicco invio ottenrrò una serie di informazioni

#plot, visualizzo l'immagine importata in R per ogni banda
plot(l2011) #visualizzo le immagini  per ogni banda con legenda di default
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #creo una palette di colori personalizzata per la legenda in sostituzione a quella di default precedente
plot(l2011, col = cl) #plot, visualizzo le immagini per ogni banda con la legenda personalizzata

