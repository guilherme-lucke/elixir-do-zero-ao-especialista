defmodule Parser do
  @doc "Transforma uma query string em um mapa."
  def parse(query_string) do
    query_string
    |> String.split("&") # ["nome=Ana", "idade=30", "cidade=Rio"]
    |> Enum.map(&parse_par/1) # [{:nome, "Ana"}, {:idade, "30"}, {:cidade, "Rio"}]
    |> Map.new() # %{cidade: "Rio", idade: "30", nome: "Ana"}
  end

  # Função privada que lida com um único par "chave=valor".
  # Usamos pattern matching aqui também!
  defp parse_par(par_string) do
    # "nome=Ana" -> ["nome", "Ana"]
    [chave, valor] = String.split(par_string, "=", parts: 2)

    # Retorna a tupla no formato que `Map.new/1` espera.
    {String.to_atom(chave), valor}
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> Parser.parse("nome=Ana&idade=30&cidade=Rio")
# %{cidade: "Rio", idade: "30", nome: "Ana"}

IO.inspect Parser.parse("nome=Ana&idade=30&cidade=Rio")
