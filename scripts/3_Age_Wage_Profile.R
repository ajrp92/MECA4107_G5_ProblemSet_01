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

if(!require(pacman)) install.packages("pacman") ; require(pacman)

p_load(tidyverse,
       skimr,
       readxl,
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

mod_3 <- lm(log_ingtot_1 ~ age + agesqr, data = df_3)


##Boot
bootmod_3 <- Boot(mod_3, R = 999)
summary(bootmod_3)
confint(bootmod_3, level = .95)

##Tabla de regresion
stargazer(mod_3, bootmod_3, type = "text",
          title = "Regresión Modelo 3",
          notes = "Columna (2) muestra intervalos de confianza por Boostrap")


##Grafico

#secuencia
age_seq <- seq(min(df_3$age), max(df_3$age), by = 0.1)

#prediccion
predicted_log_wage <- predict(mod_3, newdata = data.frame(age = age_seq, agesqr = age_seq^2))

# Convertir log
predicted_wage <- exp(predicted_log_wage)

#Edad máxima
peak_age <- age_seq[which.max(predicted_wage)]

#plot
plot(age_seq, predicted_wage, type = 'l', xlab = 'Age', ylab = 'Wage', main = 'Age-Earning Profile')

#intervalos
conf_interval <- predict(model, newdata = data.frame(age = age_seq, agesqr = age_seq^2), interval = 'confidence')
lines(age_seq, exp(conf_interval[, "lwr"]), col = "red", lty = 2)
lines(age_seq, exp(conf_interval[, "upr"]), col = "red", lty = 2)

# incluir edad máxima
abline(v = peak_age, col = "blue", lty = 2)
text(peak_age, max(predicted_wage), paste("Peak Age:", round(peak_age, 2)), pos = 3, col = "blue")