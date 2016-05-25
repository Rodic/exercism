defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    letters_list = str
      |> String.graphemes
      |> Enum.filter(&(&1 =~ ~r/\w/i))
      |> Enum.map(&String.downcase/1)

    row_length = letters_list |> Enum.count |> get_row_length

    letters_list
      |> inverse(row_length, 0, [])
      |> Enum.map(&Enum.join/1)
      |> Enum.join(" ")
  end

  defp inverse([], _, _, _),  do: []
  defp inverse(_, n, n, acc), do: acc |> Enum.reverse
  defp inverse(ls=[_|ls_], row_length, rows_taken, acc) do
    inverse(ls_, row_length, rows_taken + 1, [Enum.take_every(ls, row_length)|acc])
  end

  defp get_row_length(count) do
    1..count
      |> Enum.find(fn row ->
        col = div(count, row) + if rem(count, row) == 0, do: 0, else: 1
        row >= col and row - col <= 1
      end)
  end
end
