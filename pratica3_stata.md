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
<br> te dá o numero de var e obs

 ### *generate*
  
*generate [varnova] = [varvelha] > 10* (valor q vc quiser)

ex: *generate bxpeso1 = apesorn < 2500*
<br> ** vc está criando uma nova variável a partir de uma antiga

*generate bxpeso2 =.* <br> ** aqui gera uma variavel apenas, com todos os valores missing

### recode
recode bxpeso2 (. = 0) if apesorn >= 2500 
recode bxpeso2 (. = 1) if apesorn < 2500

recode apesorn min / 2499.999 = 1 2500 / max = 0, generate(bxpeso3)

A questão aqui: apenas a terceira maneira (recode + parametros) encara os missing da variavel original como missing, os outros 2 primeiros classificam o missing como 0.

  
### egen
  
*egen renda_nova1 = rowtotal(arenda1 arenda2 arenda3 arenda4)*
desse jeito mesmo que todas as variaveis somadas sejam missing, o egen devolve um 0

diferente no "generate", que com um codigo com a mesma finalidade
*generate renda_nova = arenda1 + arenda2  + arenda3 + arenda4*
assim tendo APENAS 1 variavel das somas missing, a variável gerada terá missing

### proportion/prop
dá as proporções em uma variavel categórica

### xtile 
divide uma variavel em quantis, tu especifica o numero de quantis pelo nq(#)
*[varnova] = [varvelha], nq(3)*

### bysort
mostra uma variavel por outra
*bysort regioesdobrasil: sum renda*
*bysort altura_qtis: summarize aaltmae* aqui vc ta vendo as medidas gerais de aaltmae mas divido por uma outra variavel(aqui quintis de altura)



- *replace* - substitui toda a variável (codifica as obs.)
- *encode* - variável string vira numérica (uma simples troca de categoria, que só funciona se as obs. já forem numericas)
- *destring* - variável string vira numérica
- *tostring* - variavel numerica vira string
- 


