defmodule Fingerprint.Plugins.Linux.Memory do
  @moduledoc """
  Linux CPU
  """

  @behaviour Fingerprint.Memory

  defmodule Attributes do
    #defstruct total: :nil, free: :nil, buffer: :nil, cached: :nil, active: :nil, inactive: :nil, high_total: :nil, high_free: :nil
  end

  @doc """
  Return all cpus information on host

  ## Examples

  iex> Fingerprint.Plugins.Linux.Memory.all()
  %{"Active" => "4527884", "Hugepagesize" => "2048",
  "VmallocTotal" => "34359738367", "ShmemPmdMapped" => "0", "Mlocked" => "4876",
  "SwapCached" => "380", "Dirty" => "320", "SwapFree" => "8065520",
  "Inactive" => "2647520", "CmaFree" => "0", "MemTotal" => "7869508",
  "Unevictable" => "4876", "Slab" => "282592", "Active(file)" => "1134804",
  "HardwareCorrupted" => "0", "Writeback" => "0", "AnonHugePages" => "1923072",
  "VmallocUsed" => "0", "Shmem" => "543584", "HugePages_Rsvd" => "0",
  "Buffers" => "722352", "Mapped" => "772220", "DirectMap4k" => "300980",
  "CommitLimit" => "12020252", "HugePages_Total" => "0", "WritebackTmp" => "0",
  "HugePages_Surp" => "0", "Inactive(anon)" => "1411000",
  "KernelStack" => "17296", "DirectMap2M" => "7782400", "ShmemHugePages" => "0",
  "Bounce" => "0", "Active(anon)" => "3393080", "SReclaimable" => "157488",
  "CmaTotal" => "0", "VmallocChunk" => "0", "NFS_Unstable" => "0",
  "MemAvailable" => "2467064", "PageTables" => "74604", "Cached" => "2192556",
  "SwapTotal" => "8085500", "Committed_AS" => "13923560",
  "AnonPages" => "4037824", "Inactive(file)" => "1236520",
  "SUnreclaim" => "125104", "MemFree" => "236400", "HugePages_Free" => "0"}
  """

  # TODO fold this into a struct..string keys...?
  def all do
    {:ok, f} = File.open("/proc/meminfo")
    stream   = IO.stream(f, :line)
    Enum.reduce(stream, %{}, fn(line, acc) ->
      [_, key, value] = Regex.run(~r/([a-zA-Z0-9\(\)_]+):\s+([0-9]+)/, line)
      Map.put(acc, key, String.to_integer(value))
    end)
  end

  def total do
    Map.fetch(all(), "MemTotal")
  end
end
