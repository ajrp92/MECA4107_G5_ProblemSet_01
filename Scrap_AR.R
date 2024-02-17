## Parte 1 ## Web scrap ##
##Work directory##

setwd("C:\\Users\\AlfredoRP\\OneDrive - INALDE Business School - Universidad de La Sabana\\Attachments\\Economia\\ML\\Problem_set_1_Equipo_5\\scripts")

##use rvest##
library("tidyverse")
library("rvest")

##Web page""
web <- "https://ignaciomsarmiento.github.io/GEIH2018_sample/"

htlm <- read_html("web") 

##links##

links <- htlm %>% 
  html_nodes("a") %>%
  html_attr("href")

## falta leer datos y construir base de datos ##
## Terminar script allí ##