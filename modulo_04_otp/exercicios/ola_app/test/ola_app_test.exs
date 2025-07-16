defmodule OlaAppTest do
  use ExUnit.Case
  doctest OlaApp

  test "greets the world" do
    assert OlaApp.hello() == :world
  end
end
