module Locales

### Types

abstract type AbstractLocale end
abstract type AbstractSpace<: AbstractLocale end
abstract type AbstractTime <: AbstractLocale end
abstract type GraphicsSpace{NDimensions}  <: AbstractSpace end
abstract type GraphicsTime{FastestPeriod} <: AbstractTime  end

abstract type LocalSpace{LocalBarycenter, BarycentricCoords} <: GraphicsSpace end
abstract type WorldSpace{GlobalOrientaiton, GrassmaianBladeCoords} <: GraphicsSpace end

#=
   If two graphical entities represent adjacent,
   geosynchronous communications satellites
   and they both are slowly rotating, one 
   in the mirror orientation of the other
   (so their fronts face eachother for a moment
    every so often and then move oppositely away)

   The determination of, say thruster corrections,
   will be taking with respect to each local space
   in a manner that makes each satellite's world
   space different from the other satellite's
   world space. So one time does not fit all.
=#

abstract type LocalTime{LocalSpace{BarycentricCoords} <: GraphicsTime end
abstract type WorldTime{WordSpace{GrassmanianBladeCoords}} <: GraphicsTime end

end
