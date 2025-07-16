defmodule LeitorProcessador.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeitorProcessador.Supervisor
    ]

    opts = [strategy: :one_for_one, name: LeitorProcessador.MainSupervisor]
    Supervisor.start_link(children, opts)
  end
end
