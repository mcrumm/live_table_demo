defmodule LiveTableWeb.CompaniesLive do
  use Phoenix.LiveView

  alias LiveTable.Orders
  alias LiveTableWeb.CompanyView

  @defaults %{"sort" => "id"}

  @impl true
  def mount(_session, socket) do
    {:ok, assign(socket, page: %Scrivener.Page{})}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    page =
      @defaults
      |> Map.merge(params)
      |> Orders.search_companies(socket)

    link_params = link_params(params)

    {:noreply, assign(socket, page: page, params: link_params)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(CompanyView, "index.html", assigns)
  end

  defp link_params(params) do
    params
    |> Map.take(~w(sort))
    |> Enum.into([], fn {k, v} -> {String.to_atom(k), v} end)
  end
end
