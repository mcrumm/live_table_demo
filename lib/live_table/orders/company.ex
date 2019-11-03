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

  alias Faker.Pizza
  alias Faker.Address.En, as: Address
  alias Faker.Internet
  alias Faker.Phone.EnUs, as: Phone

  def fixture(_) do
    inserted_at = DateTime.utc_now()

    %{
      name: Pizza.company(),
      address: Address.street_address(),
      city: Address.city(),
      state: Address.state_abbr(),
      phone: Phone.phone(),
      website: Internet.url(),
      inserted_at: inserted_at,
      updated_at: inserted_at
    }
  end
end
