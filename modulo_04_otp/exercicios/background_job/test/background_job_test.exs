defmodule BackgroundJobTest do
  use ExUnit.Case
  doctest BackgroundJob

  test "greets the world" do
    assert BackgroundJob.hello() == :world
  end
end
