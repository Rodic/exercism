defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    strand
    |> histogram
    |> Map.get(nucleotide)
  end

  def count(_, _), do: raise ArgumentError


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """

  @spec histogram([char]) :: map
  def histogram(strand) do
    strand
    |> Enum.reduce(
      %{?A => 0, ?C => 0, ?G => 0, ?T => 0},
      fn c, acc ->
        try do
          Map.update!(acc, c, &(&1 + 1))
        rescue
          KeyError -> raise ArgumentError
        end
      end
    )
  end
end
