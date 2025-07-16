defmodule Cache.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # O único filho da nossa aplicação é o nosso supervisor principal.
    children = [
      Cache.Supervisor
    ]
    opts = [strategy: :one_for_one, name: Cache.MainSupervisor]
    Supervisor.start_link(children, opts)
  end
end
