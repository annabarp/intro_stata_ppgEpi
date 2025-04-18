## Recodificando variáveis

Comandos da aula:

- recode
- egen
- xtile
- bysort
  
### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
     
 - *d,s*
<br> te dá o numero de var e obs

- *generate*
  
*generate [varnova] = [varvelha] > 10* (valor q vc quiser)

ex: *generate bxpeso1 = apesorn < 2500*
<br> ** vc está criando uma nova variável a partir de uma antiga

*generate bxpeso2 =.* <br> ** aqui gera uma variavel apenas, com todos os valores missing

recode bxpeso2 (. = 0) if apesorn >= 2500 
recode bxpeso2 (. = 1) if apesorn < 2500

recode apesorn min / 2500 = 1 2500 / max = 0, generate(bxpeso3)

  
- *egen*
- *recode*
- *replace*
- *encode*
- *destring*
- *tostring*
- 





#### vc nao mexeu no banco, então não precisa salvar; o importante é garantir que vc salvou o log.

### RStudio <br>
1. vamos importar o banco .dta (formato stata) para o R
2. será preciso instalar um pacote especifico "haven" (vc precisa instalar e chamar o pacote pro jogo, senão ele não vem)
3. vamos criar um trecho de código com os pacotes básicos necessários que vc **precisa** executar sempre que abrir o R (vai de copia e cola)

##### A maneira mais simples de instalar e chamar os pacotes
```r 
pacotes_aula1 <- c("tidyverse", "summarytools", "labelled", "haven")
install.packages(pacotes_aula1)
lapply(pacotes_aula1, library, character.only = TRUE)
```

#### Outra forma mais complexa, se vc puder só copiar e colar de um arquivo pronto
```r
required_packages <- c("tidyverse", "summarytools", "labelled", "haven") 
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)
lapply(required_packages, library, character.only = TRUE)
```
- lapply é uma função que aplica outra função numa lista ou vetor
- string é um texto entre aspas = "tidyverse"

#### Importando o banco .dta e fazendo virar DF
```r
banco_aula1 <- read_dta("C:/Users/lauri/Documents/stata/XXXXX")
```
#### Vamos iniciar a ...XXXX
- *XXX()* ou *XXX()* [stata: XXXX]<br>
  isso faz abcdfg...
  
```r
XX Código XXX
```

#### vc nao mexeu no banco, entao precisa salvar só o script .R

### FIM

  








  
