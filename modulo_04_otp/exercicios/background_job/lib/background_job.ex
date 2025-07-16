defmodule BackgroundJob do
  use GenServer
  def start_link(duracao), do: GenServer.start_link(__MODULE__, duracao)
  @impl true
  def init(duracao) do
    job_id = inspect(self())
    IO.puts("[#{job_id}] Job iniciado, vai rodar por #{duracao} segundos.")
    {:ok, duracao, {:continue, :executar}}
  end

  @impl true
  def handle_continue(:executar, duracao) do
    Process.sleep(duracao * 1000)
    IO.puts("[#{inspect(self())}] Job finalizado.")
    {:noreply, duracao}
  end
end
