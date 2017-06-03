defmodule Fingerprint.OSRelease do

  @moduledoc """
    Returns information from /etc/os-release file
  """

  @release_file Application.get_env(:fingerprint, :os_release)

  @doc """
  release results.

  ## Examples

      iex> Fingerprint.OSRelease.release
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
    data   = Enum.map(stream, fn(i) -> String.trim(i, "\n") |> String.replace(~r/"/, "") |> String.split("=") end)
    build_profile(data, %{})
  end

  defp build_profile([], acc), do: acc
  defp build_profile([h|t], acc) do
    key = String.downcase(List.first(h))
    value = List.last(h)
    acc = Map.put(acc, key, value)
    build_profile(t, acc)
  end
end
