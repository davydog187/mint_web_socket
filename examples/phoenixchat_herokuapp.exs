# N.B. this is a phoenix v1.3 server that sends pings periodically
# see https://phoenixchat.herokuapp.com for the in-browser version
{:ok, conn} = Mint.HTTP.connect(:https, "phoenixchat.herokuapp.com", 443)
req_headers = Mint.WebSocket.build_request_headers()
{:ok, conn, ref} = Mint.HTTP.request(conn, "GET", "/ws", req_headers, nil)
http_get_message = receive(do: (message -> message))
{:ok, conn, [{:status, ^ref, status}, {:headers, ^ref, resp_headers}, {:done, ^ref}]} =
  Mint.HTTP.stream(conn, http_get_message)
{:ok, conn, websocket} = Mint.WebSocket.new(conn, ref, status, req_headers, resp_headers)

{:ok, websocket, data} = Mint.WebSocket.encode(websocket, {:text, ~s[{"topic":"rooms:lobby","event":"phx_join","payload":{},"ref":1}]})
{:ok, conn} = Mint.HTTP.stream_request_body(conn, ref, data)

message = receive(do: (message -> message))
{:ok, conn, [{:data, ^ref, data}]} = Mint.HTTP.stream(conn, message)
{:ok, websocket, messages} = Mint.WebSocket.decode(websocket, data)
IO.inspect(messages)

message = receive(do: (message -> message))
{:ok, conn, [{:data, ^ref, data}]} = Mint.HTTP.stream(conn, message)
{:ok, websocket, messages} = Mint.WebSocket.decode(websocket, data)
IO.inspect(messages)

message = receive(do: (message -> message))
{:ok, conn, [{:data, ^ref, data}]} = Mint.HTTP.stream(conn, message)
{:ok, websocket, messages} = Mint.WebSocket.decode(websocket, data)
IO.inspect(messages)

message = receive(do: (message -> message))
{:ok, conn, [{:data, ^ref, data}]} = Mint.HTTP.stream(conn, message)
{:ok, websocket, messages} = Mint.WebSocket.decode(websocket, data)
IO.inspect(messages)