defmodule LiveTable.Orders.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts type: :utc_datetime_usec
  schema "companies" do
    field :address, :string
    field :city, :string
    field :name, :string
    field :phone, :string
    field :state, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :address, :city, :state, :phone, :website])
    |> validate_required([:name, :address, :city, :state, :phone, :website])
  end
end
