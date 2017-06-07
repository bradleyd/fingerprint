defmodule Fingerprint.Mixfile do
  use Mix.Project

  def project do
    [app: :fingerprint,
      version: "0.2.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "fingerprint",
      source_url: "https://github.com/bradleyd/fingerprint",
      homepage_url: "http://github.com/bradleyd/fingerprint"]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    """
    Fingerprint provides system information like memory, CPU, os-release, block devices and network.
    """
  end
  defp package do
    [
      name: :fingerprint,
      maintainers: ["Bradley Smith"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/bradleyd/fingerprint"}
    ]
  end
end
