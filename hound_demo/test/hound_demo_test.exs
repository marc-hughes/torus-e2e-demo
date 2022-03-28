defmodule HoundDemoTest do
  use ExUnit.Case
  doctest HoundDemo

  test "greets the world" do
    assert HoundDemo.hello() == :world
  end
end
