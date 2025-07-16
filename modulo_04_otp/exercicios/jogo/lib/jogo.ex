defmodule Jogo do
  def nova_partida(id) do
    child_spec = {Jogo.Partida, id}
    DynamicSupervisor.start_child(Jogo.PartidaSupervisor, child_spec)
  end
end
