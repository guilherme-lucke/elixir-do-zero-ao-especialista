defmodule Eco do
  def iniciar() do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      {remetente, conteudo} ->
        send(remetente, {:eco, conteudo})
    end
    loop() # Próxima iteração!
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> pid_eco = Eco.iniciar()
# #pid<0.135.0>
# iex> send(pid_eco, {self(), "Olá, mundo!"})
# iex> flush() # `flush()` é um ajudante do iex que mostra todas as mensagens na sua caixa de entrada.
# {:eco, "Olá, mundo!"}
# :ok

pid_eco = Eco.iniciar()
send(pid_eco, {self(), "Olá, mundo!"})

receive do
  {:eco, resposta} ->
    IO.puts("Recebido do processo eco: #{resposta}")
after
  2000 ->
    IO.puts("Tempo limite! Nenhuma resposta recebida.")
end
