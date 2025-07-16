defmodule BackgroundJob.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JobSupervisor,
      JobRunner
    ]

    opts = [strategy: :one_for_one, name: BackgroundJob.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
