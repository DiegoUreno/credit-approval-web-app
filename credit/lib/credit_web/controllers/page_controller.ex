defmodule CreditWeb.PageController do
  use CreditWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
