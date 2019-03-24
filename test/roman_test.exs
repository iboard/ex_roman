defmodule RomanTest do
  use ExUnit.Case
  doctest Roman

  test "Simple cases" do
    assert 1 == Roman.to_integer("I")
    assert 5 == Roman.to_integer("V")

    assert 2 == Roman.to_integer("II")
    assert 3 == Roman.to_integer("III")
  end

  test "Combined cases" do
    assert 6 == Roman.to_integer("VI")
    assert 4 == Roman.to_integer("IV")

    assert 1660 == Roman.to_integer("MDCLX")
  end
end
