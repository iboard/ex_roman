defmodule Roman do
  @doc """
  Convert a String of roman numerals into integer value

  ### Examples: 

      iex> Roman.to_integer("I")
      1

      iex> Roman.to_integer("III")
      3

      iex> Roman.to_integer("iV")
      ** (RuntimeError) Invalid Roman numeral 'i'

      iex> Roman.to_integer("IV")
      4
  """

  def to_integer(roman_str) when is_binary(roman_str) do
    roman_str
    |> to_character_list()
    |> Enum.map(&map_char_to_value/1)
    |> sum_digits()
  end

  defp sum_digits(roman_chars) when is_list(roman_chars) do
    {sum, _} =
      Enum.reverse(roman_chars)
      |> Enum.reduce({0, 0}, fn digit, {sum, last_digit} ->
        new_sum = sum + calculate_new_summand(last_digit, digit)
        {new_sum, digit}
      end)

    sum
  end

  defp to_character_list(str) do
    str
    # returns additional "" at begin and end
    |> String.split("")
    # remove additional ""
    |> Enum.slice(1..-2)
  end

  defp calculate_new_summand(last_digit, digit) when last_digit <= digit do
    digit
  end

  defp calculate_new_summand(_last_digit, digit), do: -digit

  defp map_char_to_value("I"), do: 1
  defp map_char_to_value("V"), do: 5
  defp map_char_to_value("X"), do: 10
  defp map_char_to_value("L"), do: 50
  defp map_char_to_value("C"), do: 100
  defp map_char_to_value("D"), do: 500
  defp map_char_to_value("M"), do: 1000
  defp map_char_to_value(ch), do: raise("Invalid Roman numeral '#{ch}'")
end
