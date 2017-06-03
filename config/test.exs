use Mix.Config

config :fingerprint, os_release: Path.join([File.cwd!, "test", "support", "os-release"])
