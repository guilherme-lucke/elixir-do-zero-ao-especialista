defmodule Jogo.Jogador do
  # Recebe um mapa de jogador e os pontos a adicionar.
  # Retorna um NOVO mapa com a pontuação atualizada.
  def aumentar_pontuacao(jogador, pontos) do
    pontuacao_antiga = jogador.pontuacao
    # Usamos a sintaxe de atualização de mapa. É mais limpa.
    %{jogador | pontuacao: pontuacao_antiga + pontos}
  end

  # Recebe um mapa de jogador e o bane.
  # Retorna um NOVO mapa com o status alterado.
  def banir_jogador(jogador) do
    %{jogador | status: :banido}
  end
end

# --- Área de Testes ---

# 1. Criamos nosso jogador inicial
jogador_original = %{nome: "Bia", pontuacao: 1500, status: :ativo}

# 2. Aumentamos a pontuação
jogador_com_nova_pontuacao = Jogo.Jogador.aumentar_pontuacao(jogador_original, 250)

# 3. Banimos o jogador (a partir do estado original)
jogador_banido = Jogo.Jogador.banir_jogador(jogador_original)

# 4. Inspecionamos tudo para provar a imutabilidade
IO.puts "--- Resultados ---"
IO.inspect(jogador_original, label: "Jogador Original")
IO.inspect(jogador_com_nova_pontuacao, label: "Após ganhar pontos")
IO.inspect(jogador_banido, label: "Versão Banida")
