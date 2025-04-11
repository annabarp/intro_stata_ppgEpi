## Explorando o banco <br>
*banco de dados disponível no e-aulas* <br>

Comandos da aula
- browse/edit
- describe
- list
- codebook
- lookfor
- display
  
### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
  3. exploração do banco:
     
 - *describe*
<br> um geralzão do banco e das variaveis

- *codebook [var]*
 <br> te dá um descritivo basico da variavel estudada 

- *lookfor [mae]*
<br> após o lookfor vc digita o termo que quiser, é a função _search_ entre rótulos e labels

- *list [var1 var2]*
<br> tem toda uma sintaxe cheia de possibilidades, mas se vc digitar sem citar variavel ele lista cada var para cada obs

- *display*
<br> funciona como uma calculadora ou para imprimir uma informação

- *count if*
<br> vc delimita contar tal variavel SE tiver certo valor a observação, por exemplo:
<br> "count if apesorn > 2000" (conta o numero de observações que o peso é maior que x)

- *log* 
  <br> log close; log on/off; log query; log using "nome_do_arquivo", append" <br>
  fecha o log; pausa; diz se aberto ou não, se aberto mostra o caminho; reiniciar um log fechado.

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
banco_aula1 <- read_dta("C:/Users/lauri/Documents/stata/aula1banco.dta")
```
#### Vamos iniciar a exploração do banco, com infos básicas
- *glimpse()* ou *str()* [stata: describe/codebook]<br>
  ambos com função semelhante, dão um resumo do banco ou da variável <br>
  lembrando que vc pode especificar a variável que vc quer usando o $ "banco_aula1$apesorn"
```r
View(banco_aula1)
glimpse(banco_aula1)
str(banco_aula1)
summary(banco_aula1)
```
- *dfSummary()* [stata: codebook] <br>
  gera uma tabela com os valores unicos, missing e possíveis

```r
dfSummary(banco_aula1$apesorn)
## ou, para visualizar melhor, gerando uma tabela em html
view(dfSummary(banco_aula1$apesorn)
```
- *lookfor()* [stata: =]
  emula a mesma função do stata <br>
```r
lookfor(banco_aula1, "mae")
```  
- *banco_aula1[R,C]* [stata: list]
  lista coluna ou variavel
  ```r
  banco_aula1[1] ou banco_aula1[,1] ###vai listar toda a coluna 1
  banco_aula1[1,] ### lista a variavel 1, até um limite de x variaveis
  ## se vc quiser ver uma coluna especifica de uma variavel
  banco_aula1[1,4] ## linha 1 coluna 4
  ```
- *freq()* [stata: tab]
  mostra as frequencias abs e rel
    ```r
    view(freq(banco_aula1$sexonovo))
    
    ### vc pode usar também fazer assim
    table(banco_aula1$sexonovo)
    ##ou
    prop.table(table(banco_aula1$sexonovo))*100
    ```
    %>% = encadeia comandos = "faz isso e depois faz isso" <br>
- *sum* [stata= count] <br>
  conta a partir de uma especificação
```r
sum(banco_aula1$sexonovo == 1, na.rm = TRUE)
sum(banco_aula1$aescmae >= 8, na.rm = TRUE)
sum(banco_aula1$apesorn <= 2500, na.rm = TRUE)
sum(banco_aula1$afumou == 1, na.rm = TRUE)
   ```
   - na.rm = TRUE quer dizer para desconsiderar os missings
#### vc nao mexeu no banco, entao precisa salvar só o script .R

### FIM

  








  
