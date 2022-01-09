defmodule HttpServerTest do
  use ExUnit.Case

  test "accepts a request on a socket and sends back a response" do
    port = Application.get_env(:servy, :port)

    urls = [
      "http://localhost:#{port}/wildthings",
      "http://localhost:#{port}/sensors",
      "http://localhost:#{port}/bears",
      "http://localhost:#{port}/bears/1",
      "http://localhost:#{port}/api/bears"
    ]

    urls
    |> Enum.map(fn url -> Task.async(fn -> HTTPoison.get(url) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.map(&assert_successful_response/1)
  end

  defp assert_successful_response({:ok, response}) do
    assert response.status_code == 200
  end
end
