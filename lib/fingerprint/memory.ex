defmodule Fingerprint.Memory do
  import Fingerprint.Utils

  @callback all() :: Map.t

  @module use_module(__MODULE__)

  def all() do
    @module.all()
  end
end
