use Mix.Config
# Print only warnings and errors during test
config :logger, level: :warn

config :hound, driver: "selenium", http: [recv_timeout: 60000, timeout: 60000]
