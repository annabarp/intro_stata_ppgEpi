## Modificações iniciais no banco

Comandos da aula:

- rename
- label
- generate
- tabulate
- summarize
  
## Stata 
  1. abrir o log em formato .log
  2. no caso desse exercicio, digite o banco manualmente
  3. o stata tem apelidos pra suas variaveis, um fofo
  4. se algo estiver entre [] é pra substituir o conjunto todo por algo
  5. se estiver entre () mantem os parenteses e substitui o conteúdo dentro

### edit/browse
   edit(ou ed apenas) vc abre a planilha pra editar <br>
    -- ao criar variaveis direto no edit, o programa nomeia elas automaticamente como [var1..] <br>
    
  browse(ou br apenas) vc abre a planilha só para observar 0.o <br>
    
### rename 

  vc pode renomear varias juntas, sempre só com espaço, sem virgulas
  
  ex: *rename (varvelha1 varvelha2) (varnova1 varnova2)* talvez ao infinito
  
### label <br>
- label variable "o que vc quiser" = coloca uma etiqueta na variavel
    
- label define [nome da etiqueta] [valor real da obs] ["nome atribuido"]
  
  exemplo: *label define sim_ou_nao 1 "sim" 0 "nao"*
    
 - label values [variavel a atribuir uma etiqueta] [nome da etiqueta] 
  
  exemplo: *label values fuma sim_ou_nao*
     
### generate

cria uma nova variavel, pode ser a partir de outra
  - para transformar uma variavel que é string em numerica;
  exemplo: sexo está codificada "feminino" "masculino"

      *generate sexo_num = (sexo == "feminino")*
  -> nesse caso se sexo for IGUAL a feminino o programa devolve com 1 pois entende "TRUE"
- para criar uma nova variavel a partir da operação de uma original
  
 *generate estatura_metros = estatura/100*
  ou
 *generate imc = peso/(estatura_metros)^2*
  
### encode

- transformar uma serie de categorias dentro de uma variavel em numeros, atribuindo a ela labels 

*encode [ocupacao], generate(ocupacao_num) label(ocupacoes)* 

- o encode faz as categorias virarem numeros, o generate cria uma nova variavel a partir disso e o label vai pegar os antigos nomes e atribuir nessa nova variavel como labels(na ordem certa)

*foram 2 jeitos diferentes para string -> numerico*

### tab
 -  tabela com frequencias de uma variavel CATEGORICA

### summarize (ou sum)
 - estatistica descritiva basica de uma variavel numerica
  
 *sum imc, detail*

#### Obs:
Tipos de variaveis:
    
numericas
- discreta (byte, int, long)
- contínua (float, double)

texto
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



    
  


