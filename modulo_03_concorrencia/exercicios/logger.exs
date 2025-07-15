defmodule MeuLogger do
  def iniciar() do
    # Inicia o processo com um estado inicial: uma lista vazia.
    spawn(fn -> loop([]) end)
  end

  # O estado (a lista de logs) é passado como argumento para o loop.
  defp loop(logs) do
    receive do
      {:log, mensagem} ->
        IO.puts("[Logger] Nova entrada registrada.")
        # A chamada recursiva passa o NOVO estado.
        loop([mensagem | logs])

      {:ver_logs, remetente} ->
        # Envia o estado ATUAL para o remetente.
        send(remetente, {:logs_atuais, logs})
        # A chamada recursiva continua com o MESMO estado.
        loop(logs)
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> pid_logger = MeuLogger.iniciar()
# #pid<0.140.0>
# iex> send(pid_logger, {:log, "Usuário 1 logou."})
# [Logger] Nova entrada registrada.
# iex> send(pid_logger, {:log, "Pagamento recebido."})
# [Logger] Nova entrada registrada.
# iex> send(pid_logger, {:ver_logs, self()})
# iex> flush()
# {:logs_atuais, ["Pagamento recebido.", "Usuário 1 logou."]}
# :ok

pid_logger = MeuLogger.iniciar()
send(pid_logger, {:log, "Usuário 1 logou."})
send(pid_logger, {:log, "Pagamento recebido."})
send(pid_logger, {:ver_logs, self()})

receive do
  {:logs_atuais, logs} ->
    IO.inspect(logs, label: "Logs atuais")
after
  2000 ->
    IO.puts("Tempo esgotado! Nenhuma resposta do Logger.")
end
