defmodule Pocluster.CacheClient do
  @moduledoc false

  alias Pocluster.CacheServer

  @table :cache

  def get(key) do
    case GenServer.call(CacheServer, {:get, @table, key}) do
      [] -> {:ok, nil}
      [{_, result}] -> {:ok, result}
    end
  end

  def put(key, value) do
    GenServer.call(CacheServer, {:set, @table, key, value})
  end
end
