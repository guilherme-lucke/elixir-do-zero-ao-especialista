defmodule Blog do
  def agrupar_por_categoria(posts) do
    # O acumulador (acc) começa como um mapa vazio.
    Enum.reduce(posts, %{}, fn post, acc ->
      # Para cada post, pegamos o título e a categoria.
      titulo = post.titulo
      categoria = post.categoria

      # Usamos Map.update/4:
      # - acc: o mapa que queremos atualizar.
      # - categoria: a chave que queremos atualizar/inserir.
      # - [titulo]: o valor a ser inserido se a chave não existir.
      # - fn (lista_existente) -> ... end: a função a ser chamada se a chave já existir.
      #   Ela recebe a lista de títulos que já estava lá e adiciona o novo.
      Map.update(acc, categoria, [titulo], fn lista_existente -> [titulo | lista_existente] end)
    end)
  end

  # Modelando um Post de Blog
  defstruct [:id, :title, :author, tags: [], published_at: nil]

  def resumo(%Blog.Post{} = post) do
    "Título: #{post.title}, Autor: #{post.author}"
  end

end

# --- Área de Testes ---

# Para testar no iex:
# iex> posts = [
# ...>   %{titulo: "Elixir é demais", categoria: :elixir},
# ...>   %{titulo: "Entendendo OTP", categoria: :elixir},
# ...>   %{titulo: "SQL para iniciantes", categoria: :banco_de_dados}
# ...> ]
# iex> Blog.agrupar_por_categoria(posts)
# %{
#   banco_de_dados: ["SQL para iniciantes"],
#   elixir: ["Entendendo OTP", "Elixir é demais"]
# }

posts = [
  %{titulo: "Elixir é demais", categoria: :elixir},
  %{titulo: "Entendendo OTP", categoria: :elixir},
  %{titulo: "SQL para iniciantes", categoria: :banco_de_dados}
]
IO.inspect Blog.agrupar_por_categoria(posts)
