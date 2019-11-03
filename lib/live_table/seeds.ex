defmodule LiveTable.Seeds do
  alias LiveTable.Repo

  require Logger

  def insert_list(total, schema) do
    insert_list(total, schema, [])
  end

  def insert_list(total, schema, mapper) when is_function(mapper, 1) do
    insert_list(total, schema, mapper, [])
  end

  def insert_list(total, schema, opts) when is_list(opts) do
    insert_list(total, schema, Function.capture(schema, :fixture, 1), opts)
  end

  def insert_list(total, schema, mapper, opts) do
    opts = Keyword.put(opts, :total_size, total)
    chunk_size = Keyword.get(opts, :chunk_size, 1_000)

    1..total
    |> Stream.map(mapper)
    |> Stream.chunk_every(chunk_size)
    |> insert_chunk(schema, chunk_size: chunk_size, total_size: total)
  end

  defp insert_chunk(chunk, schema, opts) do
    grand_total = Keyword.fetch!(opts, :total_size)
    chunk_size = opts[:chunk_size] || length(chunk)
    repo = opts[:repo] || Repo
    quiet = opts[:quiet] || false

    total =
      Enum.reduce(chunk, 0, fn entries, total ->
        case repo.insert_all(schema, entries) do
          {^chunk_size, _} ->
            unless quiet do
              Logger.info("[#{inspect(schema)}] inserted #{total}/#{grand_total} entries")
            end

            chunk_size + total

          {n, _} when n + total == grand_total ->
            grand_total

          {n, _} ->
            raise "failed to insert #{chunk_size} entries for #{inspect(schema)}, got: #{n}, total: #{
                    n + total
                  }"
        end
      end)

    Logger.info("[#{inspect(Company)}] inserted #{total} entries")
  end
end
