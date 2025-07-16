defmodule Cache.Server do
  use GenServer

  # --- API Pública (para o módulo Cache chamar) ---
  def start_link(_opts) do
    # O estado inicial é um mapa vazio.
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # --- Callbacks do GenServer ---
  @impl true
  def init(state) do
    IO.puts("Serviço de Cache iniciado.")
    {:ok, state}
  end

  # Usamos `call` para `get` porque precisamos de uma resposta síncrona.
  @impl true
  def handle_call({:get, key}, _from, state) do
    # `get_entry` é uma função privada que lida com a lógica de expiração.
    reply = get_entry(state, key)
    {:reply, reply, state}
  end

  # Usamos `cast` para `put` porque não precisamos de uma resposta imediata.
  @impl true
  def handle_cast({:put, key, value, ttl}, state) do
    # `put_entry` é uma função privada que agenda a expiração.
    new_state = put_entry(state, key, value, ttl)
    {:noreply, new_state}
  end

  # Este é o callback para a mensagem de limpeza que agendamos!
  @impl true
  def handle_info({:delete, key}, state) do
    IO.puts("TTL expirado. Removendo a chave: #{inspect(key)}")
    new_state = Map.delete(state, key)
    {:noreply, new_state}
  end

  # --- Funções Privadas Auxiliares ---
  defp put_entry(state, key, value, ttl) do
    # Se um TTL (em segundos) for fornecido...
    if ttl do
      # Agendamos uma mensagem `:delete` para ser enviada a este processo
      # daqui a `ttl` segundos.
      Process.send_after(self(), {:delete, key}, ttl * 1000)
    end

    # Armazenamos o valor no nosso mapa de estado.
    Map.put(state, key, value)
  end

  # Esta função é chamada por `handle_call` para verificar a validade da chave.
  # Neste modelo simples, a verificação de expiração não está implementada no get,
  # apenas no `send_after`. Uma versão mais avançada faria a verificação aqui também.
  # Para nosso projeto, a remoção via `handle_info` é suficiente.
  defp get_entry(state, key) do
    Map.get(state, key)
  end
end
