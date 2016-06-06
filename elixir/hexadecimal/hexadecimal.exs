defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    cond do
      hex =~ ~r/\A[0-9a-fA-F]+\z/ -> aux(hex)
      true -> 0
    end
  end

  def aux(hex) do
    hex
    |> String.graphemes
    |> Enum.reverse
    |> Stream.with_index
    |> Stream.map(fn {g, i} ->
      p = :math.pow(16, i)
      <<val::utf8>> = g
      cond do
        val <= ?9 -> p * (val - ?0)
        val <= ?F -> p * (val - ?A + 10)
        val <= ?f -> p * (val - ?a + 10)
      end
    end)
    |> Enum.sum
  end
end
