defmodule Gerenciador do
  def iniciar_sessao() do
    # O gerenciador se auto-spawna.
    spawn(fn ->
      # Dentro do gerenciador, spawnamos e monitoramos a conexão.
      pid_conexao = spawn(fn ->
        IO.puts("[Conexão] Conexão estabelecida, válida por 5 segundos.")
        Process.sleep(5000)
      end)
      Process.monitor(pid_conexao)
      # Começa no estado :conectado
      loop(:conectado)
    end)
  end

  # Loop para o estado conectado
  defp loop(:conectado) do
    receive do
      :ping ->
        IO.puts("[Gerenciador] Pong!")
        loop(:conectado)
      {:DOWN, _, _, _, _} ->
        IO.puts("[Gerenciador] Conexão caiu!")
        loop(:desconectado)
    end
  end

  # Loop para o estado desconectado
  defp loop(:desconectado) do
    receive do
      :ping ->
        IO.puts("[Gerenciador] Sessão finalizada. Não posso mais responder.")
        loop(:desconectado)
    end
  end
end

# Para testar no iex:
# iex> pid_sessao = Gerenciador.iniciar_sessao()
# [Conexão] Conexão estabelecida, válida por 5 segundos.
# iex> send(pid_sessao, :ping)
# [Gerenciador] Pong!
# iex> send(pid_sessao, :ping)
# [Gerenciador] Pong!
# ... espere 5 segundos ...
# [Gerenciador] Conexão caiu!
# iex> send(pid_sessao, :ping)
# [Gerenciador] Sessão finalizada. Não posso mais responder.
