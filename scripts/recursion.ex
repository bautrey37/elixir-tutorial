defmodule Recurse do
  def loopy([head | tail]) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    loopy(tail)
  end

  def loopy([]), do: IO.puts "Done!"

  def sum(list), do: sum(list, 0)
  defp sum([head | tail], sum) do
    IO.puts "Total: #{sum} Head: #{head} Tail: #{inspect(tail)}"
    sum(tail, sum + head)
  end

  defp sum(_, sum), do: IO.puts sum

  def triple([head | tail]) do
    [head*3 | triple(tail)]
  end
  def triple([]), do: []

  def triple_2(list), do: triple_2(list, [])
  defp triple_2([head | tail], list) do
    triple_2(tail, [head*3 | list])
  end
  defp triple_2([], list), do: Enum.reverse(list)


  def my_map(list, func), do: my_map(list, func, [])
  defp my_map([head | tail], func, list) do
    my_map(tail, func, [func.(head) | list])
  end
  defp my_map([], _, list), do: Enum.reverse(list)

  def my_map2([head|tail], fun) do
    [fun.(head) | my_map(tail, fun)]
  end

  def my_map2([], _fun), do: []
end

Recurse.loopy([1, 2, 3, 4, 5])
Recurse.sum([1, 2, 3, 4, 5])
IO.inspect Recurse.triple([1, 2, 3, 4, 5])
IO.inspect Recurse.triple_2([1, 2, 3, 4, 5])

nums = [1, 2, 3, 4, 5]
IO.inspect Recurse.my_map(nums, &(&1 * 2))
IO.inspect Recurse.my_map(nums, &(&1 * 4))
IO.inspect Recurse.my_map(nums, &(&1 * 5))

IO.inspect Recurse.my_map2(nums, &(&1 * 2))
IO.inspect Recurse.my_map2(nums, &(&1 * 4))
IO.inspect Recurse.my_map2(nums, &(&1 * 5))
