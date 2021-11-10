defmodule Pocluster do
  @moduledoc """
  Pocluster keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Pocluster.CacheClient

  def get_cache(key) do
    CacheClient.get(key)
  end

  def get_cache_in_all_nodes(key) do
    Node.list()
    |> Enum.map(fn node ->
      :rpc.call(node, Pocluster, :get_cache, [key])
    end)
  end
end
