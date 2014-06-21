defmodule Pifight.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :pifight
  get "/", Pifight.Controllers.Pages, :index, as: :page
end
