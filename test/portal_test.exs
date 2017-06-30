defmodule PortalTest do
  use ExUnit.Case, async: true

  test "create/1 creates Portal door" do
    color = :blue
    {:ok, pid} = Portal.create(color)
    assert Process.info(pid, :registered_name) == {:registered_name, color}
    children = Supervisor.which_children(Portal.Supervisor)
    assert Enum.member?(children, {:undefined, pid, :worker, [Portal.Door]}) == true
  end

  test "setup/3 creates Portal with two doors and initial data" do
    left_door = :green
    right_door = :red
    data = [1, 2, 3]
    Supervisor.start_child(Portal.Supervisor, [left_door])
    Supervisor.start_child(Portal.Supervisor, [right_door])
    assert Portal.setup(left_door, right_door, data) == %Portal{left: left_door, right: right_door}
  end

  test "push_data/2 pushes to right" do
    left_door = :yellow
    right_door = :purple
    data = [1, 2, 3]
    Supervisor.start_child(Portal.Supervisor, [left_door])
    Supervisor.start_child(Portal.Supervisor, [right_door])
    portal = Portal.setup(left_door, right_door, data)
    assert Inspect.inspect(Portal.push_data(portal, :right), nil) == "\n  :yellow <=> :purple\n   [1, 2] <=> [3]\n"
  end

  test "push_data/2 pushes to left" do
    left_door = :black
    right_door = :white
    data = [1, 2, 3]
    Supervisor.start_child(Portal.Supervisor, [left_door])
    Supervisor.start_child(Portal.Supervisor, [right_door])
    portal = Portal.setup(left_door, right_door, data)
    assert Inspect.inspect(Portal.push_data(portal, :left), nil) == "\n     :black <=> :white\n  [1, 2, 3] <=> []\n"
  end

  test "push_data/2 returns error with invalid direction" do
    left_door = :grey
    right_door = :teal
    data = [1, 2, 3]
    Supervisor.start_child(Portal.Supervisor, [left_door])
    Supervisor.start_child(Portal.Supervisor, [right_door])
    portal = Portal.setup(left_door, right_door, data)
    assert_raise ArgumentError, "Invalid direction: up", fn -> Portal.push_data(portal, :up) end
  end
end
