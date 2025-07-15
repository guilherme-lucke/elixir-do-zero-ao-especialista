defmodule AnalisadorTest do
  use ExUnit.Case
  doctest Analisador

  test "greets the world" do
    assert Analisador.hello() == :world
  end
end
