defmodule Pifight.Router do
  use Plug.Router
  import Plug.Conn

  match _ do
    send_resp(conn, 200, "Hello, world!")
  end
end