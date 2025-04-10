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
2. será preciso um pacote especifico (vc precisa instalar e chamar o pacote pro jogo, senão ele não vem)
3. vamos criar um trecho de código com os pacotes básicos necessários que vc **precisa** executar sempre que abrir o R (vai de copia e cola)





  
