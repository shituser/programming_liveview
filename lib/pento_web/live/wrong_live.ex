defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  on_mount {PentoWeb.UserAuth, :mount_current_user}

  def mount(_params, session, socket) do
    {:ok,
      assign(socket, session_id: session["live_socket_id"])
      |> initial_assigns()
    }
  end

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2><%= @message %></h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
               phx-click="guess"
               phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
      <%= if @user_won do %>
        <hr class="my-8">
        <.link class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
               patch={~p"/guess"}
        >
          Reset game
        </.link>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => number}, socket) do
    cond do
      String.to_integer(number) == socket.assigns.winner ->
        message = "Correct, you got it right this time."
        score = socket.assigns.score + 1
        winner = generate_winner()
        {:noreply,
          assign(socket, message: message, score: score, winner: winner, user_won: true)}
      true ->
        message = "Your guess: #{number}. Wrong. Guess again."
        score = socket.assigns.score - 1
        {:noreply,
          assign(socket, message: message, score: score)}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, initial_assigns(socket)}
  end

  def initial_assigns(socket) do
    assign(
      socket,
      score: 0,
      message: "Make a guess:",
      winner: generate_winner(),
      user_won: false
    )
  end

  defp generate_winner do
    Enum.random(1..10)
  end
end
