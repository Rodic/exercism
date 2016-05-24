defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  def new do
    %Queens{black: {7, 3}, white: {0, 3}}
  end

  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(coords, coords), do: raise ArgumentError
  def new(white, black) do
    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for row <- 0..7, col <- 0..7, into: "" do
      construct_field(row, col, queens) |> adjust_spacing(row, col)
    end
  end

  defp construct_field(row, col, %{white: {row, col}}), do: "W"
  defp construct_field(row, col, %{black: {row, col}}), do: "B"
  defp construct_field(_, _, _), do: "_"

  defp adjust_spacing(field, row, col) when row == 7 and col == 7, do: field
  defp adjust_spacing(field, _,   col) when col == 7, do: "#{field}\n"
  defp adjust_spacing(field, _, _ ), do: "#{field} "

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{white: {x1, y1}, black: {x2, y2}})  do
    x1 == x2 or y1 == y2 or abs(x1-x2) == abs(y1-y2)
  end
end
