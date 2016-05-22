defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  use Bitwise

  @spec square(pos_integer) :: pos_integer
  def square(number) do
    1 <<< number - 1
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    (1 <<< 64) - 1 # Using property 2^n = sum of(2^n-1...2^0) + 1
                   # Example: 2^3 = 2^2 + 2^1 + 2^0 + 1
  end
end
