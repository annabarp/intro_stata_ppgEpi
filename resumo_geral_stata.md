## Abre o log / Abre e salva o do / salva o doc no teu nome

### Explorando o banco - Aula 1

Comandos da aula:

- browse/edit
- describe
- list
- codebook
- lookfor
- display
  
#### Stata 
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
<br> *count if apesorn > 2000* (conta o numero de observações que o peso é maior que x)

- *log*
  
  *log close* =  fecha o log
  
  *log on/off* = pausa
  
  *log query*= diz se aberto ou não, se aberto mostra o caminho
  
  *log using "nome_do_arquivo" append* =  reiniciar um log fechado
  

## Modificações iniciais no banco - Aula 2

Comandos da aula:

- rename
- label
- generate
- tabulate
- summarize
  
#### Stata 
  1. abrir o log em formato .log
  2. no caso desse exercicio, digite o banco manualmente
  3. o stata tem apelidos pra suas variaveis, um fofo
  4. se algo estiver entre [] é pra substituir o conjunto todo por algo
  5. se estiver entre () mantem os parenteses e substitui o conteúdo dentro

- **edit/browse**
   edit(ou ed apenas) vc abre a planilha pra editar <br>
    -- ao criar variaveis direto no edit, o programa nomeia elas automaticamente como [var1..] <br>
    
  browse(ou br apenas) vc abre a planilha só para observar 0.o <br>
    
- **rename** 

  vc pode renomear varias juntas, sempre só com espaço, sem virgulas
  
  ex: *rename (varvelha1 varvelha2) (varnova1 varnova2)* talvez ao infinito
  
- **label** <br>
  label variable "o que vc quiser" => coloca uma etiqueta na variavel
    
  label define [nome da etiqueta] [valor real da obs] ["nome atribuido"]
  
  exemplo: *label define sim_ou_nao 1 "sim" 0 "nao"*
    
  label values [variavel a atribuir uma etiqueta] [nome da etiqueta] 
  
  exemplo: *label values fuma sim_ou_nao*
     
- **generate**

cria uma nova variavel, pode ser a partir de outra
  - para transformar uma variavel que é string em numerica;
  exemplo: sexo está codificada "feminino" "masculino"

      *generate sexo_num = (sexo == "feminino")*
  -> nesse caso se sexo for IGUAL a feminino o programa devolve com 1 pois entende "TRUE"
- para criar uma nova variavel a partir da operação de uma original
  
 *generate estatura_metros = estatura/100*
  ou
 *generate imc = peso/(estatura_metros)^2*
  
- **encode**

- transformar uma serie de categorias dentro de uma variavel em numeros, atribuindo a ela labels 

*encode [ocupacao], generate(ocupacao_num) label(ocupacoes)* 

- o encode faz as categorias virarem numeros, o generate cria uma nova variavel a partir disso e o label vai pegar os antigos nomes e atribuir nessa nova variavel como labels(na ordem certa)

*foram 2 jeitos diferentes para string -> numerico*

- **tab**
  
   tabela com frequencias de uma variavel CATEGORICA

- **summarize (ou sum)**
  
  estatistica descritiva basica de uma variavel numerica
  
 *sum imc, detail*

#### Obs:
Tipos de variaveis:
    
**numericas**
- discreta (byte, int, long)
- contínua (float, double)

**texto**
- string (str1 str2 - depende da qtd de caracteres)<br>

Do file

```
edit
rename(var1 var2 var3 var4 var5 var6 var7 var8 var9) (ficha nome sexo ocupacao idade peso estatura fuma depre)
label var ficha "numero do questionario"
label var nome "nome atribuído"
label var sexo "sexo biológico"
label var ocupacao "profissao"
label var idade "em anos"
label var estatura "em cm"
label var peso "em kg"
label var fuma "uso de tabaco"
label var depre "diagnostico de depressao"
label define sn 1 "sim" 0 "nao"
label values fuma sn
label values depre sn
generate sexo_num = (sexo == "feminino")
drop sexo
rename sexo_num sexo
encode ocupacao, generate(ocupacao_num) label(ocupacoes)
drop ocupacao
rename ocupacao_num ocupacao
generate estatura_metros = estatura/100
generate imc = peso/(estatura_metros)^2
log close

```

## Aula 3 - Recodificando variáveis

Comandos da aula:

- recode
- 
- xtile
- bysort
  
#### Stata 
  1. abrir o log em formato .log
  2. abrir o do file
  3. abrir o banco de dados .dta
     
 - ***d,s* = "describe, short"**
te dá o numero de var e obs

 - **generate**
  
*generate [varnova] = [varvelha] > 10* (valor q vc quiser)

ex: *generate bxpeso1 = apesorn < 2500*
<br> ** vc está criando uma nova variável a partir de uma antiga

*generate bxpeso2 =.* <br> ** aqui gera uma variavel apenas, com todos os valores missing

- **recode**
recode bxpeso2 (. = 0) if apesorn >= 2500 
recode bxpeso2 (. = 1) if apesorn < 2500

recode apesorn min / 2499.999 = 1 2500 / max = 0, generate(bxpeso3)

- A questão aqui: apenas a terceira maneira (recode + parametros) encara os missing da variavel original como missing, os outros 2 primeiros classificam o missing como 0.

  
- **egen**<br>
*egen renda_nova1 = rowtotal(arenda1 arenda2 arenda3 arenda4)*
  desse jeito mesmo que todas as variaveis somadas sejam missing, o egen devolve um 0

  diferente no "generate", que com um codigo com a mesma finalidade
*generate renda_nova = arenda1 + arenda2  + arenda3 + arenda4*
  assim tendo APENAS 1 variavel das somas missing, a variável gerada terá missing

- **proportion/prop**
  <br>
 dá as proporções em uma variavel categórica

- **xtile**
  <br>
 divide uma variavel em quantis, tu especifica o numero de quantis pelo nq(#)
*[varnova] = [varvelha], nq(3)*

- **bysort**
 mostra uma variavel por outra

*bysort regioesdobrasil: sum renda*

*bysort altura_qtis: summarize aaltmae* => aqui vc ta vendo as medidas gerais de aaltmae mas divido por uma outra variavel(aqui quintis de altura)

- posso usar também o *summarize aaltmae if altura_qtis == 1* que vai fazer algo parecido, mas vai me mostrar só a categoria que eu especificar.

- **encode**
 transforma uma string tipo "azul" "verde em "1" "2" ou seja, numa numerica com rotulos:

*encode [nome_da_variavel_string], generate([nova_variavel_numerica])*
tabulate [variavel], nol (nol esconde os rotulos)

- **tab/tabulate**
 faz uma tabelinha; vc pode pedir os percentuais de frequencia assim: (e ainda um chi quadrado)

*tabulate idadecat bxpeso2, col row chi*

- vc pode também tabular uma categorica contra uma continua sumarizada:

*tabulate exposição_categorica, sum(desfechocontinuo)*

- pode também estratificar antes de tabular:

*bysort fx_etaria: tabulate sexo desfecho, chi col row*

*tab dpoc2020, m* => - pode pedir para contar os missing na frequencia relativa
*tab dpoc2020, nol => esconde os labels das variaveis


- **replace**
 substitui obs da variável
 "replace variavelquerecebe = variavelfonte if variavelquerecebe == for x valor"
exemplo:
replace status = "aprovado" if nota >= 7
replace edad = edad1 if edad == . => substitua edad por edad1 se edad for igual a .

- **destring** - variável string vira numérica (uma simples troca de categoria, que só funciona se as obs. já forem numericas)
- **tostring** - variavel numerica vira string

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


## Aula 4 - Merge e append

Comandos da aula:

- merge
- append
  
#### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
  3. abrir o Do file
     
- **append**
 juntar linhas (observações) ao banco de dados que está sendo utilizado (estudos transversais)
 *db append*
 pode acontecer de colunas nao se juntarem, então tu vai precisar usar o replace


- **merge**
juntar colunas ao banco (estudos de coorte)
banco "master" é o aberto
banco "using" é o externo que tu quer trazer

pode acontecer de os bancos nao terem o mesmo numero de observações, dai vai dar caô, tu vai precisar examinar cada banco manualmente através dos seguintes comandos:

- **duplicates**

vc precisa descobrir quem é figurinha repetida! 

*duplicates list* => vai te listar as obs duplicadas
aqui voce vai saber qm é duplicata

OU

*duplicates tag, gen (duplicatas)* => cria uma nova variavel em que as duplicatas estao com essa "flag= oi sou duplicata"

*tab duplicadas*
aqui lista quantas tem de duplicata e nao duplicata

logo após vc pode *drop duplicatas*


**2 modos principais:**
- One-to-one => indica que as variáveis são pareadas uma a uma (exemplo: banco dos 15 e 18 anos da coorte 1993)
- One-to-many => indica que há várias observações no “using” que devem ser pareadas com uma informação da mãe (banco da coorte 1993 aos 22 anos, com o banco de filhos dos membros da coorte) (aqui cria um banco tipo long)

possíveis:
- 1:1
- 1: m
- m: 1
- m: m

### do-file
```

// Aula 4 - merge e append

//q1 frequencias
d,s
codebook pais

tab epoc70
tab epoclln

/q2 - criar faixa etária
sum fev11
sum edad

recode edad (40/59.99 = 0 " 40-59 anos ") (60/max = 1 " +60 "), gen (edad_cat) // fazendo faixas etarias
tab edad_cat
label variable edad_cat " faixa etária "

// juntando um segundo banco
db append

// aconteceu que as variaveis ao inves de se juntarem ficaram separadas por nomes diferentes tipo idade1 e idade 2, queremos juntas então:

replace edad = edad1 if edad ==.
replace fev11 = fev111 if fev11 ==.
replace epoc70 = epoc701 if epoc70 ==.
replace epoclln = epoclln1 if epoclln ==.

** isso quer dizer "substitua edad por edad1 se edad for igual a missing"

// q2f juntei um banco, vou querer saber as novas tabelas
d,s

tab epoc70 
tab epoclln
sum fev11
sum edad

recode edad (40/59.99 = 0 " 40-59 anos ") (60/max = 1 " +60 "), gen (edad_cat_nova) // fazendo faixas etarias novas pq antes era só com o mexico e agora eu fiz o append

tab edad_cat_nova
label variable edad_cat " faixa etária com a venezuela "

// q3 - juntando variaveis - merge
db merge 
** da erro, algum dos bancos tem duplicata
** tive q abrir um e depois o outro e usar o comando

duplicates list //vai te listar o numero da linha da variavel que tá duplicada
duplicates tag , generate(duplicatas)
tabulate duplicatas

** vamos excluir as duplicatas tagueadas entao
drop if duplicatas == 1

**vamos tentar merge de novo, agora usando o merge 2 como master
db merge

**sucesso

//q4 PNS2013
db merge

//tentei parear o banco de domicilios com o banco de pessoas, então 1 domicilio para varias pessoas usei o comando 1:m (um para muitos) mas deu erro, algum dos dois bancos tem duplicatas

//abri o banco domicilios
duplicates tag, gen(tag)

tab tag

drop if tag>0 // excluindo duplicatas

// o merge agora deu certo, mas nao poderia ter sobrado pessoas sem match com o domicilio, pq todo mundo que foi entrevistado foi associado a um domicilio
// isso ocorreu pq excluimos duplicatas no caso AS DUAS, original e copia, com o comando drop if tag>0... vamos tentar de novo

//abre o banco domicilios

duplicates drop

db merge // com o banco de pessoas 1:m

// agora sim, tem domicilios nao pareados, mas isso faz sentido pq tem casas que foram sorteadas mas que ngm foi entrevistado...

tab V0026 // proporções de individuos zona rural 

bysort V0026: tab C006 // proporções de individuos zona rural e sexo

// bysort diz assim => separa por x e me tabula y

//q5
//como saber quais as variaveis unicas que podem ser usadas para combinar bancos? vc usa 

isid anc15_r

```
## Aula 5 - wide/long

Comandos da aula:

- mdy
- date()
- collapse
- long
- reshape
  
#### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
  3. abrir o banco

- **mdy()**
=juntar e criar uma data
vai contar os dias desde uma data especifica (1/1/1960) a partir das datas dadas
se tuas datas estão separadas por variaveis de dia, mes e ano, tu consegue juntar usando esse comando.

então exemplo:

*generate data_inicial = mdy(mes1, dia1, ano1)*	
**o ano tem que ter 4 digitos

- **format data_inicial %d**
transforma a variavel criada pelo mdy() de numeros totais de 1960 para uma data legivel

- **collapse**
vc tem um banco long e quer juntar medidas repetidas sumarizando uma variavel;

exemplo:
*collapse (mean) estimate, by(year indic)* => vai fazer a media da variavel estimate e agrupar os dados por year e indic

tem outras opções além de mean (median, sum, sd, count)

- **reshape**
transformar um long para wide

por exemplo: tenho 2 ou mais observações para ano com uma coluna com informações diferentes para o mesmo ano eu posso juntar essas informações;
o ano collapsa pra uma observação só e se cria 2 colunas para mostrar aqueles valores que estavam em linha.

exemplo:

**- long para wide -**
  
*reshape wide estimate, i(year) j(indic) string* ** aqui vc ancora o ano; e as opções contidas em indic vao virar cada uma uma variavel

**- wide para long -**

 *reshape long estimativa, i(country) j(coverage)*
 
 as variaveis que vc quer linhas a partir delas devem estar nomeadas todas iguais = estimativa1 estimativa2 estimativa3
 
 *reshape long [o nome das variaveis que vao virar linhas], i(o identificador) j(o nome da variavel nova)*

 *usei o isid para encontrar o ID unico.

 ```
** Aula 5

//q1- datas
generate data_inicial = mdy(mes0, dia0, ano0) //gerando a variavel data
format data_inicial %d //transformando a variavel data em algo legivel

// criar uma variavel que diga o tempo total de acompanhamento a partir de 2 datas

generate t_acompanhamento_dias = data1 - data_inicial

generate t_acompanhamento_meses = t_acompanhamento_dias/30

generate t_acompanhamento_anos= t_acompanhamento_dias/365

// qual o tempo medio de acompanhamento por país?

bysort pais: sum t_acompanhamento_dias, d
bysort pais: sum t_acompanhamento_meses, d
bysort pais: sum t_acompanhamento_anos, d

//q2 - colapsando aqui

// nao poderia só "bysort year indic: sum estimate"? = daria,
 testei aqui, mas nao reduz o banco, que é um dos objetivos do collapse

collapse (mean) estimate, by(year indic) //após salvei o banco como media

//abri o banco do zero

collapse (median) estimate, by(year indic) //após salvei o banco como mediana

//gerando um grafico a partir das medias

scatter estimate year, connect(.1) by(indic) xline(1990 1995 2000 2005 2010 2015) yline(0 .2 .4 .6 .8 1)

// fazendo o reshape - long para wide

reshape wide estimate, i(year) j(indic) // erro, precisaa acrescentar "string" no fim da linha

reshape wide estimate, i(year) j(indic) string 
// o ano tava duplicado, as duas obs diferentes para indic viraram 2 variaveis indic1 e indic 2,
com a estimativa para cada

//gerando um grafico

scatter estimateoverwgt5 year, connect(.1) xline(1990 1995 2000 2005 2010 2015) yline(0 .2 .4 .6 .8 1)  || scatter estimatestunt5 year, connect(.1) xline(1990 1995 2000 2005 2010 2015) yline(0 .2 .4 .6 .8 1) || lowess estimateoverwgt5 year || lowess estimatestunt5 year

//banco novo vida nova - vamos transformar de wide para long
primeiro preciso que as variaveis que vao virar linhas tenham o mesmo nome com final 1,2,3;
a parte inicial dela vai entrar na sintaxe para o stata saber de qm vc tá falando

//entao renomeando
ren r_anc15 estimativa1
ren r_sba5 estimativa2
ren r_bcgv estimativa3

//agora vc precisa definir qual a variavel que nao se repete, pq ela que vai ser dupli ou
triplicada, nesse caso é country (i)

//agora vc só precisa definir o nome da nova variavel que vai ser criada; ideal é que reflita
o que as variaveis antigas estavam medindo (j)

reshape long estimativa, i(country) j(coverage)

```

## Aula 6 - revisão

Comandos novos da aula:

- global\cd
  
#### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta

     
 - **global**
criar um atalho de texto para uma pasta, apenas isso, ao inves de digitar todo o caminho para uma pasta toda vez que for usar ela

*global base "C:\Users\lauri\Documents\stata"*

pode criar quantos vc quiser, com o nome que quiser (no lugar de *base*)
daí na hora abrir algo poderia fazer assim *use "$base\nomedoarquivo.dta"*

- **cd**
trocar o diretorio central; é a melhor ideia quando se vai ficar na mesma pasta só

*cd "o caminho"*

*dir* lista os arquivos da pasta

após é só *use nome do arquivo"

- **encode**
transformar de string para numerico, codificando tipo
*encode sexo, gen(sexo_num)*
sai de sexo(masculino, feminino) para sexo_num(1,2) com labels mantidos

- **recode**
transformar valores numericos em grupos (construir faixas etárias por exemplo)

### do file

```
//inicial

global base "C:\Users\lauri\Documents\stata"
global aula6 "$base\aula6"
cd $aula6

*OU

cd "C:\Users\lauri\Documents\stata\aula6"
dir
use "Aula 6 - Banco 1.dta", clear

*q1
describe

*q2
codebook

*q3
rename (ha027 ha033 ha079 ha104 ha105 ha111) (vdgame trabfora regime peso altura corpele)

*q4
//altura tá em cm // peso tá em string

gen altura_metros = altura/100
destring peso, gen(peso_num)

//construindo imc11

gen imc11 = peso_num/(altura_metros)^2
hist imc11, norm
label variable imc11 "imc em kg/m²"
sum imc11,d

*q5
recode imc11 (min/24.9999 = 0 "normal") (25/29.9999 = 1 "sobrepeso") (30/max = 2 "obesidade"), gen(imc_cat)

recode imc_cat (0 = 0 "normal") (1/2 = 1 "sobrepeso/obesidade"), gen(imc112)

tab imc_cat
tab imc112 //deu certo \o/

bysort sexo: tab imc112
bysort vdgame: ta imc112

*q6

gen idade_meses = (ha113 - datnasc)/30.43
sum idade_meses,d
codebook idade_meses
sort idade_meses
list idade_meses if idade_meses < 0
drop if _n == 1

//deixando uma nota
notes idade_meses: "idade do adolescente em meses no momento da entrevista. Uma (1) observação foi dropada devido a possuir uma data de nascimento anterior a 1993"

*q7
dir
use "Aula 6 - Banco 2.dta"

db merge
merge 1:1 numero using "C:\Users\lauri\Documents\stata\aula6\banco1-mod1.dta"
sort _merge
drop if _n == 1

*q8
twoway histogram hpct, by(sexo) // dois histogramas diferentes separados por uma categoria
twoway (histogram hpct) (kdensity hpct), by(sexo) //caso eu quisesse traçejar a curva

bysort sexo: sum(hpct)
bysort sexo: sum(hpcs)

*q9

*q10
clear
dir
use "Aula 6 - Banco 3.dta"
//renomeando
rename (kplanfi kdnfi kpnfi ksexfi) (dado1 dado2 dado3 dado4) // para passar para wide nao precisa renomear

notes: kplanfi "planejada?" kdnfi "data de nascimento" kpnfi "peso ao nascer" ksexfi "sexo"

reshape wide kplanfi kdnfi kpnfi ksexfi, i(numero) j(qtfil)

// outros dois jeitos para se fazer o reshape (FW)

// reshape wide kplanfi@ kdnfi@ ksexfi@ kpnfi@, i(numero) j(qtfil) // aqui o @ força a manter a ordem original

// reshape wide k*, i(numero) j(qtfil) //aqui o asterisco vai espalhar todas as variaveis começadas em k

label variable kplanfi1 "planejada?" 
label variable kdnfi1   "data de nascimento" 
label variable kpnfi1   "peso ao nascer" 
label variable ksexfi1  "sexo"

*q11
sum kpnfi1
tab kplanfi1
ta ksexfi1
 
format kdnfi1 %d // transformar a variavel data de nascimento de dias de 1960 para uma data legivel

generate data_futuro = mdy(04, 07, 2015) //criando uma variavel de uma data especifica
format data_futuro %d

gen idade_no_futuro = data_futuro - kdnfi1 // qual a idade no futuro em uma data específica?

gen idade_futuro_anos = idade_no_futuro / 365.25 // (de dias para anos)

// de dias para meses seria /30.44

// se a data fosse uma string 15/07/2023, como faz?

// *gen data_nasc = date(kdnfi1, "DMY")* // Supondo formato Dia/Mês/Ano

format data_nasc %d // apresenta em data normal

```


     




  








  

  








  


    
  








  
