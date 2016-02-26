class Fila < ActiveRecord::Base
  attr_accessor :no, :raiz_huffman

  def initialize(string)
    $frequencia = {}
    string.each_char do |c|     # Conta quantas vezes os simbolos aparecem
      $frequencia[c] ||= 0      # O indice eh o caracatere eh o valor a quantidade
      $frequencia[c] += 1
    end
    @no = []
    $frequencia.each do |c, w|   
      @no << No.new(:simbolo => c, :frequencia => w) # Cria um array de nos com simbolo e frequencia
    end
    gerar_arvore # Gera a arvore
  end

  def gerar_arvore
    while @no.size > 1
      ordenado = @no.sort { |a,b| a.frequencia <=> b.frequencia } # Ordena o aray de nos
      to_merge = []
      2.times { to_merge << ordenado.shift } # Combina os dois simbolos de menor frequencia (Removendo dos ordenados)
      ordenado << merge_no(to_merge[0], to_merge[1]) # Novo no eh inserido no array dos ordenados
      @no = ordenado
    end
    @raiz_huffman = @no.first # retorna a raiz
  end

#Soma as frequencias dos nos de menor frequencia
#Faz o merge dos Nos
  def merge_no(no1, no2)
    esquerda = no1.frequencia > no2.frequencia ? no2 : no1
    direita = esquerda == no1 ? no2 : no1
    no = No.new(:frequencia => esquerda.frequencia + direita.frequencia, :esquerda => esquerda, :direita => direita)
    esquerda.pai = direita.pai = no # Define o pai dos nos direita e esquerda
    no
  end
end
