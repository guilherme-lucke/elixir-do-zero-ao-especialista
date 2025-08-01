defmodule MeuDiario.MixProject do
  use Mix.Project

  def project do
    [
      app: :meu_diario,
      version: "0.1.0-alpha",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nanoid, "~> 2.0"}
    ]
  end
end
