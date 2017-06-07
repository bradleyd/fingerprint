defmodule Fingerprint.Plugins.Linux.CpuTest do
  use ExUnit.Case

  test "cpu count" do
    %{count: count} = Fingerprint.Plugins.Linux.Cpu.count()
    assert is_integer(count)
  end
end
