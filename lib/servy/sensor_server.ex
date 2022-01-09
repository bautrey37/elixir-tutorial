defmodule Servy.SensorServer do
  @name :sensor_server

  use GenServer

  defmodule State do
    defstruct sensor_data: %{}, refresh_interval: :timer.minutes(69)
  end

  # Client Interface

  def start_link(interval) do
    IO.puts("Starting the sensor server with #{interval} min refresh...")

    GenServer.start_link(__MODULE__, %State{refresh_interval: :timer.minutes(interval)},
      name: @name
    )
  end

  def get_sensor_data do
    GenServer.call(@name, :get_sensor_data)
  end

  def set_refresh_interval(time_in_ms) do
    GenServer.cast(@name, {:set_refresh_interval, time_in_ms})
  end

  # Server Callbacks

  @impl true
  def init(state) do
    sensor_data = run_tasks_to_get_sensor_data()
    initial_state = %{state | sensor_data: sensor_data}
    schedule_refresh(initial_state)
    {:ok, initial_state}
  end

  @impl true
  def handle_info(:refresh, state) do
    IO.puts("Refreshing the cache...")
    sensor_data = run_tasks_to_get_sensor_data()
    new_state = %{state | sensor_data: sensor_data}
    schedule_refresh(new_state)
    {:noreply, new_state}
  end

  @impl true
  def handle_info(unexpected, state) do
    IO.puts("Can't touch this! #{inspect(unexpected)}")
    {:noreply, state}
  end

  defp schedule_refresh(state) do
    Process.send_after(self(), :refresh, state.refresh_interval)
  end

  @impl true
  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state.sensor_data, state}
  end

  @impl true
  def handle_cast({:set_refresh_interval, time}, state) do
    new_state = %{state | refresh_interval: time}
    schedule_refresh(new_state)
    {:noreply, new_state}
  end

  defp run_tasks_to_get_sensor_data do
    IO.puts("Running tasks to get sensor data...")

    task = Task.async(fn -> Servy.Tracker.get_location("bigfoot") end)

    snapshots =
      ["cam-1", "cam-2", "cam-3"]
      |> Enum.map(&Task.async(fn -> Servy.VideoCam.get_snapshot(&1) end))
      |> Enum.map(&Task.await/1)

    where_is_bigfoot = Task.await(task)

    %{snapshots: snapshots, location: where_is_bigfoot}
  end
end
