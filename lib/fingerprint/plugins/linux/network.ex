defmodule Fingerprint.Plugins.Linux.Network do
  @moduledoc """
    Linux network
  """
  @behaviour Fingerprint.Network

  @doc """
  Return all addresses on host

  ## Examples

      iex> Fingerprint.Plugins.Linux.Network.addresses()
      [%{address: "FE80::FC54:FF:FECB:F782", device: "vnet0",
      flags: [:up, :broadcast, :running, :multicast],
      netmask: "FFFF:FFFF:FFFF:FFFF::"},
      %{address: "172.17.42.1", device: "docker0",
      flags: [:up, :broadcast, :running, :multicast], netmask: "255.255.0.0"},
      %{address: nil, device: "virbr0-nic", flags: [:broadcast, :multicast],
      netmask: nil},
      %{address: "192.168.122.1", device: "virbr0",
      flags: [:up, :broadcast, :running, :multicast], netmask: "255.255.255.0"},
      %{address: "10.0.3.1", device: "lxcbr0",
      flags: [:up, :broadcast, :running, :multicast], netmask: "255.255.255.0"},
      %{address: "192.168.1.31", device: "wlan0",
      flags: [:up, :broadcast, :running, :multicast], netmask: "255.255.255.0"},
      %{address: nil, device: "eth0", flags: [:up, :broadcast, :running, :multicast],
      netmask: nil},
      %{address: "127.0.0.1", device: "lo", flags: [:up, :loopback, :running],
      netmask: "255.0.0.0"}]

  """
  def addresses do
    get_addresses()
  end

  defp get_addresses() do
    {:ok, data} = :inet.getifaddrs
    Enum.reduce(data, [], fn(x, acc) ->
      {dev, kl} = x
      [%{ "device" => List.to_string(dev), "flags" => kl[:flags], "address" => ntoa(kl[:addr]), "netmask" => ntoa(kl[:netmask])} | acc]
    end)
  end

  defp ntoa(nil), do: nil
  defp ntoa(ip), do: List.to_string(:inet.ntoa(ip))
end

