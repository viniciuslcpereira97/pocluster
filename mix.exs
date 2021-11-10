defmodule Pocluster.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      releases: [
        pocluster_umbrella: [
          applications: [
            pocluster: :permanent,
            pocluster_web: :permanent
          ]
        ]
      ]
    ]
  end

  defp deps do
    [
      {:libcluster, "~> 3.3"}
    ]
  end

  defp aliases do
    [
      # run `mix setup` in all child apps
      setup: ["cmd mix setup"]
    ]
  end
end
