defmodule Roman do
  @doc """
  Convert a String of roman numbers into decimal value

  ### Examples: 

      iex> Roman.to_decimal("I")
      1

      iex> Roman.to_decimal("III")
      3

      iex> Roman.to_decimal("iV")
      ** (RuntimeError) Invalid character i

      iex> Roman.to_decimal("IV")
      4
  """

  def to_decimal(roman_str) when is_binary(roman_str) do
    roman_str
    |> String.split("", trim: true)
    |> Enum.map(&map_char_to_value/1)
    |> sum_digits()
  end

  defp sum_digits(roman_chars) when is_list(roman_chars) do
    {sum, _} =
      Enum.reverse(roman_chars)
      |> Enum.reduce({0, 0}, fn
        digit, {sum, last_digit} when last_digit <= digit ->
          {sum + digit, digit}

        digit, {sum, _last_digit} ->
          {sum - digit, digit}
      end)

    sum
  end

  defp map_char_to_value("I"), do: 1
  defp map_char_to_value("V"), do: 5
  defp map_char_to_value("X"), do: 10
  defp map_char_to_value("L"), do: 50
  defp map_char_to_value("C"), do: 100
  defp map_char_to_value("D"), do: 500
  defp map_char_to_value("M"), do: 1000
  defp map_char_to_value(ch), do: raise("Invalid character #{ch}")
end
