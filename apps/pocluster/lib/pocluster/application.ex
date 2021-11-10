defmodule Pocluster.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      jobs: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      {Phoenix.PubSub, name: Pocluster.PubSub},
      {Pocluster.CacheServer, name: Pocluster.CacheServer},
      {Cluster.Supervisor, [topologies, [name: Pocluster.ClusterSupervisor]]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Pocluster.Supervisor)
  end
end
