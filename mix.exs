defmodule SpanishDoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :spanish_doc,
      version: "1.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/salva-ruiz/spanish_doc"
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
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    "A library to process Spanish NIF/NIE identity documentation numbers."
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/salva-ruiz/spanish_doc"}
    ]
  end
end
