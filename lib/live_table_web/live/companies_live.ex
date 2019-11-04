defmodule LiveTableWeb.CompaniesLive do
  use Phoenix.LiveView

  alias LiveTable.Orders
  alias LiveTableWeb.CompanyView
  alias LiveTableWeb.Router.Helpers, as: Routes

  @defaults %{"sort" => "id"}
  @valid_filters ~w(name city state)

  @impl true
  def mount(_session, socket) do
    {:ok, assign(socket, page: %Scrivener.Page{page_number: 1}, params: %{}, raw_params: %{})}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    page =
      @defaults
      |> Map.merge(params)
      |> Orders.search_companies(socket)

    link_params = link_params(params)

    {:noreply, assign(socket, page: page, params: link_params, raw_params: params)}
  end

  @impl true
  def handle_event(<<"filter-", key::binary>>, %{"value" => value}, socket)
      when key in @valid_filters do
    default_filter = if value == "", do: %{}, else: Map.put(%{}, key, value)
    # update the current params from the socket
    raw_params =
      Map.update(socket.assigns.raw_params, "filter", default_filter, fn
        filter when is_map(filter) -> Map.put(filter, key, value)
      end)

    link_params =
      [page: socket.assigns.page.page_number] ++
        link_params(raw_params)

    {:noreply, live_redirect(socket, to: Routes.company_path(socket, __MODULE__, link_params))}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(CompanyView, "index.html", assigns)
  end

  defp link_params(params) do
    params
    |> Map.take(~w(sort filter))
    |> Enum.into([], fn {k, v} -> {String.to_atom(k), v} end)
  end
end
