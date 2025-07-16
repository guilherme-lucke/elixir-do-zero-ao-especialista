defmodule Cache do
  @doc """
  Armazena um valor no cache.

  A opção `ttl` (Time-To-Live) pode ser passada em segundos.
  """
  def put(key, value, opts \\ []) do
    ttl = Keyword.get(opts, :ttl)
    # Esconde a chamada `cast` do usuário final.
    GenServer.cast(Cache.Server, {:put, key, value, ttl})
  end

  @doc """
  Recupera um valor do cache.
  """
  def get(key) do
    # Esconde a chamada `call` do usuário final.
    GenServer.call(Cache.Server, {:get, key})
  end
end
