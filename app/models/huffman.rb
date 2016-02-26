class Huffman < ActiveRecord::Base
  attr_accessor :root, :dicionario, :input, :output

  def initialize(input)
    puts "Iniciando Huffman"
    @input = input
    @root = Fila.new(input).raiz_huffman # Inicia o programa
    @output = codificar_string(input) # retorna a string codificada
  end

#Montando o dicionario
  def procurar
    return @dicionario if @dicionario
    @dicionario = {} # ARRAY com o dicionario
    @root.walk do |no, code| # começa percorrendo a arvore pela raiz
      @dicionario[code] = no.simbolo if no.folha? # Se o no for uma folha, seu simbolo e codigo sao inseridos no dicionario
    end
    @dicionario # retorna o dicionario
  end

  def codificar(char)
    self.procurar.invert[char]
  end

  def codificar_string(string)
    puts string
    code = ''
    string.each_char do |c|
      code += codificar(c) # Concatena os codigos do dicionario
    end
    code
  end

  def to_s
    @output
  end
end
