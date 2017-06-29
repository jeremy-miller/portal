defmodule PortalDoorTest do
  use ExUnit.Case, async: true

  alias Portal.Door

  setup do
    {:ok, pid} = Agent.start_link(fn -> [] end)
    {:ok, [pid: pid]}
  end

  test "start_link/1 returns named PID" do
    assert {:ok, pid} = Door.start_link(:orange)
    assert Process.info(pid, :registered_name) == {:registered_name, :orange}
  end

  test "get/1 retrieves door data", %{pid: pid} do
    data = 0
    Agent.update(pid, fn list -> [data|list] end)
    assert Door.get(pid) == [data]
  end

  test "push/2 adds data to door", %{pid: pid} do
    data = 0
    assert Door.push(pid, data) == :ok
    assert Agent.get(pid, fn list -> list end) == [0]
  end

  test "pop/1 removes and returns one item from door", %{pid: pid} do
    Agent.update(pid, fn list -> [0, 1] ++ list end)
    assert Door.pop(pid) == {:ok, 0}
    assert Agent.get(pid, fn list -> list end) == [1]
  end
end
