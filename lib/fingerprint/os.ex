defmodule Fingerprint.OS do
  defmodule Release do
    defstruct name: :nil, version: :nil, id: :nil, pretty_name: :nil
  end

  def profile do
    stream = File.stream!("/etc/os-release")
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
