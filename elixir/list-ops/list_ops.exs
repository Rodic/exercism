defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn _, acc -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], fn x, acc -> [x | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    reduce(l, [], fn x, acc -> [f.(x) | acc] end)
    |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce(l, [], fn x, acc -> if f.(x), do: [x | acc], else: acc end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([x|xs], acc, f) do
    reduce(xs, f.(x, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(reverse(a), b, fn x, acc -> [x | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(xss) do
    # can reuse append but it's too slow
    # reduce(xss, [], &append(&2, &1))

    reduce(xss, [], fn xs, acc -> reduce(xs, acc, fn x, _acc -> [x|_acc] end) end)
    |> reverse
  end
end
