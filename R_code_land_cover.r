# Codice per generare mappe di land cover da immagini satellitari

# per informazioni: https://patchwork.data-imaginist.com/
# per informazioni: https://ggplot2-book.org/
install.packages("ggplot2")
install.packages("patchwork")
library(raster)
library(RStoolbox) #contiene le funzioni per la classificazione
setwd("/Users/sofiageminiani/Desktop/lab/")
library(ggplot2)
library(patchwork)

# banda 1 = NIR
# banda 2 = rosso
# banda 3 = verde
l1992 <- brick("defor1_.jpg")
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# esercizio: importare defor2 e plottare entrambe le immagini una sopra l'altra
l2006 <- brick("defor2_.jpg")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# 
ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
plot1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot2 <- ggRGB(l2006, r=1, g=2, b=3, stretch="lin")
plot1+plot2 # visualizzo le immagini una di fianco l'altra
plot1/plot2 # visualizzo le immagini una sopra l'altra

# classificazione immagine Landsat del 1992
l1992c <- unsuperClass(l1992, nClasses=2)
plot(l1992c$map) 
# nella classificazione il nome delle classi viene scelto dal software alla fine del processo
# classe 1: aree agricole (+ acqua)
# classe 2: foresta

# classificazione immagine Landsat del 2006
l2006c <- unsuperClass(l2006, nClasses=2)
plot(l2006c$map)
# classe 1: aree agricole (+ acqua)
# classe 2: foresta

# calcolo delle frequenze
freq(l1992c$map)
# la classe 1 ha 35021 pixel
# la classe 2 ha 306271 pixel
tot92 <- 341292 #numero di pixel totale dell'immagine satellitare
# proporzione di classe foresta
pro_forest_92 <- 306271/tot92 #l'89.7387% corrisponde alla percentuale di foresta
# percentuale della classe foresta
perc_forest_92 <- (306271*100)/tot92
# proporzione di classe area agricola
pro_forest_92 <- 35021/tot92 #l'10.2613% corrisponde alla percentuale di area agricola
# percentuale della classe foresta
perc_forest_92 <- (35021*100)/tot92

freq(l2006c$map)
# la classe 1 ha 164384 pixel
# la classe 2 ha 178342 pixel
# proporzione di classe
tot06 <- 342726 # numero di pixel dell'immagine satellitare del 2006
pro_forest_06 <- 178342/tot06
# percentuale della classe foresta
perc_forest_06 <- (178342*100)/tot06 # 52.03632% di foresta
# proporzione classe zona agricola
perc_agr_06 <- 100 - perc_forest_06 # 47.96368% di aree agricole

# costruire un dataframe
# colonne (o fields)
class <- c("Forest", "Agricolture") # è un vettore
percent_1992 <- c(89.7387, 10.2613)
percent_2006 <- c(52.03632, 47.96368)
multitemporal <- data.frame(class, percent_1992, percent_2006)
##        class percent_1992 percent_2006
## 1      Forest      89.7387     52.03632
## 2 Agricolture      10.2613     47.96368
View(multitemporal)
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class))+
geom_bar(stat="identity", fill="white")
# dati del 2006
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class))+
geom_bar(stat="identity", fill="white")

pdf("percentages_1992")
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class))+
geom_bar(stat="identity", fill="white")
dev.off()

pdf("percentages_2006")
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class))+
geom_bar(stat="identity", fill="white")
dev.off()
