use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sherlock_board, SherlockBoard.Endpoint,
  secret_key_base: "KFRBqRS//NJPVTRs6Oz+zM4R0KUuWCIEBkNQ7iNqyJoUCKPoBMTBojfvhR/6Q7RQ",
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
config :hound, driver: "selenium"
