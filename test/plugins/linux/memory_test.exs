defmodule Fingerprint.Plugins.Linux.MemoryTest do
  use ExUnit.Case

  test "memory all" do
    %{"MemTotal" => total} = Fingerprint.Plugins.Linux.Memory.all()
    assert is_integer(total)
  end
end
