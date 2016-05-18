defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  import String, only: [downcase: 1]

  @spec count(String.t) :: map
  def count(sentence) do
    Regex.scan(~r/[\p{L}0-9-]+/u, sentence)
    |> Enum.reduce(
      Map.new,
      fn([word|[]], acc) ->
        Map.update(acc, downcase(word), 1, &(&1 + 1))
      end)
  end
end
