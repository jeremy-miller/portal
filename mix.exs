defmodule Portal.Mixfile do
  use Mix.Project

  def project do
    [app: :portal,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    [extra_applications: [:logger],
     mod: {Portal.Application, []}]
  end
  
  defp deps do
    [{:credo, "~> 0.3", only: [:dev, :test]}]
  end
end
