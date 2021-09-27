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
end

Recurse.loopy([1, 2, 3, 4, 5])
Recurse.sum([1, 2, 3, 4, 5])
IO.inspect Recurse.triple([1, 2, 3, 4, 5])
IO.inspect Recurse.triple_2([1, 2, 3, 4, 5])
