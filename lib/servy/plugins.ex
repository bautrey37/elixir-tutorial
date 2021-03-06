require Logger

defmodule Servy.Plugins do
  alias Servy.Conv
  alias Servy.FourOhFourCounter, as: Counter

  def rewrite_path(%Conv{path: path} = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(%Conv{} = conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(%Conv{} = conv, nil), do: conv

  def log(%Conv{} = conv) do
    if Mix.env() == :dev do
      IO.inspect(conv)
    end

    conv
  end

  @doc "Logs 404 request"
  def track(%Conv{status: 404, path: path} = conv) do
    if Mix.env() != :test do
      Logger.warning("#{path} is on the loose!")
      Counter.bump_count(path)
    end

    conv
  end

  def track(%Conv{} = conv), do: conv
end
