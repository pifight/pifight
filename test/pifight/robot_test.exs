defmodule Pifight.RobotTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot

  test "starting position" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    assert Robot.position(bot) == [200, 200]
  end

  test "move one tick at 90 degrees" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    Robot.tick(bot)
    assert Robot.position(bot) == [201, 200]
  end

  # SOHCAHTOA
  # cos(t) = a/h
  # a = cos(t)*h

  # sin(t) = o/h
  # o = sin(t) * h
end
