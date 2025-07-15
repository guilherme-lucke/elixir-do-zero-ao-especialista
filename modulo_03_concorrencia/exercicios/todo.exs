defmodule Todo do
  def iniciar() do
    estado_inicial = %{next_id: 1, tasks: %{}}
    spawn(fn -> loop(estado_inicial) end)
  end

  defp loop(estado) do
    receive do
      {:add, descricao, remetente} ->
        id_atual = estado.next_id
        # Adiciona a nova tarefa ao mapa de tarefas.
        novas_tarefas = Map.put(estado.tasks, id_atual, descricao)
        # Cria o novo estado completo.
        novo_estado = %{
          next_id: id_atual + 1,
          tasks: novas_tarefas
        }
        send(remetente, {:ok, id_atual})
        loop(novo_estado)

      {:list, remetente} ->
        send(remetente, {:tasks, estado.tasks})
        loop(estado)
    end
  end
end

# --- Área de Testes ---

# Para testar no iex:
# iex> pid_todo = Todo.iniciar()
# iex> send(pid_todo, {:add, "Comprar pão", self()}); flush()
# {:ok, 1}
# iex> send(pid_todo, {:add, "Estudar Elixir", self()}); flush()
# {:ok, 2}
# iex> send(pid_todo, {:list, self()}); flush()
# {:tasks, %{1 => "Comprar pão", 2 => "Estudar Elixir"}}

pid_todo = Todo.iniciar()

send(pid_todo, {:add, "Comprar pão", self()})
receive do
  {:ok, id} -> IO.puts("Tarefa adicionada com ID #{id}")
after
  1000 -> IO.puts("Erro: não recebeu resposta do processo")
end

send(pid_todo, {:add, "Estudar Elixir", self()})
receive do
  {:ok, id} -> IO.puts("Tarefa adicionada com ID #{id}")
after
  1000 -> IO.puts("Erro: não recebeu resposta do processo")
end

send(pid_todo, {:list, self()})
receive do
  {:tasks, tarefas} ->
    IO.puts("Tarefas cadastradas:")
    Enum.each(tarefas, fn {id, descricao} ->
      IO.puts("##{id}: #{descricao}")
    end)
after
  1000 -> IO.puts("Erro: não recebeu lista de tarefas")
end
