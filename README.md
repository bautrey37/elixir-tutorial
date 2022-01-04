# Servy

## Running

In `iex -S mix`:

```
Servy.FourOhFourCounter.start()
Servy.PledgeServer.start()
Servy.HttpServer.start(4000)
```

Or with mix:

```
mix run -e "Servy.FourOhFourCounter.start()"
mix run -e "Servy.PledgeServer.start()"
mix run -e "Servy.HttpServer.start(4000)"
```

Or `mix start`

## API

`curl http://localhost:4000/api/bears`

`curl -H 'Content-Type: application/json' -XPOST http://localhost:4000/api/bears -d '{"name": "Breezly", "type": "Polar"}'`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `servy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:servy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/servy](https://hexdocs.pm/servy).

