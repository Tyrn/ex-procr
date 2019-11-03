defmodule CounterTest do
  use ExUnit.Case

  test "initial count is zero" do
    pid = Counter.init(0)
    assert Counter.val(pid) == 0
  end

  test "inc adds to the counter" do
    pid = Counter.init(42)
    Counter.inc(pid)
    assert Counter.val(pid) == 43
    Counter.dec(pid)
    assert Counter.val(pid) == 42
  end
end
