defmodule Fingerprint.Plugins.Linux do
  @doc false
  defmacro __using__(_) do
    quote do
      import  Fingerprint.Plugins.Linux.Cpu
      import  Fingerprint.Plugins.Linux.Network
      import  Fingerprint.Plugins.Linux.BlockDevices
      import  Fingerprint.Plugins.Linux.Release
      import unquote(__MODULE__)
    end
  end
end
