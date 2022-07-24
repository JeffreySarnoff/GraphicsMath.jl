macro mytest(ex, plus...)
    quote
        @test($ex, $(plus...))
        (() -> @test (@allocated $(ex.args[2])) == 0)()
    end |> esc
end
