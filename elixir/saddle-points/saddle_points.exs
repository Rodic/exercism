defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str |> matrix |> get_rows
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str |> matrix |> get_cols
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    mtx = str |> matrix
    mtx
    |> Enum.reduce([], fn pt={row, col, val}, acc ->
      if saddle_point?(mtx, pt), do: [{row, col}|acc], else: acc
    end)
    |> Enum.sort
  end

  defp saddle_point?(matrix, {row, col, val}) do
    !Enum.any?(matrix, fn {r, c, v} ->
      (r == row and v > val) or (c == col and v < val)
    end)
  end

  defp matrix(str) do
    rows_length = str |> String.split("\n") |> hd |> String.split(" ") |> Enum.count
    str
    |> String.split(["\n", " "])
    |> Enum.with_index
    |> Enum.map(fn {n, i} ->
      { div(i, rows_length), rem(i, rows_length), String.to_integer(n)}
    end)
  end

  defp get_rows(matrix) do
    matrix
    |> Enum.chunk_by(fn {r, _, _} -> r end)
    |> Enum.map(fn row -> Enum.map(row, fn {_, _, val} -> val end) end)
  end

  defp get_cols(matrix) do
    matrix
    |> Enum.sort(fn {_, c1, _}, {_, c2, _} -> c1 < c2 end)
    |> Enum.chunk_by(fn {_, c, _} -> c end)
    |> Enum.map(fn col ->
      col
      |> Enum.reduce([], fn {_, _, val}, acc -> [val|acc] end)
    end)
  end
end
