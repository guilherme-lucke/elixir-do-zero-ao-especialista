defmodule Relatorios do
  def calcular_faturamento_premium(vendas) do
    vendas
    |> Enum.filter(fn venda -> venda.status == :aprovada and venda.valor > 100 end)
    |> Enum.map(fn venda -> venda.valor end)
    |> Enum.sum()
  end
end

# --- Área de Testes ---

# Dados para teste:
lista_de_vendas = [
  %{id: 1, valor: 150.00, status: :aprovada},
  %{id: 2, valor: 80.00, status: :aprovada},
  %{id: 3, valor: 250.00, status: :pendente}, # Status não bate
  %{id: 4, valor: 500.50, status: :aprovada},
  %{id: 5, valor: 99.90, status: :aprovada}   # Valor não é premium
]

# Para testar no iex:
# iex> Relatorios.calcular_faturamento_premium(lista_de_vendas)
# 650.5
# (Soma de 150.00 + 500.50)

IO.inspect Relatorios.calcular_faturamento_premium(lista_de_vendas)
