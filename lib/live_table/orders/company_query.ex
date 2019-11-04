defmodule LiveTable.Orders.CompanyQuery do
  require Ecto.Query

  use Inquisitor
  use Inquisitor.JsonApi.Filter
  use Inquisitor.JsonApi.Sort

  def build_filter_query(query, "name", value, _) do
    Ecto.Query.where(query, [c], ilike(c.name, ^"%#{value}%"))
  end

  def build_filter_query(query, "city", value, _) do
    Ecto.Query.where(query, [c], ilike(c.city, ^"#{value}%"))
  end

  def build_filter_query(query, "state", value, _) do
    Ecto.Query.where(query, [c], c.state == ^value)
  end
end
