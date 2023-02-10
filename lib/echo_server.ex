defmodule EchoServer do
  require Logger

  def start do
    {:ok, socket} = :gen_tcp.listen(4100, [:binary, active: false, packet: :line])
    Logger.info("Starting echo server")
    accept(socket)
  end

  defp accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    pid = spawn(fn -> recv(conn) end)
    :ok = :gen_tcp.controlling_process(conn, pid)
    send(pid, :start)
    accept(socket)
  end

  defp recv(conn) do
    receive do
      :start ->
        echo(conn)
    end
  end

  defp echo(conn) do
    case :gen_tcp.recv(conn, 0) do
      {:ok, data} ->
        :gen_tcp.send(conn, data)
        echo(conn)

      {:error, :closed} ->
        :ok
    end
  end
end
