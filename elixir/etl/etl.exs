defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  import String, only: [downcase: 1]

  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(
      %{},
      fn {key, vals}, reversed_map ->
        Enum.reduce(
          vals,
          reversed_map,
          fn val, acc -> Map.put(acc, downcase(val), key) end
        )
      end
    )
  end
end
