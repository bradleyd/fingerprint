defmodule Fingerprint.Plugins.Linux.BlockDevicesTest do
  use ExUnit.Case

  test "all block devices" do
    devices = Fingerprint.Plugins.Linux.BlockDevices.all()
    first_device = List.first(devices)
    assert Map.has_key?(first_device, "device")
    assert Map.has_key?(first_device, "size")
  end
end
