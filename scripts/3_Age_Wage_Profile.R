##########################################################
# BDML - FEB 24
# Problem Set # 1
# authors: 
#           González Galvis, Daniel Enrique
#           González Junca, Daniela Natalia
#           Mendoza Potes, Valentina
#           Rodríguez Pacheco, Alfredo José
##########################################################

## Punto 3. Age - Wage Profile
##Limpiar ambiente
rm(list=ls())
##Llamar librerias

p_load(tidyverse,
       skimr,
       readx1,
       sandwich,
       lmtest,
       boot,
       car)

##Importar/ ajustar base

df <- read_excel("Base_Filtrada.xlsx")
df <- as_tibble(df)
df_3 <- df %>% select(log_ingtot_1, age)
df_3 <- df_3 %>% mutate(agesqr = age^2)

##Modelo de regresión

mod_3 <- df_3 %>% lm(log_ingtot_1 ~ age, agesqr)
coeftest(mod_3, vcov = vcov(mod_3, type = "HCO"))

##Bootstrap
fit_b <- Boot(mod_3, R = 5000)
confint(fit_b, level = .95)

##Tabla de regresion
stargazer(mod_3, fit_b, type = "latex",
          title = "Regresión Modelo 3",
          notes = "Columna (2) muestra intervalos de confianza por Boostrap")


##Grafico