defmodule Blog.Post do
  defstruct [:id, :title, :author, tags: [], published_at: nil]

  def resumo(%Blog.Post{} = post) do
    "Título: #{post.title}, Autor: #{post.author}"
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> meu_post = %Blog.Post{id: 1, title: "Aprendendo Structs", author: "Mentor Elixir"}
# iex> Blog.Post.resumo(meu_post)
# "Título: Aprendendo Structs, Autor: Mentor Elixir"

defmodule Main do
  def run do
    meu_post = %Blog.Post{id: 1, title: "Aprendendo Structs", author: "Mentor Elixir"}
    IO.inspect Blog.Post.resumo(meu_post)
  end
end
Main.run()
