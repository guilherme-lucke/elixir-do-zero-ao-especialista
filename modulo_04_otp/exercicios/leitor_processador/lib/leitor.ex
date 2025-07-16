defmodule Leitor do
  use GenServer

  def start_link(_args), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def crash_leitor, do: GenServer.cast(__MODULE__, :crash)

  @impl true
  def init(_) do
    IO.puts("Leitor iniciado!")
    {:ok, nil}
  end

  @impl true
  def handle_cast(:crash, _state), do: exit(:leitor_falhou)
end
