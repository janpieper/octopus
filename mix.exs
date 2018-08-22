defmodule Octopus.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :octopus,
      version: @version,
      elixir: "~> 1.6",
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp package do
    [
      name: "octopus",
      description: "Map any value, not just enumerables!",
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Jan Pieper"],
      licenses: ["GNU GPLv3"],
      links: %{"GitHub" => "https://github.com/janpieper/octopus"}
    ]
  end

  def docs do
    [
      name: "Octopus",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/octopus",
      source_url: "https://github.com/janpieper/octopus"
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end
end
