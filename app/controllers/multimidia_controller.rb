class MultimidiaController < ApplicationController
  def index
  end

  def calcHuffman
    input = params[:input]
    resposta = Huffman.new(input)

    base = (Math.sqrt($frequencies.length)).round

    bits_asc2 = input.length * 8.0
    bits_base = input.length * base

    porcentagem_base = bits_base/bits_asc2*100-100
    porcentagem_resposta = resposta.to_s.length/bits_asc2*100-100

    json = {  bits_asc2: bits_asc2, 
              base: base,
              bits_base: bits_base,  
              porcentagem_base: porcentagem_base.to_s + "%", 
              tamnaho_resposta: resposta.to_s.length,
              porcentagem_resposta: porcentagem_resposta.to_s + "%",
              resposta: resposta.to_s,
              frequencia: $frequencies,
              dicionario: resposta.lookup}.to_json

    respond_to do |format|
      format.json { render json: json }
    end
  end
end
