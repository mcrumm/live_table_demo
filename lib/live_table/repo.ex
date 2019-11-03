defmodule LiveTable.Repo do
  use Ecto.Repo,
    otp_app: :live_table,
    adapter: Ecto.Adapters.Postgres
end
