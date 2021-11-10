defmodule PoclusterWeb.PageController do
  use PoclusterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
