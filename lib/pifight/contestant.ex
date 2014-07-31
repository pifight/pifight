defmodule Pifight.Contestant do
  use ExActor.GenServer
  alias Pifight.Robot, as: Robot

  definit do
    initial_state(%{})
  end

  defcast collision(bot), state: state do
    [speed, heading] = Robot.speed(bot)
    Robot.move(bot, %{speed: -speed, heading: heading})
    new_state(state)
  end

  defcast position, state: state do
  end
end
