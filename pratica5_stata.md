## Aula 5 - wide/long

Comandos da aula:

- mdy
- date()
- collapse
- long
- reshape
  
### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
  3. abrir o banco

### mdy() 
=juntar e criar uma data
vai contar os dias desde uma data especifica (1/1/1960) a partir das datas dadas
se tuas datas estão separadas por variaveis de dia, mes e ano, tu consegue juntar usando esse comando.

então exemplo:

*generate data_inicial = mdy(mes1, dia1, ano1)*	
**o ano tem que ter 4 digitos

### *format data_inicial %d*
transforma a variavel criada pelo mdy() de numeros totais de 1960 para uma data legivel

### collapse
vc tem um banco long e quer juntar medidas repetidas sumarizando uma variavel;

exemplo:
*collapse (mean) estimate, by(year indic)* => vai fazer a media da variavel estimate e agrupar os dados por year e indic

tem outras opções além de mean (median, sum, sd, count)

### reshape
transformar um long para wide

por exemplo: tenho 2 ou mais observações para ano com uma coluna com informações diferentes para o mesmo ano eu posso juntar essas informações;
o ano collapsa pra uma observação só e se cria 2 colunas para mostrar aqueles valores que estavam em linha.

exemplo:

- long para wide -
  
*reshape wide estimate, i(year) j(indic) string* ** aqui vc ancora o ano; e as opções contidas em indic vao virar cada uma uma variavel

- wide para long -

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



     




  








  
