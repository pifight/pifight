defmodule Pifight.RobotTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Arena, as: Arena
  alias Pifight.Contestant, as: Contestant

  test "starting position" do
    {:ok, contestant} = Contestant.start
    {:ok, bot} = Robot.start(%{x: 200, y: 200, contestant: contestant})
    assert Robot.position(bot) == [200, 200]
  end

  test "move one tick at 90 degrees" do
    {:ok, contestant} = Contestant.start
    {:ok, bot} = Robot.start(%{x: 200, y: 200, contestant: contestant})
    Robot.move(bot, %{speed: 2, heading: 90})
    Robot.tick(bot)
    assert Robot.position(bot) == [203, 200]
  end

  test "detect collisions with arena edges" do
    assert Robot.detect_collision(200, 200) == {:ok, 200, 200}
    assert Robot.detect_collision(Arena.max_x + 1, 200) == {:boom, Arena.max_x, 200}
    assert Robot.detect_collision(Arena.min_x - 1, 200) == {:boom, Arena.min_x, 200}
  end

  test "update position based on speed" do
    state = %{speed: 2, heading: 0, x: 0, y: 0}
    expected_x = 2 * Arena.speed_scale

    assert Robot.update_position(state) == Map.put(state, :x, expected_x)
  end


  # SOHCAHTOA
  # cos(t) = a/h
  # a = cos(t)*h

  # sin(t) = o/h
  # o = sin(t) * h
end
