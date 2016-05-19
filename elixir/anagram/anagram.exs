defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  import String, only: [downcase: 1]

  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    dc_base = downcase(base)
    source = fingerprint(dc_base)
    candidates
    |> Enum.filter(fn candidate ->
      dc_candidate = downcase(candidate)
      dc_candidate != dc_base and fingerprint(dc_candidate) == source
    end)
  end

  def fingerprint(str) do
    str
    |> String.graphemes
    |> Enum.reduce(
      Map.new,
      fn letter, acc -> Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end
end
