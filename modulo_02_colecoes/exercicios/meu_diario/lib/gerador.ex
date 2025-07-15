defmodule Gerador do
  @doc "Gera um novo ID único usando a biblioteca NanoID."
  def novo_id do
    # Chamamos a função da dependência que baixamos
    Nanoid.generate()
  end
end
