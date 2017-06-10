defmodule Fingerprint.Plugins.Linux.CpuTest do
  use ExUnit.Case

  test "cpu count" do
    count = Fingerprint.Plugins.Linux.Cpu.count()
    assert is_integer(count)
  end
 test "cpu info" do
   %{"bogomips" => _bogo, "cache_size" => _cs, "count" => _count,
     "cpu_cores" => _cores, "cpu_family" => _cf, "cpu_mhz" => _mhz,
     "flags" => _flags, "id" => _id, "model" => _model,
     "model_name" => _mname, "stepping" => _stepping} = Fingerprint.Plugins.Linux.Cpu.info()
 end

end
