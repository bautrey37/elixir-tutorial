defmodule Servy.FourOhFourCounter do
  @name :four_oh_four_counter

  use GenServer

  # Client Interface

  def start_link(_args)do
    IO.puts("Starting the 404 counter...")
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def bump_count(path) do
    GenServer.call(@name, {:bump_count, path})
  end

  def get_count(path) do
    GenServer.call(@name, {:get_count, path})
  end

  def get_counts do
    GenServer.call(@name, :get_counts)
  end

  def reset do
    GenServer.cast(@name, :reset)
  end

  # Server Callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:bump_count, path}, _from, state) do
    new_state = Map.update(state, path, 1, fn value -> value + 1 end)
    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:get_count, path}, _from, state) do
    count = Map.get(state, path)
    {:reply, count, state}
  end

  @impl true
  def handle_call(:get_counts, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:reset, _state) do
    {:noreply, %{}}
  end

  @impl true
  def handle_info(message, state) do
    IO.puts("Can't touch this! #{inspect(message)}")
    {:noreply, state}
  end
end
