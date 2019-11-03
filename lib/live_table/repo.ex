defmodule LiveTable.Repo do
  use Ecto.Repo,
    otp_app: :live_table,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, max_page_size: 500

  @doc """
  Performs a paginated search.
  """
  def search(builder, queryable, context, params) do
    queryable
    |> builder.build_query(context, params)
    |> paginate(params)
  end
end
