defmodule LeitorProcessador.Supervisor do
  use Supervisor

  def start_link(init_arg), do: Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)

  @impl true
  def init(_init_arg) do
    children = [
      Leitor,
      Processador
    ]
    # A estratégia crucial para este problema!
    Supervisor.init(children, strategy: :one_for_all)
  end
end
