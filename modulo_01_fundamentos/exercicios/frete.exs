defmodule Frete do
  def calcular(peso) do
    cond do
      peso <= 1 -> 10.00
      peso <= 5 -> 18.00
      peso <= 10 -> 30.00
      true -> 50.00
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> Frete.calcular(0.5)
# 10.0
# iex> Frete.calcular(5)
# 18.0
# iex> Frete.calcular(12)
# 50.0

IO.puts Frete.calcular(0.5)
IO.puts Frete.calcular(5)
IO.puts Frete.calcular(12)
