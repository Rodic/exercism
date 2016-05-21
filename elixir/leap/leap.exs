defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    div_with_4?(year) and (not div_with_100?(year) or div_with_400?(year))
  end

  defp div_with(x) do
    fn y -> rem(y, x) == 0 end
  end

  defp div_with_4?(x),   do: div_with(4).(x)
  defp div_with_100?(x), do: div_with(100).(x)
  defp div_with_400?(x), do: div_with(400).(x)
end
