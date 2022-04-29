# santinel lanciato da esa ha una risoluzione di 10 metri
# variazioni geostrutturali e le variazioni ecologiche, landcover, fino ai boschi

# R code variability

# install.packages("viridis")
library(raster)
library(RStoolbox) # per visualizzare le immagini e svolgere calcoli di variabilità
library(ggplot2) # per ggplot plotting
library(patchwork)
setwd("/Users/sofiageminiani/Desktop/lab")
sen <- brick("sentinel.png")
sen
## class      : RasterBrick 
## dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
## resolution : 1, 1  (x, y)
## extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : sentinel.png 
## names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
## min values :          0,          0,          0,          0 
## max values :        255,        255,        255,        255 

ggRGB(sen, 1, 2, 3, stretch="lin")
# esercizio: plottare i due grafici insieme
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)
g1+g2

# NIR, NDVI, analisi multivariata e scegliamo quello con più informazioni al suo interno
#calcolo della variabilità NIR
nir <- sen[[1]]
plot(nir)
sd1 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow"))(100)
plot(sd1, col=clsd)

# plottare con ggplot
ggplot()+
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))

# con viridis
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
ggplot()+
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis()+
ggtitle("Standard deviationof by viridis")

# con cividis
ggplot()+
geom_raster(sd, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option="cividis")+
ggtitle("Standard deviationof by viridis")

# esercizio: fare lo stesso calcolo con una finestra 7x7
sd7 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow"))(100)
plot(sd7, col=clsd)
