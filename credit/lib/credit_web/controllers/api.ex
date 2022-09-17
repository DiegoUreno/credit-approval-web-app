defmodule CreditWeb.Api do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://lxzau4xjot.api.quickmocker.com/"
  plug Tesla.Middleware.JSON

  def fetch_score(points) do
    get("/creditScore/" <> points)
  end

end
