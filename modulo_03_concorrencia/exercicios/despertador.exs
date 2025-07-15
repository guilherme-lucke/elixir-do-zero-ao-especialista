defmodule Despertador do
  def definir_alarme(mensagem, segundos) do
    # Convertemos segundos para milissegundos
    tempo_ms = segundos * 1000

    # Criamos a função anônima que será o nosso "trabalho"
    funcao_do_alarme = fn ->
      Process.sleep(tempo_ms)
      IO.puts("BEEP BEEP BEEP: #{mensagem}")
    end

    # Spawnamos o processo e retornamos o PID para o chamador.
    spawn(funcao_do_alarme)
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> IO.puts("Definindo alarme para daqui a 3 segundos...")
# iex> Despertador.definir_alarme("Hora de tomar café!", 3)
# #pid<0.130.0>
# iex> IO.puts("Alarme definido. Posso continuar trabalhando...")
#
# ... após 3 segundos, a mensagem aparecerá no console ...
# BEEP BEEP BEEP: Hora de tomar café!
IO.puts("Definindo alarme para daqui a 3 segundos...")
IO.inspect Despertador.definir_alarme("Hora de tomar café!", 3)
IO.puts("Alarme definido. Posso continuar trabalhando...")
