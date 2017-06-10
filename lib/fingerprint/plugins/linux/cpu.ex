defmodule Fingerprint.Plugins.Linux.Cpu do
  @moduledoc """
  Linux CPU
  """

  @behaviour Fingerprint.Cpu

  @doc """
  Return cpu count

  ## Examples

  iex> Fingerprint.Plugins.Linux.Cpu.count
  4

  """
  def count do
    #count = :os.cmd('lscpu -p=cpu | grep -v ^# | wc -l') |> to_string |> String.trim |> String.to_integer
    data = info()
    Map.get(data, "count", 0)
  end

  @doc """
  Return all cpus information on host

  ## Examples

  iex> Fingerprint.Plugins.Linux.Cpu.info
  %{"bogomips" => "3392.31", "cache_size" => "3072 KB", "count" => 4,
  "cpu_cores" => "2", "cpu_family" => "6", "cpu_mhz" => "799.987",
  "flags" => "fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm epb tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts",
  "id" => "GenuineIntel", "model" => "58", "model_name" => "Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz", "stepping" => "9"}


  """

  def info do
    {:ok, f} = File.open("/proc/cpuinfo")
    stream = IO.read(f, :all)
    split_string_on_newlines(stream)
    |> list_of_key_values
    |> do_cpu(%{})
  end

  defp split_string_on_newlines(stream) do
    String.split(stream, "\n")
  end
  defp list_of_key_values([]), do: []
  defp list_of_key_values(list) do
    Enum.map(list, fn(i) -> Regex.run(~r/([a-zA-Z0-9\s]+)\b[\t]+:\s([\w\W\S\s]+)/, i) end)
  end

  defp do_cpu([], acc), do: acc
  defp do_cpu([[_, "processor", _cpu_id]|t], acc) do
    count = Map.get(acc, "count", 0)
    acc   = Map.put(acc, "count", count + 1)
    do_cpu(t, acc)
  end
  defp do_cpu([[_, "id", type]|t], acc) do
    do_cpu(t, Map.put(acc, "id", type))
  end
  defp do_cpu([[_, "cpu family", cpu_family]|t], acc) do
    do_cpu(t, Map.put(acc, "cpu_family", cpu_family))
  end
  defp do_cpu([[_, "model", model]|t], acc) do
    do_cpu(t, Map.put(acc, "model", model))
  end
  defp do_cpu([[_, "model name", model_name]|t], acc) do
    do_cpu(t, Map.put(acc, "model_name", model_name))
  end
  defp do_cpu([[_, "cpu MHz", cpu_mhz]|t], acc) do
    do_cpu(t, Map.put(acc, "cpu_mhz", cpu_mhz))
  end
  defp do_cpu([[_, "stepping", stepping]|t], acc) do
    do_cpu(t, Map.put(acc, "stepping", stepping))
  end
  defp do_cpu([[_, "cpu cores", cpu_cores]|t], acc) do
    do_cpu(t, Map.put(acc, "cpu_cores", cpu_cores))
  end
  defp do_cpu([[_, "flags", flags]|t], acc) do
    do_cpu(t, Map.put(acc, "flags", flags))
  end
  defp do_cpu([[_, "bogomips", bogomips]|t], acc) do
    do_cpu(t, Map.put(acc, "bogomips", bogomips))
  end
  defp do_cpu([[_, "cache size", cache_size]|t], acc) do
    do_cpu(t, Map.put(acc, "cache_size", cache_size))
  end
  defp do_cpu([_h|t], acc) do
    do_cpu(t, acc)
  end

end
