defmodule Cache.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    # O único filho do nosso supervisor é o nosso GenServer do cache.
    children = [
      Cache.Server
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
