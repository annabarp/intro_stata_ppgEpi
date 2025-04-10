## Instalando os pacotes necessários pra Aula1
required_packages <- c("tidyverse", "summarytools", "labelled", "haven")

new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

lapply(required_packages, library, character.only = TRUE)

## como alternativa com sintaxe mais simples:

## pacotes_aula1 <- c("tidyverse", "summarytools", "labelled", "haven")
## install.packages(pacotes_aula1)
## lapply(pacotes_aula1, library, character.only = TRUE)

## importando o banco .dta e fazendo virar DF

banco_aula1 <- read_dta("C:/Users/lauri/Documents/stata/aula1banco.dta")

#### Vamos iniciar a exploração do banco, com infos básicas
View(banco_aula1)
glimpse(banco_aula1)
str(banco_aula1)
summary(banco_aula1)

##para visualizar melhor, gerando uma tabela em html
view(dfSummary(banco_aula1$apesorn)

## dando um search
lookfor(banco_aula1, "mae")

##listando colunas ou variaveis
banco_aula1[1] ou banco_aula1[,1] ###vai listar toda a coluna 1
banco_aula1[1,] ### lista a variavel 1, até um limite de x variaveis
## se vc quiser ver uma coluna especifica de uma variavel
banco_aula1[1,4] ## linha 1 coluna 4

#avaliando as frequencias da variavel
view(freq(banco_aula1$sexonovo))
table(banco_aula1$sexonovo)
prop.table(table(banco_aula1$sexonovo)) *100
prop.table(table(banco_aula1$aescmae)) *100
prop.table(table(banco_aula1$apesorn)) *100
prop.table(table(banco_aula1$afumou)) *100

#contando
sum(banco_aula1$sexonovo == 1, na.rm = TRUE)
sum(banco_aula1$aescmae >= 8, na.rm = TRUE)
sum(banco_aula1$apesorn <= 2500, na.rm = TRUE)
sum(banco_aula1$afumou == 1, na.rm = TRUE)

