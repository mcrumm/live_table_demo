defmodule LiveTable.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :phone, :string
      add :website, :string

      timestamps(type: :utc_datetime_usec)
    end
  end
end
