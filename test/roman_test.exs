defmodule RomanTest do
  use ExUnit.Case
  doctest RomanNumerals

  test "Simple cases" do
    assert 1 == RomanNumerals.to_integer("I")
    assert 5 == RomanNumerals.to_integer("V")

    assert 2 == RomanNumerals.to_integer("II")
    assert 3 == RomanNumerals.to_integer("III")
  end

  test "Combined cases" do
    assert 6 == RomanNumerals.to_integer("VI")
    assert 4 == RomanNumerals.to_integer("IV")

    assert 1660 == RomanNumerals.to_integer("MDCLX")
  end
end
