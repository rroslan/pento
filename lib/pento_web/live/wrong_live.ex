defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_param, _session, socket) do

    {:ok, assign(socket, time: time(), message: "Guess a number", score: 0)}

  end


  def handle_event("guess", %{"number" => guess}, socket) do

    rnd = Enum.random(1..10)
    guess = String.to_integer(guess)


    case rnd - guess do

    0 ->
      message = "You guess right, you guess #{guess}"
      score = socket.assigns.score + 10
      time = time()
      {:noreply, assign(socket, message: message, score: score, time: time)}
    _ ->

      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1
      time = time()
      {:noreply, assign(socket, message: message, score: score, time: time)}
    end
end

  def time do
    {:ok, datetime} = DateTime.now("Asia/Kuala_Lumpur")
    datetime |> to_string |> String.slice(0, 24)

  end
end
