# codice in R per analisi multivariata

# install.packages("raster")
# install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("patchwork")
# install.packages("viridis")
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

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

# ricampiono con un fact 100x100 pixel
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
g3 <- ggRGB(p224r63_2011res100, 4, 3, 2)
g1+g2+g3

######## DAY 2: PCA analysis ######## 

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
p224r63_2011res_pca # premendo si ottengono le seguenti informazioni
## $call
## rasterPCA(img = p224r63_2011res)
##
## $model
## Call:
## princomp(cor = spca, covmat = covMat[[1]])
##
## Standard deviations:
##       Comp.1       Comp.2       Comp.3       Comp.4       Comp.5       Comp.6       Comp.7 
## 1.2050671158 0.0461548804 0.0151509526 0.0045752199 0.0018413569 0.0012333745 0.0007595368 
##
## 7  variables and  41233 observations.
##
## $map
## class      : RasterBrick 
## dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
## resolution : 300, 300  (x, y)
## extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
## crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
## source     : memory
## names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
## min values : -1.96808589, -0.30213565, -0.07212294, -0.02976086, -0.02695825, -0.01712903, -0.00744772 
## max values : 6.065265723, 0.142898435, 0.114509984, 0.056825372, 0.008628344, 0.010537396, 0.005594299 
##
##
## attr(,"class")
## [1] "rasterPCA" "RStoolbox"

# questa funzione ha creato la $call, il $model e la $map

summary(p224r63_2011res_pca)
##      Length Class       Mode
## call       2 -none-      call
## model      7 princomp    list
## map   311850 RasterBrick S4 

summary(p224r63_2011res_pca$model)
## Importance of components:
##                           Comp.1      Comp.2       Comp.3       Comp.4       Comp.5
## Standard deviation     1.2050671 0.046154880 0.0151509526 4.575220e-03 1.841357e-03
## Proportion of Variance 0.9983595 0.001464535 0.0001578136 1.439092e-05 2.330990e-06
## Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01 9.999986e-01
##                              Comp.6       Comp.7
## Standard deviation     1.233375e-03 7.595368e-04
## Proportion of Variance 1.045814e-06 3.966086e-07
## Cumulative Proportion  9.999996e-01 1.000000e+00

plot(p224r63_2011res_pca$map)
g1 <- ggplot()+
geom_raster(p224r63_2011res_pca$map, mapping=aes(x=x, y=y, fill=PC1))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g2 <- ggplot()+
geom_raster(p224r63_2011res_pca$map, mapping=aes(x=x, y=y, fill=PC7))+
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

g1+g2

g3 <- ggplot()+
geom_raster(p224r63_2011res, mapping=aes(x=x, y=y, fill=B4_sre))+
scale_fill_viridis(option = "inferno")+
ggtitle("NIR")
g1+g3

g4 <- ggRGB(p224r63_2011res, 4, 3, 2)
g1+g4

plotRGB(p224r63_2011, 2, 3, 4, stretch="lin")

#manca un plot

plotRGB(p224r63_2011, 2, 3, 4, stretch="lin")

pc1map <- p224r63_2011res_pca$map[[1]]
pc2map <- p224r63_2011res_pca$map[[2]]
pc3map <- p224r63_2011res_pca$map[[3]]
plotRGB(p224r63_2011res_pca$map, 1, 2, 3, stretch="lin")
plotRGB(p224r63_2011res_pca$map, 5, 6, 7, stretch="lin")
