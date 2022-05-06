# codice in R per calcolare variabilità spaziale basata su mappe multivariate

# install.packages("raster")
# install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("patchwork")
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)

setwd("/Users/sofiageminiani/Desktop/lab")
siml <- brick("sentinel.png")
siml
class      : RasterBrick 
dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : sentinel.png 
names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
min values :          0,          0,          0,          0 
max values :        255,        255,        255,        255 

# NIr=1
# red=2
# green=3

ggRGB(siml, 1, 2, 3)
ggRGB(siml, 3, 2, 1) 
# parte a suolo nudo viola
# acqua assorbe tutto infrarosso e quindi è nera

# esercizio: calcolare la PCA dell'immagine
simlpca <- rasterPCA(siml)
simlpca
$call
rasterPCA(img = siml)

$model
Call:
princomp(cor = spca, covmat = covMat[[1]])

Standard deviations:
  Comp.1   Comp.2   Comp.3   Comp.4 
77.33628 53.51455  5.76560  0.00000 

 4  variables and  633612 observations.

$map
class      : RasterBrick 
dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      :       PC1,       PC2,       PC3,       PC4 
min values : -227.1124, -106.4863,  -74.6048,    0.0000 
max values : 133.48720, 155.87991,  51.56744,   0.00000 


attr(,"class")
[1] "rasterPCA" "RStoolbox"

#esercizio: quanta variabilità

summary(simlpca$model)
Importance of components:
                           Comp.1     Comp.2      Comp.3 Comp.4
Standard deviation     77.3362848 53.5145531 5.765599616      0
Proportion of Variance  0.6736804  0.3225753 0.003744348      0
Cumulative Proportion   0.6736804  0.9962557 1.000000000      1

g1 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g3 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC3)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC3")

g1+g3

# esercizio: g2

g2 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC2)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC2")

g1+g2+g3

# calcoliamo la variabilità

pc1 <- simlpca$map[[1]]
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)

ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard Deviation of PC1")

# pacchetto "vegan": metodo di ordinamento 
# libro numerical ecology
