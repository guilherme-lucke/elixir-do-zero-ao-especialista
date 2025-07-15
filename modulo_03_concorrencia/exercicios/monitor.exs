defmodule Monitor do
  def verificar_servidores(lista_de_servidores) do
    IO.puts("Iniciando verificação de status de #{Enum.count(lista_de_servidores)} servidores...")

    Enum.each(lista_de_servidores, fn servidor ->
      # Para cada servidor, spawnamos um processo que chama nossa função privada.
      spawn(fn -> ping_servidor(servidor) end)
    end)
  end

  # Função privada que simula o trabalho de cada processo.
  defp ping_servidor(nome_do_servidor) do
    tempo_de_espera = :rand.uniform(3000)
    Process.sleep(tempo_de_espera)
    IO.puts("[OK] Servidor '#{nome_do_servidor}' está online. (Resposta em #{tempo_de_espera}ms)")
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> servidores = ["db-principal", "api-gateway", "servico-de-cache", "servidor-web"]
# iex> Monitor.verificar_servidores(servidores)
# Iniciando verificação de status de 4 servidores...
# :ok
#
# ... observe as mensagens chegando em ordem aleatória, provando a execução concorrente! ...
# [OK] Servidor 'servico-de-cache' está online. (Resposta em 1234ms)
# [OK] Servidor 'db-principal' está online. (Resposta em 1890ms)
# [OK] Servidor 'servidor-web' está online. (Resposta em 2500ms)
# [OK] Servidor 'api-gateway' está online. (Resposta em 2950ms)

servidores = ["db-principal", "api-gateway", "servico-de-cache", "servidor-web"]

IO.inspect Monitor.verificar_servidores(servidores)
# Espera para ver os resultados no terminal antes do script encerrar
Process.sleep(4000)
