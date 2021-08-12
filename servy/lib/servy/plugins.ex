require Logger

defmodule Servy.Plugins do
  def rewrite_path(%{path: path} = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(conv, nil), do: conv

  def log(conv), do: IO.inspect(conv)

  @doc "Logs 404 request"
  def track(%{status: 404, path: path} = conv) do
    Logger.warning("#{path} is on the loose!")
    conv
  end

  def track(conv), do: conv
end
