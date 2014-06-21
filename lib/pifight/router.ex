defmodule Pifight.Router do
  use Phoenix.Router

  get "/roster", Pifight.Controllers.Roster, :index
  get "/bots", Pifight.Controllers.Bots, :index
  plug Plug.Static, at: "/static", from: :pifight
  get "/", Pifight.Controllers.Pages, :index, as: :page
end
