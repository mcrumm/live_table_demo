defmodule LiveTable.OrdersTest do
  use LiveTable.DataCase

  alias LiveTable.Orders

  describe "companies" do
    alias LiveTable.Orders.Company

    @valid_attrs %{address: "some address", city: "some city", name: "some name", phone: "some phone", state: "some state", website: "some website"}
    @update_attrs %{address: "some updated address", city: "some updated city", name: "some updated name", phone: "some updated phone", state: "some updated state", website: "some updated website"}
    @invalid_attrs %{address: nil, city: nil, name: nil, phone: nil, state: nil, website: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Orders.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Orders.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Orders.create_company(@valid_attrs)
      assert company.address == "some address"
      assert company.city == "some city"
      assert company.name == "some name"
      assert company.phone == "some phone"
      assert company.state == "some state"
      assert company.website == "some website"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Orders.update_company(company, @update_attrs)
      assert company.address == "some updated address"
      assert company.city == "some updated city"
      assert company.name == "some updated name"
      assert company.phone == "some updated phone"
      assert company.state == "some updated state"
      assert company.website == "some updated website"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_company(company, @invalid_attrs)
      assert company == Orders.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Orders.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Orders.change_company(company)
    end
  end
end
