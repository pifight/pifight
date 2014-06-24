defmodule Pifight.Robot do
  use ExActor.GenServer
  alias Pifight.Arena, as: Arena

  definit arg do
    arg |> Map.merge(%{speed: 0, heading: 0}) |> initial_state
  end

  defcall position, state: state, do: reply([state.x, state.y])

  defcast move(%{speed: speed, heading: heading}), state: state do
    state |> Map.merge(%{speed: speed, heading: heading}) |> new_state
  end

  defcast tick, state: state do
    new_x = state.x + state.speed
    new_speed = state.speed
    if new_x > Arena.max_x do
      new_x = Arena.max_x
      new_speed= -state.speed
    end
    state |>
    Map.put(:x, new_x) |>
    Map.put(:speed, new_speed) |>
    new_state
  end
end
