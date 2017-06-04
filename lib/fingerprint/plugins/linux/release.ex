defmodule Fingerprint.Plugins.Linux.Release do

  @moduledoc """
    Returns information from /etc/os-release file
  """
  defmodule Attributes do
    defstruct name: :nil, version: :nil, id: :nil, pretty_name: :nil
  end

  @release_file Application.get_env(:fingerprint, :os_release)

  @doc """
  release results.

  ## Examples

      iex> Fingerprint.OS.Release.parse
      %{"bug_report_url" => "https://bugs.launchpad.net/ubuntu/",
      "home_url" => "https://www.ubuntu.com/", "id" => "ubuntu",
      "id_like" => "debian", "name" => "Ubuntu",
      "pretty_name" => "Ubuntu 17.04",
      "privacy_policy_url" => "https://www.ubuntu.com/legal/terms-and-policies/privacy-policy",
      "support_url" => "https://help.ubuntu.com/",
      "ubuntu_codename" => "zesty", "version" => "17.04 (Zesty Zapus)",
      "version_codename" => "zesty", "version_id" => "17.04"}


  """
  def release do
    stream = File.stream!(@release_file)
    data   = parse_release_file(stream)
    build_release(data, %{})
  end

  # TODO to_atom may be rude to other systems
  defp build_release([], acc), do: struct(%Attributes{}, acc)
  defp build_release([h|t], acc) do
    key   = String.downcase(List.first(h))
    value = List.last(h)
    acc   = Map.put(acc, String.to_atom(key), value)
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
end
