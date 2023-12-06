## Taller de R ##
## Problem Set 3 ## 
## Juan Camilo Parada Sandoval - 201823856 ##
## 06 - 12 - 2023 ##
## R version 4.3.1 ##



## initial setup
rm(list=ls())
require(pacman)
p_load(tidyverse,rio,data.table)

## Punto 1.1
rutas <- list.files("input" , recursive=T , full.names=T)

## Punto 1.2 

## Extraer las rutas
rutas_resto <- str_subset(string = rutas , pattern = "Resto - Ca")

## Cargar en lista
lista_resto <- import_list(file = rutas_resto)

## Textear la cadena de caracteres 
rutas_resto[1]
str_sub(rutas_resto[35],start = 14 , 17)

## Agregar ruta
View(lista_resto[[1]])
lista_resto[[1]]$path <- rutas_resto[1]
  
## Aplicar loop  
for (i in 1:length(lista_resto)){
     lista_resto[[i]]$path <- rutas_resto[i]  
     lista_resto[[i]]$year <- str_sub(lista_resto[[i]]$path,start = 14 , 17)
}
View(lista_resto[[20]])

## Punto 1.3
lista_resto[[36]] <- NULL
cg <- rbindlist(l=lista_resto , use.names=T , fill=T)

## exportar la base final
export(cg,"output/db_full.rds")

#Punto 2

# creamos un grafico de dispersion con los datos totales

ggplot(data = cg,aes(x=ESC, y= P6040)) + geom_point() + 
  labs(title = "Relacion entre edad y años de escolaridad", 
       x = "Anos de escolaridad",
       y = "Edad") +
  theme_minimal()


# filtramos los mismos datos de antes pero para los que se consideran pobres
df <- cg %>%
  filter(P3246 == 1) %>%
  select(P6040, ESC)

# generamos un grafico con los datos de personas que se consideran pobres.
ggplot(data = df,aes(x=ESC, y= P6040)) + geom_point() + 
  labs(title = "Relacion entre edad y tiempo de escolaridad", 
       x = "Tiempo de escolaridad",
       subtitle = "Datos para personas que se consideran pobres segun la GEIH",
       y = "Edad") +
  theme_minimal()

# filtramos ahora los datos de los que no se consideran pobres
df2 <- cg %>%
  filter(P3246 == 2) %>%
  select(P6040, ESC)

# generamos el grafico con las personas que no se consideran pobres
ggplot(data = df2,aes(x=ESC, y= P6040)) + geom_point() + 
  labs(title = "Relacion entre edad y tiempo de escolaridad",
       subtitle = "Datos para personas que no se consideran pobres segun la GEIH",
       x = "Tiempo de escolaridad",
       y = "Edad") +
  theme_minimal()
