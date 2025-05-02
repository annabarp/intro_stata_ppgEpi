## Aula 3 - Recodificando variáveis

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


