defmodule Fingerprint.OSReleaseTest do
  use ExUnit.Case

  test "release file detection" do
    assert %Fingerprint.OS.Release.Attributes{id: "ubuntu", name: "Ubuntu",
      pretty_name: "Ubuntu 17.04", version: "17.04 (Zesty Zapus)"} == Fingerprint.OS.Release.parse
  end
end
