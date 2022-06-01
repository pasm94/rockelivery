defmodule LearnOtp do
  # spawn -> to execute async process
  def start, do: spawn(fn -> loop(:rand.uniform(1000)) end)

  def loop(conn) do
    receive do
      {:execute, pid, query} ->
        result = execute_query(conn, query)
        send(pid, {:result, result})
    end

    loop(conn)
  end

  def async_execute_query(server_pid, query) do
    send(server_pid, {:execute, self(), query})
  end

  def result() do
    receive do
      {:result, result} -> result
    after
      5000 -> "Problems on query execution"
    end
  end

  def execute_query(conn, query) do
    :timer.sleep(2000)
    "Conection: #{conn}, result: #{query}"
  end
end

# :observer.start() -> to watch process
# self -> on iex is it the terminal showing the results
