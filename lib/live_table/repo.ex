defmodule LiveTable.Repo do
  use Ecto.Repo,
    otp_app: :live_table,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, max_page_size: 500
end
