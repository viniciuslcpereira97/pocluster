defmodule Pocluster.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Pocluster.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Pocluster.Supervisor)
  end
end
