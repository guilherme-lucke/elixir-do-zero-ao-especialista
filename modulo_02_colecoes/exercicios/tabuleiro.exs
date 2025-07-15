defmodule Tabuleiro do
  def gerar_coordenadas(tamanho) do
    for x <- 1..tamanho, y <- 1..tamanho do
      {x, y}
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> Tabuleiro.gerar_coordenadas(2)
# [{1, 1}, {1, 2}, {2, 1}, {2, 2}]
# iex> Tabuleiro.gerar_coordenadas(3) |> Enum.count()
# 9

IO.inspect Tabuleiro.gerar_coordenadas(2)
IO.inspect Tabuleiro.gerar_coordenadas(3) |> Enum.count()
