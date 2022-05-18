defmodule ExRateLimitWeb.Router do
  use ExRateLimitWeb, :router
  import ExRateLimit.Limitter

  pipeline :api do
    plug :rate_limit, [{:max_requests, 60}, {:interval_seconds, 60}]
    plug :accepts, ["json"]
  end

  scope "/api", ExRateLimitWeb do
    pipe_through :api
    get "/item", Items, :item
  end
end
