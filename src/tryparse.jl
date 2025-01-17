function tryparse_json(response_body::AbstractString)
    response_json = try
        JSON3.read(response_body)
    catch ex
        # If no exception is thrown, we don't need to log `response_body`.
        #
        # However, if an exception is thrown, we need to log the entire raw
        # `response_body` so that the user can try to figure out why it failed to
        # parse as valid JSON.
        bt = catch_backtrace()
        @logmsg LogLevel(-1_000) "FHIRClient.tryparse_json()" response_body exception =
            (ex, bt)
        nothing
    end
    return response_json
end
