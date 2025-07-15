defmodule Parser do
  # O alias nos permite escrever `User` em vez de `Parser.User`.
  alias Parser.User

  @doc """
  Faz o parsing de um arquivo CSV, transformando-o em uma lista de structs User.
  """
  def parse(caminho_do_arquivo) do
    # 1. Abre o arquivo como um Stream, que lê linha por linha (lazy).
    #    `File.stream!/1` é usado para simplicidade; ele falha ruidosamente
    #    se o arquivo não existir.
    stream_de_linhas = File.stream!(caminho_do_arquivo)

    # 2. Extrai o cabeçalho. `Enum.take(1)` pega a primeira linha.
    #    `hd` pega o primeiro (e único) elemento da lista.
    cabecalho_string = stream_de_linhas |> Enum.take(1) |> hd()
    cabecalho_atomos = parse_cabecalho(cabecalho_string) # Usaremos uma função privada

    # 3. Processa o resto do arquivo.
    stream_de_linhas
    |> Stream.drop(1) # Pula a linha do cabeçalho que já lemos.
    |> Stream.map(&parse_linha(&1, cabecalho_atomos)) # Para cada linha, cria um struct.
    |> Enum.to_list() # Finalmente, "materializa" o stream em uma lista.
  end

  defp parse_cabecalho(linha_cabecalho) do
    linha_cabecalho
    |> String.trim() # Remove quebras de linha
    |> String.split(",") # ["id", "nome", "email"]
    |> Enum.map(&String.to_atom/1) # [:id, :nome, :email] <-- Chaves para nosso struct!
  end

  defp parse_linha(linha, cabecalho) do
    # Pega uma linha "1,Ana Silva,ana.silva@exemplo.com"
    # e um cabeçalho `[:id, :nome, :email]`

    valores = linha |> String.trim() |> String.split(",") # ["1", "Ana Silva", ...]

    # Combina o cabeçalho com os valores.
    # Enum.zip([:id, :nome], ["1", "Ana"]) -> [{:id, "1"}, {:nome, "Ana"}]
    propriedades = Enum.zip(cabecalho, valores)

    # `struct/2` é perfeito para criar um struct a partir de uma lista
    # de tuplas chave-valor (ou um mapa).
    struct(User, propriedades)
  end

end
