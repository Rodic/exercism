defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  import String, only: [split: 3, duplicate: 2, to_integer: 1]

  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> split("", trim: true)
    |> Enum.reduce([], &reducer/2)
    |> Enum.map(fn {count, letter} -> "#{count}#{letter}" end)
    |> Enum.reverse
    |> Enum.join
  end

  defp reducer(letter, [{count, letter}|rest]) do
    [{count + 1, letter}|rest]
  end

  defp reducer(letter, acc) do
    [{1, letter}|acc]
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/(\d+)(\w)/, string)
    |> Enum.map(
      fn [_, count, letter] ->
        duplicate(letter, to_integer(count))
      end)
    |> Enum.join
  end
end
