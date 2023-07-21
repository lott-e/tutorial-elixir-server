defmodule ServurTest do
  use ExUnit.Case
  doctest Servur

  test "greets the world" do
    assert Servur.hello() == :world
  end
end
