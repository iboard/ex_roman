defmodule RomanTest do
  use ExUnit.Case
  doctest Roman

  test "Simple cases" do
    assert 1 == Roman.to_decimal("I")
    assert 5 == Roman.to_decimal("V")

    assert 2 == Roman.to_decimal("II")
    assert 3 == Roman.to_decimal("III")
  end

  test "Combined cases" do
    assert 6 == Roman.to_decimal("VI")
    assert 4 == Roman.to_decimal("IV")

    assert 1660 == Roman.to_decimal("MDCLX")
  end
end
