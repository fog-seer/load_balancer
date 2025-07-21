import Config

config :load_balancer,
  port: 1234,
  services: [
    %{
      upstream_origins: [
        "/serv1"
      ],
      downstream_endpoints: [
        "localhost:4005",
        "localhost:4006",
        "localhost:4007"
      ]
    },
    %{
      upstream_origins: [
        "/serv2"
      ],
      downstream_endpoints: [
        "localhost:4008",
        "localhost:4009",
        "localhost:4010"
      ]
    }
  ]
