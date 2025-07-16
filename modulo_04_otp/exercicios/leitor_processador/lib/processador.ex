defmodule Processador do
  use GenServer

  def start_link(_args), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @impl true
  def init(_) do
    IO.puts("Processador iniciado!")
    {:ok, nil}
  end
end
