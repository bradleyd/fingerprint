defmodule Fingerprint.Plugins.Linux.ReleaseTest do
  use ExUnit.Case

  test "release file detection" do
    assert %{id: "ubuntu", name: "Ubuntu", pretty_name: "Ubuntu 17.04", version: "17.04 (Zesty Zapus)"} == Fingerprint.Plugins.Linux.Release.release()
  end
end
