class MultimidiaController < ApplicationController
  def index
  end

  def escolha 
    if params[:commit] == "Huffman"
      puts params[:input]
      json = calcHuffman(params[:input])
    elsif params[:commit] == "LZ-78 + Huffman"
      json = calcLz78(params[:input])

    end
    puts 3
    respond_to do |format|
      format.json { render json: json }
    end
  end

  def calcHuffman (input)
    resposta = Huffman.new(input)

    base = (Math.sqrt($frequencia.length)).ceil # Acha a base menor
    bits_asc2 = input.length * 8.0
    bits_base = input.length * base

    porcentagem_base = bits_base/bits_asc2*100-100
    porcentagem_resposta = resposta.to_s.length/bits_asc2*100-100

    json = {  cod: "huffman",
              bits_asc2: bits_asc2, 
              base: base,
              bits_base: bits_base,  
              porcentagem_base: porcentagem_base.to_s + "%", 
              tamnaho_resposta: resposta.to_s.length,
              porcentagem_resposta: porcentagem_resposta.to_s + "%",
              resposta: resposta.to_s,
              frequencia: $frequencia,
              dicionario: resposta.procurar}.to_json
  end

    def calcLz78 (input)
      input = "ABBA"
      arrayNum = []
      arrayCaractere = ["A"]
      encontrado = false

      #Percorre caracteres
      input.each_char do |c|
        if arrayCaractere.include?(item)
          puts "ACHOU"
          puts index
        end
      end

      #   #Verifica se Existe
      #   until encontrado do

      #     if arrayCaractere.include?(item)
      #       caractere += item
      #       indexEncontrado = index
      #       item+=1
      #     else
      #       arrayNum.push(0)
      #       arrayCaractere.push(caractere)
      #     end
      #   end

      # json = {cod: "LZ-78 + Huffman"}.to_json

    end
end