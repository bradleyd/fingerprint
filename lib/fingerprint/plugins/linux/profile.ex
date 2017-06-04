#defmodule Fingerprint.OS.Hardware do
#  alias Fingerprint.OS.Release
#
#  defmodule Attributes do
#    defstruct ip_addresses: :nil, architecture: :nil, block_devices: :nil, cpus: :nil
#  end
#
#  def parse do
#    %Attributes{}
#    |> block_devices(Release.parse)
#    |> cpus
#    |> ip_addresses
#    |> architecture
#  end
#
#  defp architecture(struct) do
#    {data, 0} = System.cmd("uname", ["-m"])
#    %{ struct | architecture: String.trim(data)}
#  end
#  #to_string :inet.ntoa Keyword.get(kl, :addr)
#  defp ip_addresses(struct) do
#    {:ok, data} = :inet.getifaddrs
#    addresses =
#    Enum.reduce(data, [], fn(x, acc) ->
#      {dev, kl} = x
#      [%{device: List.to_string(dev), address: ntoa(kl[:addr]), netmask: ntoa(kl[:netmask])} | acc]
#    end)
#    %{ struct | ip_addresses: addresses }
#  end
#
#  defp block_devices(struct, %Fingerprint.OS.Release.Attributes{id: distro}) when distro == "centos" or distro == "redhat" do
#    # need lsblk -J equivalent
#    struct
#  end
#  defp block_devices(struct, %Fingerprint.OS.Release.Attributes{id: "ubuntu"}) do
#    {data, 0} = System.cmd("lsblk", ["-J"])
#    devices   = Poison.decode!(data)
#    %{ struct | block_devices: devices["blockdevices"] }
#  end
#
#  def cpus(struct) do
#    cpu_count = :os.cmd('lscpu -p=cpu | grep -v ^# | wc -l')
#    %{ struct | cpus: String.trim(List.to_string(cpu_count)) }
#  end
#
#  defp ntoa(nil), do: nil
#  defp ntoa(ip), do: List.to_string(:inet.ntoa(ip))
#end
#
