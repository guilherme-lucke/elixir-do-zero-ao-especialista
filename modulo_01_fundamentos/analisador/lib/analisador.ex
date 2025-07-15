defmodule Analisador do
  @moduledoc """
  Ferramenta para analisar a frequência de palavras em um arquivo de texto.
  """

  @doc """
  Ferramenta para analisar a frequência de palavras em um arquivo de texto.
  """
  def processar(caminho_do_arquivo) do
    IO.puts("Analisando o arquivo: #{caminho_do_arquivo}")
    IO.puts("--- Top 10 palavras mais comuns ---")

    # Aqui virá a nossa lógica principal, usando o operador pipe
    caminho_do_arquivo
    |> ler_arquivo()
    |> contar_palavras()
    |> ordenar_e_selecionar(10)
    |> formatar_saida()
  end

   defp ler_arquivo(caminho) do
    case File.read(caminho) do
      # Pattern matching em caso de sucesso!
      {:ok, conteudo} ->
        conteudo

      # Pattern matching em caso de erro.
      {:error, motivo} ->
        # Por enquanto, vamos apenas exibir o erro e parar.
        # :halt para a execução.
        IO.puts("Erro ao ler o arquivo: #{:file.format_error(motivo)}")
        :halt
    end
  end

  defp contar_palavras(texto) do
    texto
    |> String.downcase() # 1. Padroniza para minúsculas
    |> String.split(~r/[ \n\r\t,.]/, trim: true) # 2. Divide em palavras, removendo pontuação básica
    |> Enum.frequencies() # 3. A mágica acontece aqui! Conta a frequência de cada item.
  end

  defp ordenar_e_selecionar(mapa_de_frequencias, quantidade) do
    mapa_de_frequencias
    |> Enum.sort_by(fn {_palavra, contagem} -> contagem end, :desc) # Ordena pela contagem, decrescente
    |> Enum.take(quantidade) # Pega os N primeiros da lista ordenada
  end

  defp formatar_saida(lista_de_resultados) do
    lista_de_resultados
    |> Enum.with_index() # Adiciona o índice a cada elemento.
    |> Enum.each(fn {{palavra, contagem}, index} ->
      IO.puts("#{index + 1}. #{palavra}: #{contagem} vezes")
    end)
  end

end
