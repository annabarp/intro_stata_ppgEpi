## Aula 3 - Recodificando variáveis

Comandos da aula:

- recode
- egen
- xtile
- bysort
  
## Stata 
  1. abrir o log em formato .log
  2. abrir o do file
  3. abrir o banco de dados .dta
     
 ### *d,s* = "describe, short"
te dá o numero de var e obs

 ### *generate*
  
*generate [varnova] = [varvelha] > 10* (valor q vc quiser)

ex: *generate bxpeso1 = apesorn < 2500*
<br> ** vc está criando uma nova variável a partir de uma antiga

*generate bxpeso2 =.* <br> ** aqui gera uma variavel apenas, com todos os valores missing

### recode
recode bxpeso2 (. = 0) if apesorn >= 2500 
recode bxpeso2 (. = 1) if apesorn < 2500

recode apesorn min / 2499.999 = 1 2500 / max = 0, generate(bxpeso3)

- A questão aqui: apenas a terceira maneira (recode + parametros) encara os missing da variavel original como missing, os outros 2 primeiros classificam o missing como 0.

  
### egen
  
*egen renda_nova1 = rowtotal(arenda1 arenda2 arenda3 arenda4)*
- desse jeito mesmo que todas as variaveis somadas sejam missing, o egen devolve um 0

- diferente no "generate", que com um codigo com a mesma finalidade
*generate renda_nova = arenda1 + arenda2  + arenda3 + arenda4*
- assim tendo APENAS 1 variavel das somas missing, a variável gerada terá missing

### proportion/prop
- dá as proporções em uma variavel categórica

### xtile 
- divide uma variavel em quantis, tu especifica o numero de quantis pelo nq(#)
*[varnova] = [varvelha], nq(3)*

### bysort
- mostra uma variavel por outra

*bysort regioesdobrasil: sum renda*

*bysort altura_qtis: summarize aaltmae* => aqui vc ta vendo as medidas gerais de aaltmae mas divido por uma outra variavel(aqui quintis de altura)

- posso usar também o *summarize aaltmae if altura_qtis == 1* que vai fazer algo parecido, mas vai me mostrar só a categoria que eu especificar.

### encode
- transforma uma string tipo "azul" "verde em "1" "2" ou seja, numa numerica com rotulos:

*encode [nome_da_variavel_string], generate([nova_variavel_numerica])*
tabulate [variavel], nol (nol esconde os rotulos)

### tab/tabulate
- faz uma tabelinha; vc pode pedir os percentuais de frequencia assim: (e ainda um chi quadrado)

*tabulate idadecat bxpeso2, col row chi*

- vc pode também tabular uma categorica contra uma continua sumarizada:

*tabulate exposição_categorica, sum(desfechocontinuo)*

- pode também estratificar antes de tabular:

*bysort fx_etaria: tabulate sexo desfecho, chi col row*

*tab dpoc2020, m* => - pode pedir para contar os missing na frequencia relativa
*tab dpoc2020, nol => esconde os labels das variaveis


### *replace* 
- substitui obs da variável
- "replace variavelquerecebe = variavelfonte if variavelquerecebe == for x valor"
exemplo:
replace status = "aprovado" if nota >= 7
replace edad = edad1 if edad == . => substitua edad por edad1 se edad for igual a .

### *destring* - variável string vira numérica (uma simples troca de categoria, que só funciona se as obs. já forem numericas)
### *tostring* - variavel numerica vira string

### Do file

```
Aula 3

//q1 explorar
d,s
describe
describe, numbers

//q2 recodificar - criando variaveis a partir de um criterio de baixo peso
generate bxpeso = apesorn < 2500

generate bxpeso1 =.
recode bxpeso1 (. = 0) if apesorn >= 2500
recode bxpeso1 (. = 1) if apesorn < 2500

recode apesorn min / 2499.999 = 1 2500 / max = 0, generate(bxpeso2)

**ficar atenta a como os comandos contam os missings; o recode conta os missing como missing mesmo, enquanto que o generate faz o missing virar 0 (e entra numa conta de proporção por exemplo)

//q3 somar variaveis

generate renda_nova = arenda1 + arenda2  + arenda3 + arenda4
egen renda_nova1 = rowtotal(arenda1 arenda2 arenda3 arenda4)
sum renda_nova renda_nova1, d

** o comando generate tendo apenas 1 missing entre as variaveis a serem somadas, já devolve o resultado da soma como missing

// q4 transformar idade continua para faixas etarias
recode aidadmae min / 19.99 = 1 20/29.99 = 2 30 / max = 3, gen(idade_cat)
label variable idade_cat "idade materna categorica"
label define idade_mae 1 "<19" 2 "20-29" 3 "30+"
label values idade_cat idade_mae
prop idade_cat

** pra fazer de uma maneira mais rapida isso
recode aidadmae (min / 19.99 = 1 "<19 anos") (20 / 29.99 = 2 "20-29 anos") (30/46 = 3 "30+"), gen (idadecat)

// q5 construindo quintis
xtile altura_qtis = aaltmae, nq(3)

** a ideia aqui é ver as medidas basicas por categoria dentro da variavel; a diferença é que o summarize if te mostra só o do valor "1", enquanto que o bysort te mostra todos
bysort altura_qtis: summarize aaltmae
summarize aaltmae if altura_qtis == 1

tab altura_qtis

** atribuir labels
label define quintis 1 "1ª tercil" 2 "2º tercil" 3 " 3º tercil"
label values altura_qtis quintis

//q6 transformar de string para numerica, mantendo os rotulos
encode igstring , generate(ig_categorica)
tabulate ig_categorica
tabulate ig_categorica, nol ** esconde os rotulos 


// q7 tabular
tab bxpeso2
tab altura_qtis
tab idadecat

label variable bxpeso2 "baixo peso ao nascer"
label variable idadecat "idade materna por faixa etária"
label variable  altura_qtis "tercis de altura materna"

tabulate altura_qtis bxpeso2, col row chi
tabulate idadecat bxpeso2, col row chi

// q8 tabular a media de um desfecho continuo por uma exposição categorica
tabulate altura_qtis, sum(apesorn)
tabulate idadecat, sum(apesorn)

// q9 tabular com estratificador
bysort idadecat: tabulate ig_categorica bxpeso2, chi col row

``` 


