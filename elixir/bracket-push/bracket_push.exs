defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    Regex.scan(~r/[][)(}{]/, str)
    |> List.flatten
    |> aux([])
  end

  def aux([], []), do: true
  def aux([],  _), do: false
  def aux(["}"|brackets], ["{"|stack]), do: aux(brackets, stack)
  def aux(["}"|brackets], [ _ |stack]), do: false
  def aux([")"|brackets], ["("|stack]), do: aux(brackets, stack)
  def aux([")"|brackets], [ _ |stack]), do: false
  def aux(["]"|brackets], ["["|stack]), do: aux(brackets, stack)
  def aux(["]"|brackets], [ _ |stack]), do: false
  def aux([bracket|brackets], stack),   do: aux(brackets, [bracket|stack])
end
