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
    updated_state = update_position(state)
    new_x = updated_state.x
    new_speed = state.speed
    case detect_collision(new_x, state.y) do
      {:ok, new_x, _} ->
        1
      {:boom, a, _} ->
        new_x = a
        new_speed = -state.speed
    end

    state |>
    Map.put(:x, new_x) |>
    Map.put(:speed, new_speed) |>
    new_state
  end

  def update_position(state) do
    new_x = state.x + (state.speed * Arena.speed_scale)
    state |> Map.put(:x, new_x)
  end

  def detect_collision(x, y) do
    new_x = x
    collision = :ok
    if new_x > Arena.max_x do
      collision = :boom
      new_x = Arena.max_x
    end
    if new_x < Arena.min_x do
      new_x = Arena.min_x
      collision = :boom
    end

    { collision, new_x, y }
  end
end
