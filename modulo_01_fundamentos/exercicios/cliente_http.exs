defmodule ClienteHttp do
  def interpretar_resposta(resposta) do
    case resposta do
      # Corresponde a uma tupla de 2 elementos, com o primeiro sendo :ok
      # e vincula o segundo elemento à variável `corpo`.
      {:ok, corpo} ->
        "Sucesso! Corpo da resposta: #{corpo}"

      # Corresponde a uma tupla de 2 elementos, com o segundo sendo o valor 404.
      {:error, 404} ->
        "Erro: Página não encontrada."

      # Corresponde a uma tupla de 2 elementos, com o segundo sendo o valor 500.
      {:error, 500} ->
        "Erro: Falha interna do servidor."

      # Corresponde a qualquer outra tupla que comece com :error.
      # O `_` ignora o código de erro específico.
      {:error, _} ->
        "Erro desconhecido."
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> ClienteHttp.interpretar_resposta({:ok, "<html>...</html>"})
# "Sucesso! Corpo da resposta: <html>...</html>"
# iex> ClienteHttp.interpretar_resposta({:error, 404})
# "Erro: Página não encontrada."
# iex> ClienteHttp.interpretar_resposta({:error, 403})
# "Erro desconhecido."

IO.puts ClienteHttp.interpretar_resposta({:ok, "Tudo certo"})
IO.puts ClienteHttp.interpretar_resposta({:error, 404})
IO.puts ClienteHttp.interpretar_resposta({:error, 500})
IO.puts ClienteHttp.interpretar_resposta({:error, 403})
