defmodule LogParser do
  def primeiros_erros(logs, quantidade) do
    logs
    |> Stream.filter(fn linha -> String.contains?(linha, "ERROR") end)
    |> Stream.map(fn linha ->
      # Exemplo: "ERROR: Falha na conexão" -> " Falha na conexão"
      [_tipo, mensagem] = String.split(linha, ":", parts: 2)
      String.trim(mensagem)
    end)
    |> Enum.take(quantidade)
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> logs = [
# ...>   "INFO: Usuário logado",
# ...>   "ERROR: Falha na conexão",
# ...>   "INFO: Requisição recebida",
# ...>   "DEBUG: Valor da variável x=10",
# ...>   "ERROR: Banco de dados indisponível",
# ...>   "ERROR: Timeout na API externa",
# ...>   "INFO: Processo finalizado"
# ...> ]
# iex> LogParser.primeiros_erros(logs, 2)
# ["Falha na conexão", "Banco de dados indisponível"]

logs = [
  "INFO: Usuário logado",
  "ERROR: Falha na conexão",
  "INFO: Requisição recebida",
  "DEBUG: Valor da variável x=10",
  "ERROR: Banco de dados indisponível",
  "ERROR: Timeout na API externa",
  "INFO: Processo finalizado"
]
IO.inspect LogParser.primeiros_erros(logs, 2)
