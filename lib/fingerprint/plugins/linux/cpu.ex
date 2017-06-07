defmodule Fingerprint.Plugins.Linux.Cpu do
  @moduledoc """
  Linux CPU
  """

  @behaviour Fingerprint.Cpu

  @doc """
  Return all cpus information on host

  ## Examples

      iex> Fingerprint.Plugins.Linux.Cpu.count
      %{count: 4}


  """
  def count do
    count = :os.cmd('lscpu -p=cpu | grep -v ^# | wc -l') |> to_string |> String.trim |> String.to_integer
    %{count: count }
  end

  def info do
    {:ok, f} = File.open("/proc/cpuinfo")
    stream   = IO.stream(f, :line)
    Enum.reduce(stream, [], fn(line, acc) ->
      case Regex.run(~r/([a-zA-Z0-9\s]+)\b[\t]+:\s([\w\W\S\s]+)\n/, line) do
        nil -> acc
        [_, key, value] -> [%{key => value} | acc]
      end
    end)
  end

end
