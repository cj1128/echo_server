defmodule EchoServer do
  require Logger

  def start do
    {:ok, socket} = :gen_tcp.listen(4100, [:binary, active: false, packet: :line])
    Logger.info("Starting echo server")
    accept(socket)
  end

  defp accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    spawn(fn -> recv(conn) end)
    accept(socket)
  end

  defp recv(conn) do
    case :gen_tcp.recv(conn, 0) do
      {:ok, data} ->
        :gen_tcp.send(conn, data)
        recv(conn)

      {:error, :closed} ->
        :ok
    end
  end
end
