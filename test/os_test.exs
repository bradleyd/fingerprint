defmodule Fingerprint.OSTest do
  use ExUnit.Case

  test "release file detection" do
    assert %{"id" => "ubuntu"} = Fingerprint.OS.profile
  end
end
