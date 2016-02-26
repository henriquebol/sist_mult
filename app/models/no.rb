class No < ActiveRecord::Base
  attr_accessor :frequencia, :simbolo, :esquerda, :direita, :pai

  def initialize(params = {})
    @frequencia   = params[:frequencia]  || 0
    @simbolo   = params[:simbolo]  || ''
    @esquerda     = params[:esquerda]    || nil
    @direita    = params[:direita]   || nil
    @pai   = params[:pai]  || nil
  end

  def walk(&block)
    walk_node('', &block)
  end

# Define zeros e uns de forma recursiva
  def walk_node(code, &block)
    yield(self, code)
    @esquerda.walk_node(code + '0', &block) unless @esquerda.nil? # Zero para caminhos para a esquerda
    @direita.walk_node(code + '1', &block) unless @direita.nil? # Uns para caminhos para direita
  end

  def folha?
    @simbolo != '' #Se simbolo existe entao eh uma folha 
  end
end
