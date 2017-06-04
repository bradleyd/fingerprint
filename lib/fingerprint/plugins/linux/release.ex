defmodule Fingerprint.Plugins.Linux.Release do

  @moduledoc """
    Returns information from /etc/os-release file
  """
  defmodule Attributes do
    defstruct name: :nil, hostname: :nil, kernel_version: :nil, version: :nil, id: :nil, pretty_name: :nil, architecture: :nil
  end

  @release_file Application.get_env(:fingerprint, :os_release)

  @doc """
  release results.

  ## Examples

      iex> Fingerprint.OS.Release.release
      %Fingerprint.Plugins.Linux.Release.Attributes{architecture: "x86_64",
      hostname: "bradleyd-900X4C", id: "ubuntu", kernel_version: "4.10.0-20-generic",
      name: "Ubuntu", pretty_name: "Ubuntu 17.04", version: "17.04 (Zesty Zapus)"}
  """
  def release do
    stream = File.stream!(@release_file)
    data   = parse_release_file(stream)
    build_release(data, %Attributes{architecture: architecture(), hostname: hostname(), kernel_version: kernel_version()})
  end

  # TODO to_atom may be rude
  defp build_release([], acc), do: acc
  defp build_release([h|t], acc) do
    key   = String.downcase(List.first(h)) |> String.to_atom
    value = List.last(h)
    acc   = struct(acc, %{key => value})
    build_release(t, acc)
  end

  defp parse_release_file(stream) do
    Enum.map(stream, fn(line) ->
      remove_newlines(line)
      |> remove_escaped_strings()
      |> split_key_and_values()
    end)
  end
  defp remove_newlines(str) do
    String.trim(str, "\n")
  end
  defp remove_escaped_strings(str) do
    String.replace(str, ~r/"/, "")
  end
  defp split_key_and_values(str) do
    String.split(str, "=")
  end
  defp architecture() do
    {data, 0} = System.cmd("uname", ["-m"])
    String.trim(data)
  end
  defp kernel_version() do
    {data, 0} = System.cmd("uname", ["-r"])
    String.trim(data)
  end
  defp hostname() do
    {:ok, hostname} = :inet.gethostname
    to_string(hostname) |> String.trim()
  end

end
