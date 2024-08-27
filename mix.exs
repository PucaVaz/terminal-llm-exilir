defmodule TerminalLlmExilir.MixProject do
  use Mix.Project

  def project do
    [
      app: :terminal_llm_exilir, # This is your application name
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Other functions...
end
