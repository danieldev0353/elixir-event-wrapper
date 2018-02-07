defmodule EventSourcingExampleWeb.Router do
  use EventSourcingExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug EventSourcingExampleWeb.Auth.Pipeline
    plug EventSourcingExampleWeb.Auth.CurrentUser
  end

  scope "/api", EventSourcingExampleWeb do
    pipe_through :api

    post "/account", AccountController, :post
    get "/verify", VerifyController, :get
    post "/login", AccountController, :login
  end

  scope "/api", EventSourcingExampleWeb do
    pipe_through [:api, :auth]

  end
end
