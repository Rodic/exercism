defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    nums_count  = number |> String.length
    double_even = rem(nums_count, 2) == 0

    number
      |> String.graphemes
      |> Enum.with_index
      |> Enum.reduce(0, fn {n, i}, acc ->
        num = String.to_integer(n)
        acc + if should_double?(i, double_even), do: double_num(num), else: num
      end)
  end

  defp should_double?(i, double_even) do
    r = rem(i, 2)
    (double_even && r == 0) or (!double_even && r == 1)
  end

  defp double_num(n), do: 2 * n - if n > 5, do: 9, else: 0

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
      |> checksum
      |> rem(10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    0..9
      |> Enum.find_value(fn n ->
        appended = "#{number}#{n}"
        if appended |> valid?, do: appended
      end)
  end
end
