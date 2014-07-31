defmodule Pifight.RobotTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Arena, as: Arena
  alias Pifight.Contestant, as: Contestant

  setup do
    {:ok, contestant} = Contestant.start
    {:ok, bot} = Robot.start(%{x: 200, y: 200, contestant: contestant, label: :bot1})
    {:ok, [bot: bot]}
  end

  test "knows its label", context do
    assert Robot.label(context[:bot]) == :bot1
  end

  test "update_position" do
    %{x: 100.0, y: 95.5} = Robot.update_position(%{x: 100.0, y: 100.0, speed: 3, heading: 0})
    %{x: 104.5, y: 100.0} = Robot.update_position(%{x: 100.0, y: 100.0, speed: 3, heading: 90})
    %{x: 100.0, y: 104.5} = Robot.update_position(%{x: 100.0, y: 100.0, speed: 3, heading: 180})
    %{x: 95.5, y: 100.0} = Robot.update_position(%{x: 100.0, y: 100.0, speed: 3, heading: 270})
  end

  test "starting position", context do
    assert Robot.position(context[:bot]) == [200, 200]
  end

  test "move one tick at 90 degrees", context do
    Robot.move(context[:bot], %{speed: 2, heading: 90})
    Robot.tick(context[:bot])
    assert Robot.position(context[:bot]) == [203, 200]
  end

  test "move one tick at 180 degrees", context do
    Robot.move(context[:bot], %{speed: 2, heading: 180})
    Robot.tick(context[:bot])
    assert Robot.position(context[:bot]) == [200, 203]
  end

  test "detect collisions with arena edges" do
    assert Robot.detect_collision(200, 200) == {:ok, 200, 200}
    assert Robot.detect_collision(Arena.max_x + 1, 200) == {:boom, Arena.max_x, 200}
    assert Robot.detect_collision(Arena.min_x - 1, 200) == {:boom, Arena.min_x, 200}
  end

  test "update position based on speed" do
    state = %{speed: 2, heading: 180, x: 0, y: 0}
    expected_y = 2 * Arena.speed_scale

    assert_bot_near Robot.update_position(state), 0, expected_y
  end

  def assert_bot_near(bot_state, expected_x, expected_y) do
    %{x: actual_x, y: actual_y} = bot_state
    delta = bot_state.speed * Arena.speed_scale / 100
    assert_in_delta actual_x, expected_x, delta
    assert_in_delta actual_y, expected_y, delta
  end

  # SOHCAHTOA
  # cos(t) = a/h
  # a = cos(t)*h

  # sin(t) = o/h
  # o = sin(t) * h
end
