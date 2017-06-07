defmodule Fingerprint.Plugins.Linux.NetworkTest do
  use ExUnit.Case

  test "ip addresses" do
    ip_addresses = Fingerprint.Plugins.Linux.Network.addresses()
    first_device = List.first(ip_addresses)
    assert Map.has_key?(first_device, "address")
    assert Map.has_key?(first_device, "netmask")
    assert Map.has_key?(first_device, "device")
    assert Map.has_key?(first_device, "flags")
  end
end
