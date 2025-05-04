## Aula 6 - revisão

Comandos novos da aula:

- global\cd
  
### Stata 
  1. abrir o log em formato .log
  2. abrir o banco de dados .dta

     
 ### global
criar um atalho de texto para uma pasta, apenas isso, ao inves de digitar todo o caminho para uma pasta toda vez que for usar ela

*global base "C:\Users\lauri\Documents\stata"*

pode criar quantos vc quiser, com o nome que quiser (no lugar de *base*)
daí na hora abrir algo poderia fazer assim *use "$base\nomedoarquivo.dta"*

### cd
trocar o diretorio central; é a melhor ideia quando se vai ficar na mesma pasta só

*cd "o caminho"*

*dir* lista os arquivos da pasta

após é só *use nome do arquivo"

### encode 
transformar de string para numerico, codificando tipo
*encode sexo, gen(sexo_num)*
sai de sexo(masculino, feminino) para sexo_num(1,2) com labels mantidos

### recode
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



