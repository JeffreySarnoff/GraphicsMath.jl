using GraphicsMath
using Documenter

DocMeta.setdocmeta!(GraphicsMath, :DocTestSetup, :(using GraphicsMath); recursive=true)

makedocs(;
    modules=[GraphicsMath],
    authors="Michael Fiano <mail@mfiano.net> and contributors",
    repo="https://github.com/JuliaGameDev/GraphicsMath.jl/blob/{commit}{path}#{line}",
    sitename="GraphicsMath.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaGameDev.github.io/GraphicsMath.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaGameDev/GraphicsMath.jl",
    devbranch="main",
)
