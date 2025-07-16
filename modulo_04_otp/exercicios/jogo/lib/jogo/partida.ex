defmodule Jogo.Partida do
  use GenServer
  def start_link(id_da_partida), do: GenServer.start_link(__MODULE__, id_da_partida)
  @impl true
  def init(id_da_partida) do
    IO.puts("Partida #{id_da_partida} iniciada! PID: #{inspect(self())}")
    {:ok, id_da_partida}
  end
end
