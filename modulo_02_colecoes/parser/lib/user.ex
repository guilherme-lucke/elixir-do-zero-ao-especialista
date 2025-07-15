defmodule Parser.User do
  # Usamos @enforce_keys para garantir que o id, nome e email
  # SEMPRE sejam fornecidos ao criar o struct. Isso adiciona robustez.
  @enforce_keys [:id, :nome, :email]
  defstruct [:id, :nome, :email]
end
