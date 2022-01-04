defmodule PledgeServerTest do
  use ExUnit.Case

  import IEx.Helpers

  alias Servy.PledgeServer

  setup_all do
    [pid: PledgeServer.start()]
  end

  test "caches the 3 most recent pledges and totals their amounts", _state do
    PledgeServer.create_pledge("larry", 10)
    PledgeServer.create_pledge("moe", 20)
    PledgeServer.create_pledge("curly", 30)
    PledgeServer.create_pledge("daisy", 40)
    PledgeServer.create_pledge("grace", 50)

    most_recent_pledges = [{"grace", 50}, {"daisy", 40}, {"curly", 30}]

    assert PledgeServer.recent_pledges() == most_recent_pledges

    assert PledgeServer.total_pledged() == 120

    flush()
  end

  test "does not fail for unexpected atom", state do
    send(state[:pid], {:stop, "hammertime"})

    assert Process.alive?(state[:pid]) == true
  end

  test "clears pledeges" do
    PledgeServer.create_pledge("larry", 10)
    PledgeServer.clear()

    assert PledgeServer.recent_pledges() == []
  end
end