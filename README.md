# Servy

## Running

Application is started automatically when running `iex -S mix`

With mix, the application can be started with `mix run` or `mix run --no-halt` to keep the terminal open.

The port the application will open on is configured in the `mix.exs` env setting.

## API

`curl http://localhost:3000/api/bears`

`curl -H 'Content-Type: application/json' -XPOST http://localhost:3000/api/bears -d '{"name": "Breezly", "type": "Polar"}'`



