# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveTable.Repo.insert!(%LiveTable.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

alias LiveTable.Seeds
alias LiveTable.Orders.Company

chunk_size = 3_500

_ = Seeds.insert_list(250_000, Company, chunk_size: chunk_size)
