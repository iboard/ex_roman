defmodule RomanNumerals do
  @doc """
  Convert a String of Roman numerals into its corresponding integer value

  ### Examples: 

      iex> RomanNumerals.to_integer("I")
      1

      iex> RomanNumerals.to_integer("III")
      3

      iex> RomanNumerals.to_integer("iV")
      ** (RuntimeError) Invalid Roman numeral 'i'

      iex> RomanNumerals.to_integer("IV")
      4
  """

  def to_integer(roman_numerals) when is_binary(roman_numerals) do
    roman_numerals
    |> String.split("", trim: true)
    |> Enum.map(&map_numeral_to_value/1)
    |> sum_numerals()
  end

  defp sum_numerals(numeral_values) when is_list(numeral_values) do
    {sum, _} =
      Enum.reverse(numeral_values)
      # since we traverse the list from the back the previously remembered value is actually the following one
      |> Enum.reduce({0, 0}, fn
        # in case of decreasing numerals the values are just added
        numeral_value, {sum, following_numeral_value}
        when numeral_value >= following_numeral_value ->
          {sum + numeral_value, numeral_value}

        # in case of a smaller numeral before a bigger one, like in "IV', the smaller value is subtracted instead of added
        numeral_value, {sum, _following_numeral_value} ->
          {sum - numeral_value, numeral_value}
      end)

    sum
  end

  defp map_numeral_to_value("I"), do: 1
  defp map_numeral_to_value("V"), do: 5
  defp map_numeral_to_value("X"), do: 10
  defp map_numeral_to_value("L"), do: 50
  defp map_numeral_to_value("C"), do: 100
  defp map_numeral_to_value("D"), do: 500
  defp map_numeral_to_value("M"), do: 1000
  defp map_numeral_to_value(ch), do: raise("Invalid Roman numeral '#{ch}'")
end
