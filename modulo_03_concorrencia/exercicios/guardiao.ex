defmodule Guardiao do
  def observar(pid_alvo) do
    Process.monitor(pid_alvo)
    IO.puts("Estou observando o processo #{inspect(pid_alvo)}...")
    receive do
      {:DOWN, _ref, :process, pid, motivo} ->
        IO.puts("Alerta! O processo #{inspect(pid)} foi finalizado pelo motivo: #{inspect(motivo)}.")
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> trabalhador_temporario = spawn(fn -> Process.sleep(1000) end)
# #pid<0.150.0>
# iex> spawn(fn -> Guardiao.observar(trabalhador_temporario) end)
# Estou observando o processo #pid<0.150.0>...
# #pid<0.151.0>
# ... 1 segundo depois ...
# Alerta! O processo #pid<0.150.0> foi finalizado pelo motivo: :normal.
