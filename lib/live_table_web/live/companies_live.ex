defmodule LiveTableWeb.CompaniesLive do
  use Phoenix.LiveView
  alias LiveTable.Orders
  alias LiveTableWeb.CompanyView

  @impl true
  def mount(_session, socket) do
    page = Orders.paginate_companies()

    {:ok, assign(socket, page: page)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(CompanyView, "index.html", assigns)
  end
end
