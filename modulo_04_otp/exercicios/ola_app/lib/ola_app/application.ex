defmodule OlaApp.Application do
  use Application
  @impl true
  def start(_type, _args) do
    # Verificamos a dependência primeiro.
    case Application.ensure_all_started(:inets) do
      {:ok, _apps} ->
        IO.puts("Dependência :inets OK!")
        IO.puts("A aplicação 'Olá App' foi iniciada!")
        # Se a dependência está OK, procedemos com a inicialização normal.
        children = []
        opts = [strategy: :one_for_one, name: OlaApp.Supervisor]
        Supervisor.start_link(children, opts)

      {:error, reason} ->
        IO.puts("Falha ao iniciar a dependência :inets!")
        # Retornamos o erro, e o OTP não iniciará nossa aplicação.
        {:error, reason}
    end
  end
end
