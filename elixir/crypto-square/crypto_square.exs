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

    letters_list |> transform(row_length)
  end

  defp transform([], _, _), do: []
  defp transform(letters, row_length) do
    acc = 1..row_length
      |> Enum.into(%{}, &({&1 - 1, []}))

    transform_aux(letters, 0, row_length, acc)
      |> Map.values
      |> Enum.map_join(" ", &(Enum.reverse(&1) |> Enum.join))
  end

  defp transform_aux([], _, _, acc), do: acc
  defp transform_aux([letter|letters], counter, rows_length, acc) do
    index   = rem(counter, rows_length)
    updated = [letter|acc[index]]
    transform_aux(letters, counter+1, rows_length, Map.put(acc, index, updated))
  end

  defp get_row_length(count) do
    1..count
      |> Enum.find(fn row ->
        col = div(count, row) + if rem(count, row) == 0, do: 0, else: 1
        row >= col and row - col <= 1
      end)
  end
end
