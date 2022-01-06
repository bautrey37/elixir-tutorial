defmodule Servy.MixProject do
  use Mix.Project

  def project do
    [
      app: :servy,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 5.0"},
      {:earmark, "~> 1.4"},
      {:httpoison, "~> 1.8"}
    ]
  end

  defp aliases do
    [
      start: [
        "run -e \"Servy.FourOhFourCounter.start()\"",
        "run -e \"Servy.PledgeServer.start()\"",
        "run -e \"Servy.HttpServer.start(4000)\""
      ]
    ]
  end
end
