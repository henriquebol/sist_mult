class Lz < ActiveRecord::Base
  attr_accessor :simbolo, :indice

  def initialize(indice)
      @indice = indice
      @simbolo = Hash.new
  end

  def insere(simbolo, indice)
    @simbolo[simbolo] = Lz.new(indice)
  end

  def procura(simbolo)
    return @simbolo[simbolo]
  end

end
