defmodule Fingerprint.Utils do
  # TODO not sure this is a great way to get module name
  defmacro use_module(name) do
    quote do
      base_module = String.split(to_string(unquote(name)), ".") |> List.last
      case :os.type() do
        {:unix, :linux} ->
          {mod,[]} = "Fingerprint.Plugins.Linux" <> ".#{base_module}" |> Code.eval_string
          mod
      end
    end
  end
end
