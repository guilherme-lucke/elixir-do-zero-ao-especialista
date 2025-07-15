defmodule TextUtil do
  @doc """
  Inverte uma string e a converte para maiúsculas.
  """
  def formatar(texto) do
    texto
    |> inverter() # Chama a função privada
    |> String.upcase() # Chama uma função do módulo String
  end

  # Função privada que contém o detalhe de implementação da inversão.
  defp inverter(texto) do
    String.reverse(texto)
  end

  def slugify(titulo) do
    titulo
    |> String.trim()
    |> String.downcase()
    |> String.replace(" ", "-")
    |> String.replace("!", "")
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> TextUtil.formatar("elixir")
# "RIXILE"
# iex> TextUtil.slugify("  Meu Primeiro Post em Elixir!  ")
# "meu-primeiro-post-em-elixir"

IO.puts TextUtil.formatar("elixir")
IO.puts TextUtil.slugify("  Meu Primeiro Post em Elixir!  ")
