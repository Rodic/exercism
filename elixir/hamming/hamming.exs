defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(str1, str2) when length(str1) != length(str2), do: nil

  def hamming_distance(strand1, strand2) do
    Stream.zip(strand1, strand2)
    |> Stream.map(
      fn
        {n, n} -> 0
        {_, _} -> 1
      end)
    |> Enum.sum
  end

end
