
'''
    reference: https://blog.danielberkompas.com/2015/06/16/rate-limiting-a-phoenix-api/
'''

defmodule ExRateLimit.Limitter do

    import Phoenix.Controller, only: [json: 2]
    import Plug.Conn, only: [put_status: 2, halt: 1]
    import ExRated

    def rate_limit(conn, options) do

        interval_milliseconds = options[:interval_seconds] * 1000
        max_request = options[:max_requests]

        check_result = ExRated.check_rate("limit-bucket", interval_milliseconds, max_request)
        
        case check_result do
          {:ok, _}   -> conn
          {:error, _} -> render_error(conn)
        end

    end

    defp render_error(conn) do
        conn
        |> put_status(:forbidden)
        |> json(%{error: "Rate limit exceeded."})
        |> halt
    end
    
end