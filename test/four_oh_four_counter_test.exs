defmodule FourOhFourCounterTest do
  use ExUnit.Case

  alias Servy.FourOhFourCounter, as: Counter

  setup_all do
    [pid: Counter.start_link([])]
  end

  test "reports counts of missing path requests", _state do
    Counter.bump_count("/bigfoot")
    Counter.bump_count("/nessie")
    Counter.bump_count("/nessie")
    Counter.bump_count("/bigfoot")
    Counter.bump_count("/nessie")

    assert Counter.get_count("/nessie") == 3
    assert Counter.get_count("/bigfoot") == 2

    assert Counter.get_counts() == %{"/bigfoot" => 2, "/nessie" => 3}
  end

  test "reset clears the counts", _state do
    Counter.bump_count("/bigfoot")
    Counter.reset()

    assert Counter.get_counts() == %{}
  end
end
