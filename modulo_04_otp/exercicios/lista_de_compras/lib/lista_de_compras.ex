defmodule ListaDeCompras do
  use GenServer

  # API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def adicionar_item(item) do
    GenServer.cast(__MODULE__, {:add, item})
  end

  def ver_lista() do
    GenServer.call(__MODULE__, :list)
  end

  # Callbacks
  @impl true
  def init(lista_inicial), do: {:ok, lista_inicial}

  @impl true
  def handle_cast({:add, item}, lista_atual) do
    nova_lista = [item | lista_atual]
    {:noreply, nova_lista}
  end

  @impl true
  def handle_call(:list, _from, lista_atual) do
    {:reply, lista_atual, lista_atual}
  end
end

# Para testar (depois de adicionar ao supervisor):
# iex> ListaDeCompras.adicionar_item("leite")
# :ok
# iex> ListaDeCompras.adicionar_item("pão")
# :ok
# iex> ListaDeCompras.ver_lista()
# ["pão", "leite"]
