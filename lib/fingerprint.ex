defmodule Fingerprint do
  def profile() do
    case :os.type() do
      {_, :linux} -> use Fingerprint.Plugins.Linux
    end
  end
end
