# codice in R per analisi multivariata

# install.packages("raster")
# install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("patchwork")
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)

# settaggio della cartella di lavoro
# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
setwd("/Users/sofiageminiani/Desktop/lab") # per utilizzatori di dispositivi Mac

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011 # premendo si ottengono le seguenti informazioni
## class      : RasterBrick 
## dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
## resolution : 30, 30  (x, y)
## extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
## source     : p224r63_2011_masked.grd 
## names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
## min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
## max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 
plot(p224r63_2011)

# prima di svolgere la PCA, analisi invasiva/robusta, dobbiamo effettuare il ricampionamento: resampling
# diminuisco la risoluzione originale per ricampionare
# farò la media dei pixel aggregandoli tra loro

p224r63_2011res <- aggregate(p224r63_2011, fact=10) # fact mi dice che linearmente compatto 10x10 pixel
p224r63_2011res # premendo si ottengono le seguenti informazioni
## class      : RasterBrick 
## dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
## resolution : 300, 300  (x, y)
## extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
## source     : memory
## names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
## min values :   0.00670000,   0.01580000,   0.01356544,   0.01648527,   0.01500000, 295.54400513,   0.00270000 
## max values :   0.04936299,   0.08943339,   0.10513023,   0.43805822,   0.31297142, 303.57499786,   0.18649654 

g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g1+g2

p224r63_2011res100 <- aggregate(p224r63_2011, fact=30)
g3 <- ggRGB(p224r63_2011res100, 4, 3, 2)
g1+g2+g3
