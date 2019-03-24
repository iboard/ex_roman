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
    |> Enum.map(&map_numeral_to_value/1)
    |> sum_numerals()
  end

  defp sum_numerals(numeral_values) when is_list(numeral_values) do
    {sum, _} =
      Enum.reverse(numeral_values)
      # since we traverse the list from the back the previously remembered value is actually the following one
      |> Enum.reduce({0, 0}, fn numeral_value, {sum, following_numeral_value} ->
        new_sum = sum + calculate_new_summand(numeral_value, following_numeral_value)
        {new_sum, numeral_value}
      end)

    sum
  end

  defp to_character_list(str) do
    str
    # splitting by "" returns additional "" at begin and end
    |> String.split("")
    # remove additional ""
    |> Enum.slice(1..-2)
  end

  # In the case of decreasing order of numerals the numerals are just added.
  defp calculate_new_summand(numeral_value, following_numeral_value)
       when numeral_value >= following_numeral_value do
    numeral_value
  end

  # In case a smaller numeral precedes a bigger one, like in 'IV',
  # the smaller numeral is subtracted instead of added.
  defp calculate_new_summand(numeral_value, _following_numeral_value) do
    -numeral_value
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
