## Aula 4 - Merge e append

Comandos da aula:

- merge
- append
  
### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta
  3. abrir o Do file
     
### append
- juntar linhas (observações) ao banco de dados que está sendo utilizado (estudos transversais)
- *db append*
- pode acontecer de colunas nao se juntarem, então tu vai precisar usar o replace


### merge
juntar colunas ao banco (estudos de coorte)
banco "master" é o aberto
banco "using" é o externo que tu quer trazer

pode acontecer de os bancos nao terem o mesmo numero de observações, dai vai dar caô, tu vai precisar examinar cada banco manualmente através dos seguintes comandos:

### duplicates

vc precisa descobrir quem é figurinha repetida! 

*duplicates list* => vai te listar as obs duplicadas
aqui voce vai saber qm é duplicata

OU

*duplicates tag, gen (duplicatas)* => cria uma nova variavel em que as duplicatas estao com essa "flag= oi sou duplicata"

*tab duplicadas*
aqui lista quantas tem de duplicata e nao duplicata

logo após vc pode *drop duplicatas*


2 modos principais:
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

// q2f
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


  








  
