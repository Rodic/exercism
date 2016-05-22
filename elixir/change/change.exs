defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    aux(amount, values, Enum.into(values, %{}, &{&1, 0}) )
  end

  defp aux(0, _values, wallet),   do: {:ok, wallet}
  defp aux(_amount, [], _wallet), do: :error
  defp aux(amount, _values, _wallet) when amount < 0, do: :error
  defp aux(amount, values=[val|values_], wallet) do
    [
      # Skip coin
      aux(amount, values_, wallet),

      # Take coin and remove it
      aux(amount-val, values_, Map.update(wallet, val, 1, &(&1 + 1))),

      # Take coin and leave it so it can be picked again
      aux(amount-val, values, Map.update(wallet, val, 1, &(&1 + 1)))
    ]
    |> Enum.reject(&(&1 == :error))
    |> min_or_error_if_empty
  end

  defp min_or_error_if_empty([]), do: :error
  defp min_or_error_if_empty(wallets) do
    wallets
    |> Enum.min_by(&coins_sum/1)
  end

  defp coins_sum({:ok, wallet}) do
    wallet
    |> Enum.reduce(0, fn {coin, count}, acc -> acc + count end)
  end
end
