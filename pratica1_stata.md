## Abre o log / Abre e salva o do / salva o doc no teu nome

### Explorando o banco

Comandos da aula:

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
<br> *count if apesorn > 2000* (conta o numero de observações que o peso é maior que x)

- *log*
  
  *log close* =  fecha o log
  
  *log on/off* = pausa
  
  *log query*= diz se aberto ou não, se aberto mostra o caminho
  
  *log using "nome_do_arquivo" append* =  reiniciar um log fechado
  







  
