defmodule Pocluster.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Pocluster.PubSub}
      # Start a worker by calling: Pocluster.Worker.start_link(arg)
      # {Pocluster.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Pocluster.Supervisor)
  end
end
