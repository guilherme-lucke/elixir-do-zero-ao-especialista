defmodule CLI do
  def executar(comando) do
    case comando do
      {:ler, arquivo} ->
        "Lendo o arquivo: #{arquivo}"

      {:escrever, arquivo, conteudo} ->
        "Escrevendo no arquivo #{arquivo} com o conteúdo: '#{conteudo}'"

      {:apagar, arquivo} ->
        "Apagando o arquivo: #{arquivo}"

      _ ->
        "Comando inválido."
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> CLI.executar({:ler, "config.txt"})
# "Lendo o arquivo: config.txt"
#
# iex> CLI.executar({:escrever, "log.txt", "deu tudo certo"})
# "Escrevendo no arquivo log.txt com o conteúdo: 'deu tudo certo'"
#
# iex> CLI.executar(:ajuda)
# "Comando inválido."

IO.puts CLI.executar({:ler, "config.txt"})
IO.puts CLI.executar({:escrever, "log.txt", "deu tudo certo"})
IO.puts CLI.executar(:ajuda)
