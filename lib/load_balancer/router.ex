defmodule LoadBalancer.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/health" do
    send_resp(conn, 200, "ok")
  end

  match _, to: LoadBalancer.Redirect
end
