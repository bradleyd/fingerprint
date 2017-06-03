defmodule Fingerprint.OSReleaseTest do
  use ExUnit.Case

  test "release file detection" do
    assert %{"id" => "ubuntu"} = Fingerprint.OSRelease.release
  end
end
