defmodule Fingerprint.Plugins.Linux.Cpu do
  @moduledoc """
  Linux CPU
  """

  @behaviour Fingerprint.Cpu

  defmodule Attributes do
    defstruct count: :nil, cpus: []
  end

  @doc """
  Return all cpus information on host

  ## Examples

  iex> Fingerprint.Plugins.Linux.Cpu.count
  %Fingerprint.Plugins.Linux.Cpu.Attributes{count: 4}

  """

  def count do
    count = :os.cmd('lscpu -p=cpu | grep -v ^# | wc -l') |> to_string |> String.trim |> String.to_integer
    %{ %Attributes{} | count: count }
  end

  def info do
    {:ok, f} = File.open("/proc/cpuinfo")
    stream   = IO.stream(f, :line)
    Enum.map(stream, fn(line) ->
      Regex.named_captures(~r/(?<key>[a-zA-Z0-9\s]+)\b[\t]+:\s(?<value>[\w\W\S\s]+)\n/, line)
    end)
  end

  defp string_to_int(str) do
    String.to_integer(str)
  end
  

end
