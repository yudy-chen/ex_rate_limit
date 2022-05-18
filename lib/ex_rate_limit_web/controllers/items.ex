defmodule ExRateLimitWeb.Items do

    use ExRateLimitWeb, :controller

    def item(conn, params) do
        json conn, %{status: "Hello world"}
    end
    
end