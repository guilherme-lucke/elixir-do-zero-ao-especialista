defmodule Crawler do
  def buscar_titulos(urls) do
    coordenador_pid = self()
    num_urls = length(urls)

    # Não precisamos mais das referências para esta lógica simples
    Enum.each(urls, fn url ->
      spawn(fn -> buscar_titulo_de_uma_url(coordenador_pid, url) end)
    end)

    IO.puts("Iniciando busca em #{num_urls} URLs...")
    # Passamos o número de respostas que esperamos e um mapa vazio.
    esperar_respostas(num_urls, %{})
  end

  # Caso base: quando o número de respostas a esperar chega a zero, retornamos o mapa.
  defp esperar_respostas(0, resultados), do: resultados

  # Loop recursivo: esperamos por N respostas.
  defp esperar_respostas(respostas_restantes, resultados) do
    receive do
      # Recebemos um resultado, o adicionamos ao mapa e decrementamos o contador.
      {:resultado, url, resultado} ->
        novo_mapa = Map.put(resultados, url, resultado)
        esperar_respostas(respostas_restantes - 1, novo_mapa)
    after
      10000 ->
        IO.puts("AVISO: Timeout! Retornando #{map_size(resultados)} resultados de #{respostas_restantes + map_size(resultados)}.")
        resultados
    end
  end

  defp buscar_titulo_de_uma_url(coordenador_pid, url) do
    # ... (esta função permanece igual à versão corrigida acima)
    case HTTPoison.get(url, [], [timeout: 8000, recv_timeout: 8000]) do
      {:ok, %{status_code: 200, body: body}} ->
        titulo = extrair_titulo(body)
        send(coordenador_pid, {:resultado, url, {:ok, titulo}})
      {:error, %{reason: reason}} ->
        send(coordenador_pid, {:resultado, url, {:error, reason}})
      {:ok, %{status_code: code}} ->
        send(coordenador_pid, {:resultado, url, {:error, "HTTP Status #{code}"}})
    end
  end

  # Usando a versão correta e moderna da floki
  defp extrair_titulo(html_body) do
    case Floki.parse_document(html_body) do
      {:ok, document} ->
        document
        |> Floki.find("title")
        |> Floki.text()
        |> String.trim()
      # Se o HTML for inválido, retornamos uma mensagem de erro.
      {:error, _reason} ->
        "Erro ao parsear o documento HTML"
    end
  end
end
