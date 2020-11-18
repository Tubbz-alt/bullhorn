use Mix.Config

config :bullhorn,
  producer:
    {BroadwaySQS.Producer,
     queue_url: "",
     config: [
       access_key_id: "",
       secret_access_key: "",
       region: "us-east-2"
     ]}

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

config :appsignal, :config,
  active: false,
  name: "Bullhorn"

config :bullhorn, Bullhorn.Mailer, adapter: Bamboo.LocalAdapter

config :bullhorn,
  message_handlers: [
    {Bullhorn.Orders,
     [
       :assembly_failure
     ]},
    {
      Bullhorn.Users,
      [
        :password_changed,
        :password_reset,
        :user_created
      ]
    }
  ]

import_config "#{Mix.env()}.exs"
