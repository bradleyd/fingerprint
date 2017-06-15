defmodule Fingerprint.Filesystem do
  import Fingerprint.Utils
  @callback all() :: List.t
  @callback all(:human) :: List.t

  @module use_module(__MODULE__)

  def all() do
    @module.all()
  end

  def all(:human) do
    @module.all(:human)
  end


end
