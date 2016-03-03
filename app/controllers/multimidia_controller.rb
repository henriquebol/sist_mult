class MultimidiaController < ApplicationController
  def index
  end

  def escolha 
    if params[:commit] == "Huffman"
      json = calcHuffman(params[:input])
      puts json
    elsif params[:commit] == "LZ-78 + Huffman"
      json = calcLz78(params[:input])
    end
    respond_to do |format|
      format.json { render json: json }
    end
  end

  def calcHuffman (input, input2 = nil)

    resposta = Huffman.new(input)
    puts "Resposta 1"
    puts resposta

    if !input2.nil?

      tamanho_input_original = params[:input].length

      resposta2 = Huffman.new(input2)
      puts "Resposta 2"
      puts resposta2

      quantidade_lz = @indices_lz.length + @caracteres_lz.length
      puts "##################################"
      puts @indices_lz.length
      puts @caracteres_lz.length
      puts "##################################"
      bits_original = tamanho_input_original * 8.0
      #Menor base dos indices
      base = (Math.sqrt(@indices_lz.length)).ceil # Acha a base menor
      bits_base = input.length * base
      #Base 8bits caracteres
      bits_asc2 = input2.length * 8.0
      bits_lz78 = bits_base + bits_asc2
      porcentagem_lz78 = bits_lz78/bits_original*100-100

      #Huffman
      tamanho_resposta = resposta.to_s.length + resposta2.to_s.length
      porcentagem_resposta = tamanho_resposta/bits_original*100-100


      json = {  cod: "LZ-78 + Huffman",
                quantidade_lz: quantidade_lz,
                bits_original: bits_original,
                bits_asc2: bits_asc2, 
                base: base,
                bits_base: bits_base, 
                bits_lz78: bits_lz78, 
                indices_lz: @indices_lz,
                caracteres_lz: @caracteres_lz,
                porcentagem_lz78: porcentagem_lz78.to_s + "%", 
                indices_lz_quantidade: @indices_lz.length,
                caracteres_lz_quantidade: @caracteres_lz.length,
                tamanho_resposta: tamanho_resposta,
                porcentagem_resposta: porcentagem_resposta.to_s + "%",
                resposta1: resposta.to_s,
                resposta2: resposta2.to_s,
                bits_input_original: tamanho_input_original*8,
                tamanho_input_original:tamanho_input_original}.to_json

    else

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
  end

  def calcLz78 (input)

    dicionario = []
    raiz = Lz.new(0)
    n = 0
    p = raiz # No que estamos verificando

    input.each_char{|c| # Percorre a string de entrada
      q = p.procura(c)
        if !q.nil? 
          puts q.indice
        end

      if !q.nil? # O filho não pode ser encontrado => siga em frente
        p = q
      else # Chegou ao fim
        dicionario.push [p.indice, c]
        n = n + 1
        puts "Insere n:#{n} o #{p.indice}"
        p.insere(c, n)
        puts "Antes: #{p.indice}"
        p = raiz
      end
      puts "Proximo Caractere "
    }

    puts "Depois: #{p.indice}"
    if p.indice # Siga a criança, quando ele não ir até a folha
      dicionario.push [p.indice, '']
    end

    @indices_lz = []
    @caracteres_lz = []

    dicionario.each do |(indice, char)|
        @indices_lz.push(indice)
    end

    dicionario.each do |(indice, char)|
        @caracteres_lz.push(char)
    end

    @indices_lz = @indices_lz.join
    @caracteres_lz = @caracteres_lz.join

    calcHuffman(@indices_lz, @caracteres_lz)
  end

end