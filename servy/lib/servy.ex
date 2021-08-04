defmodule Servy do
  def hello(name) do
    "YO, #{name}"
  end
end

IO.puts Servy.hello("Elixir")
