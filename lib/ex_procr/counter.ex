defmodule Counter do
  def init(seed) do
    {:ok, pid} = Agent.start_link(fn -> seed end)
    pid
  end

  def val(pid) do
    Agent.get(pid, fn count -> count end)
  end

  def inc(pid) do
    Agent.update(pid, fn count -> count + 1 end)
  end

  def dec(pid) do
    Agent.update(pid, fn count -> count - 1 end)
  end
end
