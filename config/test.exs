import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pocluster_web, PoclusterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "f2c/mtBuAD7hRDsN7zRokWu1D3SyDWKhzo9Smhz8Th0rRA0412WaySt4D2JNufb/",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
