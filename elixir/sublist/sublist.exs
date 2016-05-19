defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(xs, xs), do: :equal
  def compare(xs, ys) do
    cond do
      sublist?(xs, ys) -> :sublist
      sublist?(ys, xs) -> :superlist
      true -> :unequal
    end
  end

  @doc """
  Returns true if the first list is sublist of the second
  """
  @spec sublist?(List.t, List.t) :: Boolean.t
  defp sublist?(_, []), do: false
  defp sublist?(xs, ys = [_|ys_]) do
    begins_with?(ys, xs) or sublist?(xs, ys_)
  end

  @doc """
  Returns true if first list begins with the second
  """
  @spec begins_with?(List.t, List.t) :: Boolean.t
  defp begins_with?(_, []), do: true
  defp begins_with?([x|xs], [x|ys]), do: begins_with?(xs, ys)
  defp begins_with?(_, _), do: false
end
