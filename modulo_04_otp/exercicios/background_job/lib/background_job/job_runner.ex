defmodule JobRunner do
  use GenServer

  # API
  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  def submit_job(duracao), do: GenServer.call(__MODULE__, {:submit, duracao})

  # Callbacks
  @impl true
  def init(state), do: {:ok, state} # O estado pode ser um mapa para rastrear jobs

  @impl true
  def handle_call({:submit, duracao}, _from, state) do
    # Inicia o job através do supervisor dinâmico
    {:ok, pid} = DynamicSupervisor.start_child(JobSupervisor, {BackgroundJob, duracao})
    # Monitora o PID do novo job
    ref = Process.monitor(pid)
    # Responde imediatamente para quem chamou
    {:reply, {:ok, pid}, Map.put(state, ref, pid)} # Armazena a ref e o pid no estado
  end

  # Lida com a notificação de que um job terminou
  @impl true
  def handle_info({:DOWN, ref, :process, pid, _reason}, state) do
    IO.puts("[JobRunner] Notificado que o job #{inspect(pid)} terminou.")
    {:noreply, Map.delete(state, ref)} # Limpa o job do nosso rastreamento
  end
end
