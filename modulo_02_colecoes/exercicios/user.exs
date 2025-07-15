defmodule User do
  defstruct [:id, :name]
end

defmodule Repositorio do
  def mapear_por_id(lista_de_usuarios) do
    for user <- lista_de_usuarios, into: %{} do
      {user.id, user}
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> usuarios = [
# ...>   %User{id: 101, name: "Ana"},
# ...>   %User{id: 205, name: "Beto"},
# ...>   %User{id: 317, name: "Carla"}
# ...> ]
# iex> Repositorio.mapear_por_id(usuarios)
# %{
#   101 => %User{id: 101, name: "Ana"},
#   205 => %User{id: 205, name: "Beto"},
#   317 => %User{id: 317, name: "Carla"}
# }

defmodule Main do
  def run do
    usuarios = [
      %User{id: 101, name: "Ana"},
      %User{id: 205, name: "Beto"},
      %User{id: 317, name: "Carla"}
    ]
    IO.inspect Repositorio.mapear_por_id(usuarios)
  end
end
Main.run()
