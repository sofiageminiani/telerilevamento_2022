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

# Classificare i cati solari

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


