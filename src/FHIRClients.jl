module FHIRClients

import DocStringExtensions
import HTTP
import HealthBase
import JSON3
# import OMOPCommonDataModel
import Pkg
import StructTypes

export FHIRBaseURL
export FHIRClient
export FHIREndpoint
export FHIRType

include("types.jl")

include("requests.jl")
include("version.jl")

end # end module FHIRClients
