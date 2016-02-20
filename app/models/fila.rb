class Fila < ActiveRecord::Base
  attr_accessor :nodes, :huffman_root

  def initialize(string)
    $frequencies = {}
    string.each_char do |c|
      $frequencies[c] ||= 0
      $frequencies[c] += 1
    end
    @nodes = []
    $frequencies.each do |c, w|
      @nodes << No.new(:simbolo => c, :frequencia => w)
    end
    generate_tree
  end

  def generate_tree
    while @nodes.size > 1
      sorted = @nodes.sort { |a,b| a.frequencia <=> b.frequencia }
      to_merge = []
      2.times { to_merge << sorted.shift }
      sorted << merge_nodes(to_merge[0], to_merge[1])
      @nodes = sorted
    end
    @huffman_root = @nodes.first
  end

  def merge_nodes(node1, node2)
    esquerda = node1.frequencia > node2.frequencia ? node2 : node1
    direita = esquerda == node1 ? node2 : node1
    node = No.new(:frequencia => esquerda.frequencia + direita.frequencia, :esquerda => esquerda, :direita => direita)
    esquerda.pai = direita.pai = node
    node
  end
end
