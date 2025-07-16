defmodule CaixaEletronico do
  use GenServer

  # API
  def start_link(opts) do
    # Extraímos o saldo inicial das opções.
    saldo_inicial = Keyword.get(opts, :saldo_inicial, 0)
    GenServer.start_link(__MODULE__, saldo_inicial, name: __MODULE__)
  end

  def saldo(), do: GenServer.call(__MODULE__, :get_saldo)
  def depositar(quantia), do: GenServer.cast(__MODULE__, {:depositar, quantia})
  def sacar(quantia), do: GenServer.call(__MODULE__, {:sacar, quantia})

  # Callbacks
  @impl true
  def init(saldo), do: {:ok, saldo}

  @impl true
  def handle_call(:get_saldo, _from, saldo_atual) do
    {:reply, saldo_atual, saldo_atual}
  end

  @impl true
  def handle_call({:sacar, quantia}, _from, saldo_atual) do
    if quantia <= saldo_atual do
      novo_saldo = saldo_atual - quantia
      {:reply, {:ok, novo_saldo}, novo_saldo}
    else
      {:reply, {:error, :saldo_insuficiente}, saldo_atual}
    end
  end

  @impl true
  def handle_cast({:depositar, quantia}, saldo_atual) do
    novo_saldo = saldo_atual + quantia
    {:noreply, novo_saldo}
  end
end

# Para testar (adicione ao supervisor, passando o saldo inicial):
# children = [
#   {CaixaEletronico, saldo_inicial: 100}
# ]
# iex> CaixaEletronico.saldo()
# 100
# iex> CaixaEletronico.depositar(50)
# :ok
# iex> CaixaEletronico.saldo()
# 150
# iex> CaixaEletronico.sacar(200)
# {:error, :saldo_insuficiente}
# iex> CaixaEletronico.sacar(70)
# {:ok, 80}
# iex> CaixaEletronico.saldo()
# 80
