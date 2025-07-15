defmodule Formatador do
  def saudacoes_especiais(lista_de_nomes) do
    lista_de_nomes
    |> Enum.filter(fn nome -> String.length(nome) >= 4 end)
    |> Enum.map(fn nome -> "Olá, #{nome}!" end)
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> nomes = ["Ana", "Carlos", "Bia", "Daniela"]
# iex> Formatador.saudacoes_especiais(nomes)
# ["Olá, Carlos!", "Olá, Daniela!"]

nomes = ["Ana", "Carlos", "Bia", "Daniela"]
IO.inspect Formatador.saudacoes_especiais(nomes)
