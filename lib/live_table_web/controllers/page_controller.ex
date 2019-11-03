defmodule LiveTableWeb.PageController do
  use LiveTableWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
