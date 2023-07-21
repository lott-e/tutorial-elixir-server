defmodule Servur.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> route
    |> log
    |> format_response
  end

  def log(conv) do
    IO.inspect(conv)
    conv
  end
  def parse(request) do
    # first_line = request |> String.split("\n") |> List.first
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{ method: method, path: path, resp_body: "" }
  end

  def route(conv) do
    route(conv, conv.path)
  end

  def route(conv, "/wildthings") do
    %{conv | resp_body: "I love you Alex"}
  end

  def route(conv, "/tattoo") do
    %{conv | resp_body: "I love banana"}
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length:  #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servur.Handler.handle(request)

IO.puts response


request = """
GET /tattoo HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servur.Handler.handle(request)

IO.puts response
