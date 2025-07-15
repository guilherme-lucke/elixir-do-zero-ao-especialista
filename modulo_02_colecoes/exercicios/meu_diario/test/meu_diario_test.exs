defmodule MeuDiarioTest do
  use ExUnit.Case
  doctest MeuDiario

  test "o projeto funciona" do
    assert MeuDiario.hello() == :world # <-- TESTE CORRIGIDO
  end
end
