defmodule Fingerprint.Cpu do
  import Fingerprint.Utils
  @callback count() :: Integer.t
  @callback info() :: List.t

  @module use_module(__MODULE__)

  def test do
    @module
  end

  def count() do
    @module.count()
  end

  def info() do
    @module.info()
  end

end
