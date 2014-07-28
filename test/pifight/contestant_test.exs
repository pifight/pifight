defmodule Pifight.ContestantTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Arena, as: Arena

  test "reverse direction at arena right edge" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    tick_until_heads_left(bot)
  end

  test "reverse direction at arena left edge" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: -2, heading: 90})
    tick_until_heads_right(bot)
  end

  def tick_until_heads_left(bot) do
    [x, y] = Robot.position(bot)
    lt = &(&1 < &2)
    tick_until_direction_change(bot, lt, x, y)
  end

  def tick_until_heads_right(bot) do
    [x, y] = Robot.position(bot)
    gt = &(&1 > &2)
    tick_until_direction_change(bot, gt, x, y)
  end

  def tick_until_direction_change(bot, comparitor, prevx, prevy) do
    Robot.tick(bot)
    [x, y] = Robot.position(bot)
    assert y == prevy
    assert x <= Arena.max_x
    assert x >= Arena.min_x
    if comparitor.(x, prevx) do
      true
    else
      tick_until_direction_change(bot, comparitor, x, y)
    end
  end
end
