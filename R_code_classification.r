library(raster)
library(RStoolbox)
setwd("/Users/sofiageminiani/desktop/lab") #setto/preparo la cartella di lavoro

# importazione immagine satellitare
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so # cliccando invio otterrò una serie di informazioni
## class      : RasterBrick 
## dimensions : 1157, 1920, 2221440, 3  (nrow, ncol, ncell, nlayers)
## resolution : 1, 1  (x, y)
## extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg 
## names      : Solar_Orbiter_s_first_views_of_the_Sun_pillars.1, Solar_Orbiter_s_first_views_of_the_Sun_pillars.2, Solar_Orbiter_s_first_views_of_the_Sun_pillars.3 
## min values :                                                0,                                                0,                                                0 
## max values :                                              255,                                              255,                                              255

plotRGB(so, r=1, g=2, b=3, stretch="lin")
plotRGB(so, r=1, g=2, b=3, stretch="hist")

# Classificare i dati solari

soc <- unsuperClass(so, nClasses=3)
soc # cliccando invio otterrò una serie di informazioni
## unsuperClass results

## *************** Model ******************
## $model
## K-means clustering with 3 clusters of sizes 4079, 3851, 2070
##
## Cluster centroids:
##  Solar_Orbiter_s_first_views_of_the_Sun_pillars.1 Solar_Orbiter_s_first_views_of_the_Sun_pillars.2
## 1                                        129.95072                                         97.58691
## 2                                         55.07349                                         39.36120
## 3                                        221.15749                                        174.75121
##  Solar_Orbiter_s_first_views_of_the_Sun_pillars.3
## 1                                         30.19049
## 2                                          9.06388
## 3                                         68.66473
##
## Within cluster sum of squares by cluster:
## [1] 3729825 3952455 4326981
##
## *************** Map ******************
## $map
## class      : RasterLayer 
## dimensions : 1157, 1920, 2221440  (nrow, ncol, ncell)
## resolution : 1, 1  (x, y)
## extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
## crs        : NA 
## source     : memory
## names      : class 
## values     : 1, 3  (min, max)

cl <- colorRampPalette(c("yellow","black","red"))(100)
plot(soc$map, col=cl)




### giorno 2: Grand Canyon

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

##class      : RasterBrick 
##dimensions : 6222, 9334, 58076148, 3  (nrow, ncol, ncell, nlayers)
##resolution : 1, 1  (x, y)
##extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
##crs        : NA 
##source     : dolansprings_oli_2013088_canyon_lrg.jpg 
##names      : dolansprings_oli_2013088_canyon_lrg.1, dolansprings_oli_2013088_canyon_lrg.2, dolansprings_oli_2013088_canyon_lrg.3 
##min values :                                     0,                                     0,                                     0 
## max values : 255,                                   255,                                   255 

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# cambiare lo stretch da lineare allo stretch a istogrammi
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# creare delle classi per le immagini
gc_classes2 <- unsuperClass(gc, nClasses=2)
gc_classes2
## unsuperClass results
##
## *************** Model ******************
## $model
## K-means clustering with 2 clusters of sizes 6886, 3114
##
## Cluster centroids:
##  dolansprings_oli_2013088_canyon_lrg.1 dolansprings_oli_2013088_canyon_lrg.2
## 1                              178.4034                             161.05388
## 2                              107.9281                              93.07739
##  dolansprings_oli_2013088_canyon_lrg.3
## 1                             137.44714
## 2                              71.64772
##
## Within cluster sum of squares by cluster:
## [1] 9530019 7358779
##
## *************** Map ******************
##$map
##class      : RasterLayer 
##dimensions : 6222, 9334, 58076148  (nrow, ncol, ncell)
##resolution : 1, 1  (x, y)
##extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
##crs        : NA 
##source     : r_tmp_2022-04-21_172910_1521_11632.grd 
##names      : class 
##values     : 1, 2  (min, max)
plot(gc_classes2$map) # classe bianca roccia, mentre la parte verde è tutto il resto (ombre e acqua)
# set.seed(17) per mantenere sempre la stessa classificazione

# esercizio: classificare la mappa con 4 classi
gc_classes4 <- unsuperClass(gc, nClasses=4)
clgc <- colorRampPalette(c("yellow", "red", "blue", "black"))(100)
plot(gc_classes4$map, col=clgc)

# compare the classified map with the original set
par(mfrow=c(2,1))
plot(gcclass4$map, col=clgc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
