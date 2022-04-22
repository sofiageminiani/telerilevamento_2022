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
freq(l2006c$map)
# la classe 1 ha 164384 pixel
# la classe 2 ha 178342 pixel


