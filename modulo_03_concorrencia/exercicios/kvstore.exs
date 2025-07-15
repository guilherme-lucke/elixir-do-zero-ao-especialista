defmodule KVStore do
  def iniciar() do
    # O estado inicial é um mapa vazio.
    spawn(fn -> loop(%{}) end)
  end

  defp loop(mapa_atual) do
    receive do
      {:put, chave, valor} ->
        novo_mapa = Map.put(mapa_atual, chave, valor)
        IO.puts("Armazenado: #{chave} => #{valor}")
        loop(novo_mapa)

      {:get, chave, remetente} ->
        valor = Map.get(mapa_atual, chave)
        send(remetente, {:valor, valor})
        loop(mapa_atual)
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> pid_kv = KVStore.iniciar()
# iex> send(pid_kv, {:put, :nome, "Ana"})
# Armazenado: nome => Ana
# iex> send(pid_kv, {:get, :nome, self()})
# iex> flush()
# {:valor, "Ana"}
# :ok

pid_kv = KVStore.iniciar()

send(pid_kv, {:put, :nome, "Ana"})
send(pid_kv, {:get, :nome, self()})

receive do
  {:valor, valor} ->
    IO.inspect(valor, label: "Valor retornado")
after
  2000 ->
    IO.puts("Timeout esperando resposta")
end
