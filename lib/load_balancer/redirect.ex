defmodule LoadBalancer.Redirect do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> handle_url(GenServer.call(LoadBalancer.Balancer, {:get_next, conn.request_path}))
  end

  def handle_url(conn, nil) do
    send_resp(conn, 404, "oops")
  end

  def handle_url(conn, next_host) do
    url = "#{Atom.to_string(conn.scheme)}://#{next_host}#{conn.request_path}#{conn.query_string}"

    req =
      Req.Request.new(
        method: String.to_atom(String.downcase(conn.method)),
        url: url
      )

    {_req, res} = Req.Request.run_request(req)

    handle_response(conn, res)
  end

  def handle_response(conn, %Req.TransportError{}) do
    send_resp(conn, 500, "")
  end

  def handle_response(conn, res) do
    content_type = Req.Response.get_header(res, "content-type")
    content_type = if Enum.empty?(content_type), do: "", else: hd(content_type)

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(res.status, res.body)
  end
end
