class Huffman < ActiveRecord::Base
  attr_accessor :root, :lookup, :input, :output

  def initialize(input)
    puts "Iniciando Huffman"
    @input = input
    @root = Fila.new(input).huffman_root
    @output = encode_string(input)
  end

  def lookup
    return @lookup if @lookup
    @lookup = {}
    @root.walk do |node, code|
      @lookup[code] = node.simbolo if node.leaf?
    end
    @lookup
  end

  def encode(char)
    self.lookup.invert[char]
  end

  def encode_string(string)
    code = ''
    string.each_char do |c|
      code += encode(c) 
    end
    code
  end

  def to_s
    @output
  end
end
