defmodule Matematica do
  def fibonacci(n) do
    # `unfold` recebe o estado inicial e a função geradora.
    stream_infinito = Stream.unfold({0, 1}, fn {a, b} ->
      # A tupla que retornamos é {valor_a_emitir, proximo_estado}
      {a, {b, a + b}}
    end)

    # Agora que temos a "receita" infinita, consumimos a parte que queremos.
    stream_infinito |> Enum.take(n)
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> Matematica.fibonacci(10)
# [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
# iex> Matematica.fibonacci(1)
# [0]

IO.inspect Matematica.fibonacci(10)
IO.inspect Matematica.fibonacci(1)
