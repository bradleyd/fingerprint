defmodule Fingerprint.Network do
  import Fingerprint.Utils

  @callback addresses() :: List.t

  @module use_module(__MODULE__)

  def addresses() do
    @module.addresses()
  end
end
