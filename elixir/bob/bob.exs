defmodule Bob do
  def hey(input) do
    cond do
      input =~ ~r/\A.*\?\z/ -> "Sure."
      input =~ ~r/\A\s*\z/  -> "Fine. Be that way!"
      input =~ ~r/\A(\d*[\p{Lu}\W\s]+)+\z/u -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
