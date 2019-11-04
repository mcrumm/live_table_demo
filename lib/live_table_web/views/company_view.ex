defmodule LiveTableWeb.CompanyView do
  use LiveTableWeb, :view
  use Scrivener.HTML
  import Phoenix.LiveView, only: [live_link: 2]
  alias LiveTableWeb.CompaniesLive

  def ldt_sort(text, conn, action, %{page_number: page}, params, opts \\ [])
      when is_binary(text) do
    field = opts[:field] || String.downcase(text)

    {sort, sorting} =
      case params[:sort] do
        ^field -> {"-#{field}", "sorting_asc"}
        <<"-"::binary, ^field::binary>> -> {field, "sorting_desc"}
        other -> default_sort(other, opts[:default], field)
      end

    # TODO: Handle dynamic paths, a la Scrivener.HTML
    path_params = [sort: sort, page: page] ++ params
    path = Routes.company_path(conn, action, path_params)

    content_tag(:th, live_link(text, to: path), class: sorting)
  end

  defp default_sort(params, default, field)
  defp default_sort(nil, :asc, field), do: {"-#{field}", "sorting_asc"}
  defp default_sort(nil, :desc, field), do: {field, "sorting_desc"}
  defp default_sort(_, _, field), do: {field, "sorting"}

  def page_summary(%{page_number: num, page_size: size, total_entries: total}) do
    page_summary(num, size, total)
  end

  def page_summary(_), do: ""

  defp page_summary(1, size, total) do
    "Showing 1 to #{size} of #{total} entries"
  end

  defp page_summary(page, size, total) do
    x = size * (page - 1)
    "Showing #{x + 1} to #{x + size} of #{total} entries"
  end
end
