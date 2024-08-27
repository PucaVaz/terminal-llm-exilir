defmodule TerminalLlmExilir.MixProject do
  use Mix.Project

  def project do
    [
      app: :terminal_llm_exilir, # This is where you define your application name
      version: "0.1.0",
      elixir: "~> 1.12",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:openai, "~> 0.6.2"},
      {:dotenv, "~> 3.0", only: [:dev, :test]}
    ]
  end
end
