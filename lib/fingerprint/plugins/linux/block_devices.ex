defmodule Fingerprint.Plugins.Linux.BlockDevices do
  @moduledoc """
  Linux Block Devices
  """

  @behaviour Fingerprint.BlockDevices

  defmodule Attributes do
    defstruct device: :nil, size: :nil, removable: :nil, model: :nil, rev: :nil, state: :nil, timeout: :nil, vendor: :nil, queue_depth: :nil,
    rotational: :nil, physical_block_size: :nil, logical_block_size: :nil
  end

  @doc """
  Return all block device information on a host

  ## Examples

  iex> Fingerprint.Plugins.Linux.BlockDevices.all
  [%Fingerprint.Plugins.Linux.BlockDevices.Attributes{size: 10000, removable: 0}

  """

  def all do
    Enum.map(Path.wildcard("/sys/block/*"), fn(block_device_directory) ->
      size_and_removable(%Attributes{device: device(block_device_directory)}, block_device_directory)
      |> device_info(block_device_directory)
      |> queue_info(block_device_directory)
    end)
  end

  defp size_and_removable(struct, block_device_directory) do
    Enum.reduce(~w{size removable}, struct, fn(attr, acc) ->
      if File.exists?("#{block_device_directory}/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/#{attr}")
        Map.put(acc, String.to_atom(attr), String.trim(data))
      else
        acc
      end
    end)
  end

  defp device_info(struct, block_device_directory) do
    Enum.reduce(~w{model rev state timeout vendor queue_depth}, struct, fn(attr,acc) ->
      if File.exists?("#{block_device_directory}/device/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/device/#{attr}")
        Map.put(acc, String.to_atom(attr), String.trim(data))
      else
        acc
      end
    end)
  end

  defp queue_info(struct, block_device_directory) do
    Enum.reduce(~w{rotational physical_block_size logical_block_size}, struct, fn(attr, acc) ->
      if File.exists?("#{block_device_directory}/queue/#{attr}") do
        {:ok, data} = File.read("#{block_device_directory}/queue/#{attr}")
        Map.put(acc, String.to_atom(attr), String.trim(data))
      else
        acc
      end
    end)
  end

  defp device(block_device_directory) do
    Path.basename(block_device_directory)
  end
end
