defmodule LeitorProcessadorTest do
  use ExUnit.Case
  doctest LeitorProcessador

  test "greets the world" do
    assert LeitorProcessador.hello() == :world
  end
end
