defmodule ListaDeCompras.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Aqui adicionamos seu supervisor secundário
      ListaDeCompras.Supervisor
    ]

    opts = [strategy: :one_for_one, name: ListaDeCompras.MainSupervisor]
    Supervisor.start_link(children, opts)
  end
end
