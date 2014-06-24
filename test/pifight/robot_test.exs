defmodule Pifight.RobotTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Arena, as: Arena

  test "starting position" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    assert Robot.position(bot) == [200, 200]
  end

  test "move one tick at 90 degrees" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    Robot.tick(bot)
    assert Robot.position(bot) == [202, 200]
  end

  test "reverse direction at arena right edge" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    Robot.tick(bot)
  end

  test "reverse direction at arena left edge" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    tick_until_direction_change(bot)
  end

  def tick_until_direction_change(bot) do
    [x, y] = Robot.position(bot)
    tick_until_direction_change(bot, x, y)
  end

  def tick_until_direction_change(bot, prevx, prevy) do
    Robot.tick(bot)
    [x, y] = Robot.position(bot)
    assert y == prevy
    assert x <= Arena.max_x
    if x < prevx do
      true
    else
      tick_until_direction_change(bot, x, y)
    end
  end



  # SOHCAHTOA
  # cos(t) = a/h
  # a = cos(t)*h

  # sin(t) = o/h
  # o = sin(t) * h
end
