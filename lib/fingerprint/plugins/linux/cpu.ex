defmodule Fingerprint.Plugins.Linux.Cpu do
  @moduledoc """
  Linux CPU
  """

  defmodule Attributes do
    defstruct cpus: :nil
  end

  @doc """
  Return all cpus information on host

  ## Examples

  iex> Fingerprint.Plugins.Linux.Cpu.count
  %Fingerprint.Plugins.Linux.Cpu.Attributes{count: 4}

  """

  def count do
    cpus(%Attributes{})
  end

  def info do
   {:ok, f} = File.open("/proc/cpuinfo")
   stream = IO.stream(f, :line)
   Enum.map(stream, fn(line) ->
     #Regex.named_captures(~r/(?<key>[a-zA-Z0-9\s]+)\b[\t]+:\s(?<value>[a-zA-Z0-9\s]+)\n$/, line)
     Regex.named_captures(~r/(?<key>[a-zA-Z0-9\s]+)\b[\t]+:\s(?<value>[\w\W\S\s]+)\n/, line)
   end)
   #   case line
   #   when /processor\s+:\s(.+)/
   #     cpuinfo[$1] = Mash.new
   #     current_cpu = $1
   #     cpu_number += 1
   #   when /vendor_id\s+:\s(.+)/
   #     vendor_id = $1
   #     if vendor_id =~ (/IBM\/S390/)
   #       cpuinfo["vendor_id"] = vendor_id
   #     else
   #       cpuinfo[current_cpu]["vendor_id"] = vendor_id
   #     end
   #   when /cpu family\s+:\s(.+)/
   #     cpuinfo[current_cpu]["family"] = $1
   #   when /model\s+:\s(.+)/
   #     cpuinfo[current_cpu]["model"] = $1
   #   when /stepping\s+:\s(.+)/
   #     cpuinfo[current_cpu]["stepping"] = $1
   #   when /physical id\s+:\s(.+)/
   #     cpuinfo[current_cpu]["physical_id"] = $1
   #     real_cpu[$1] = true
   #   when /core id\s+:\s(.+)/
   #     cpuinfo[current_cpu]["core_id"] = $1
   #   when /cpu cores\s+:\s(.+)/
   #     cpuinfo[current_cpu]["cores"] = $1
   #   when /model name\s+:\s(.+)/
   #     cpuinfo[current_cpu]["model_name"] = $1
   #   when /cpu MHz\s+:\s(.+)/
   #     cpuinfo[current_cpu]["mhz"] = $1
   #   when /cache size\s+:\s(.+)/
   #     cpuinfo[current_cpu]["cache_size"] = $1
   #   when /flags\s+:\s(.+)/
   #     cpuinfo[current_cpu]["flags"] = $1.split(" ")
   #   when /bogomips per cpu:\s(.+)/
   #     cpuinfo["bogomips_per_cpu"] = $1
   #   when /features\s+:\s(.+)/
   #     cpuinfo["features"] = $1.split(" ")
   #   when /processor\s(\d):\s(.+)/
   #     current_cpu = $1
   #     cpu_number += 1
   #     cpuinfo[current_cpu] = Mash.new
   #     current_cpu_info = $2.split(",")
   #     current_cpu_info.each do |i|
   #       name_value = i.split("=")
   #       name = name_value[0].strip
   #       value = name_value[1].strip
   #       cpuinfo[current_cpu][name] = value
   #     end
   #   end
   # end
  end
  def cpus(struct) do
    cpu_count = :os.cmd('lscpu -p=cpu | grep -v ^# | wc -l')
    %{ struct | cpus: String.trim(List.to_string(cpu_count)) }
  end


end
