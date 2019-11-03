defmodule LiveTableWeb.CompanyView do
  use LiveTableWeb, :view
  use Scrivener.HTML
  alias LiveTableWeb.CompaniesLive

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
