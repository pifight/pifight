defmodule Pifight.Robot do
  use ExActor.GenServer
  alias Pifight.Arena, as: Arena
  alias Pifight.Contestant, as: Contestant

  definit arg do
    arg |> Map.merge(%{speed: 0, heading: 0}) |> initial_state
  end

  defcall position, state: state, do: reply([state.x, state.y])

  defcall speed, state: state, do: reply([state.speed, state.heading])

  defcast move(%{speed: speed, heading: heading}), state: state do
    state |> Map.merge(%{speed: speed, heading: heading}) |> new_state
  end

  defcast tick, state: state do
    updated_state = update_position(state)
    new_x = updated_state.x
    new_y = updated_state.y
    new_speed = state.speed
    case detect_collision(new_x, state.y) do
      {:ok, new_x, _} ->
        1
      {:boom, a, _} ->
        new_x = a
        Contestant.collision(state.contestant, self)
    end

    state |>
    Map.put(:x, new_x) |>
    Map.put(:y, new_y) |>
    Map.put(:speed, new_speed) |>
    new_state
  end

  def to_radians(degrees) do
    :math.pi * degrees / 180
  end

  def update_position(state) do
    delta_x = (state.heading |> to_radians |> :math.sin) * state.speed * Arena.speed_scale
    delta_y = (state.heading |> to_radians |> :math.cos) * state.speed * Arena.speed_scale
    new_x = state.x + delta_x
    new_y = state.y - delta_y
    state |> Map.put(:x, new_x) |> Map.put(:y, new_y)
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
