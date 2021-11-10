defmodule Pocluster.CacheServer do
  @moduledoc false
  use GenServer

  @tables [:cache]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [tables: @tables], opts)
  end

  def init(tables: tables) do
    {:ok, _tables} = start_tables(tables)

    {:ok, %{tables: tables}}
  end

  def start_tables(tables) do
    tables =
      Enum.map(tables, fn table ->
        :ets.new(table, [:set, :private, :named_table])
      end)

    {:ok, tables}
  rescue
    ArgumentError -> {:error, :already_started}
  end

  def handle_call({:get, table, key}, _from, state) do
    {:reply, :ets.lookup(table, key), state}
  end

  def handle_call({:set, table, key, value}, _from, state) do
    true = :ets.insert(table, {key, value})

    {:reply, value, state}
  end
end
