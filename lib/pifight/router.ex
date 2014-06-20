defmodule Pifight.Router do
  use Plug.Router
  import Plug.Conn

  get "/bots/:id" do
    conn |> resp(200, inspect(id))
  end

  match _ do
    send_resp(conn, 200, "Hello, world!")
  end
end