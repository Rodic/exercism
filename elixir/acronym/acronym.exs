defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """

  import String, only: [upcase: 1]

  @spec abbreviate(String.t) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/[A-Z]|(?<=\s)[a-z]/, string)
    |> Enum.reduce("", fn([letter|[]], acc) -> acc <> upcase(letter) end)
  end
end
