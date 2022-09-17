defmodule CreditWeb.CreditApprovalController do
  use CreditWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def create(conn, %{"job" => job, "consistenlyjob" => cjob, "owncar" => car, "ownhome" => home, "additional" => additional}) do
    points = sumPoints(job, cjob, home, car, additional)
    if points >= 6 do
      render(conn, "able.html", points: points)
    else
      render(conn, "unable.html")

    end
  end
  def able(conn, %{"incomes" => incomes, "expenses" => expenses, "points" => points}) do

  val =
    incomes
    |>Integer.parse()
    |>elem(0)


  val2 =
    expenses
    |>Integer.parse()
    |>elem(0)


   {:ok, response}  = CreditWeb.Api.fetch_score(points)

   score =
    response.body
    |> Map.fetch( "creditScore")

    last = lastStep(val, val2)

    if last < 0 do
      render(conn, "unable.html")
    end

    render(conn, "congrats.html", credit: last, score: elem(score, 1))
  end

  defp lastStep(first, second) do
    (first - second ) * 12

  end

  defp getPoints(answer, points) do
    if(answer == "Yes") do
      points
    else
      0
    end
  end

  defp sumPoints(job, cjob, home, car, additional) do
    sum = 0
    sum = sum + getPoints(job, 4)
    sum = sum + getPoints(cjob, 2)
    sum = sum + getPoints(home, 2)
    sum = sum + getPoints(car, 1)
    sum = sum + getPoints(additional, 2)

    sum
  end

end
