defmodule Fingerprint.Plugins.Linux.BlockDevices do
  @moduledoc """
  Linux Block Devices
  """

  @behaviour Fingerprint.BlockDevices

  @doc """
  Return all block device information on a host

  ## Examples


      iex> Fingerprint.Plugins.Linux.BlockDevices.all
      [%{"device" => "dm-0", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "0",
      "size" => "233390080"},
      %{"device" => "dm-1", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "0",
      "size" => "16171008"},
      %{"device" => "loop0", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop1", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop2", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop3", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop4", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop5", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop6", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "loop7", "logical_block_size" => "512",
      "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
      "size" => "0"},
      %{"device" => "sda", "logical_block_size" => "512",
      "model" => "SanDisk SSD U100", "physical_block_size" => "512",
      "queue_depth" => "31", "removable" => "0", "rev" => "6.04",
      "rotational" => "0", "size" => "250069680", "state" => "running",
      "timeout" => "30", "vendor" => "ATA"}]

  """

  def all do
    Enum.map(Path.wildcard("/sys/block/*"), fn(block_device_directory) ->
      size_and_removable(%{"device" => device(block_device_directory)}, block_device_directory)
      |> device_info(block_device_directory)
      |> queue_info(block_device_directory)
    end)
  end

  defp size_and_removable(map, block_device_directory) do
    Enum.reduce(~w{size removable}, map, fn(attr, acc) ->
      if File.exists?("#{block_device_directory}/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/#{attr}")
        Map.put(acc, attr, String.trim(data))
      else
        acc
      end
    end)
  end

  defp device_info(map, block_device_directory) do
    Enum.reduce(~w{model rev state timeout vendor queue_depth}, map, fn(attr,acc) ->
      if File.exists?("#{block_device_directory}/device/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/device/#{attr}")
        Map.put(acc, attr, String.trim(data))
      else
        acc
      end
    end)
  end

  defp queue_info(map, block_device_directory) do
    Enum.reduce(~w{rotational physical_block_size logical_block_size}, map, fn(attr, acc) ->
      if File.exists?("#{block_device_directory}/queue/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/queue/#{attr}")
        Map.put(acc, attr, String.trim(data))
      else
        acc
      end
    end)
  end

  defp device(block_device_directory) do
    Path.basename(block_device_directory)
  end
end
