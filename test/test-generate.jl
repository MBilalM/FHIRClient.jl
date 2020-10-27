using Test
import Generate

module TestGenerate
    using Test
    import ..Generate
    const JSON3 = Generate.JSON3

    function test_generate(fhir_version::AbstractString)
        url = "https://www.hl7.org/fhir/$(fhir_version)/definitions.json.zip"
        json_definitions = Generate.download_fhir_json_schema(url)
        schema_string = json_definitions["fhir.schema.json.zip"]["fhir.schema.json"]
        temp_dir = mktempdir(; cleanup = true)
        output_file = joinpath(temp_dir, "autogenerated-$(fhir_version).jl")
        @test !isfile(output_file)
        @test !ispath(output_file)
        Generate.output_fhir_types(; schema_string = schema_string, output_file = output_file)
        @test isfile(output_file)
        @test ispath(output_file)
        s = strip(read(output_file, String))
        @test length(s) > 10_000
        return output_file
    end

    module TestGenerate_R4
        using Test
        import ..Generate
        const JSON3 = Generate.JSON3
        import ..test_generate
        output_file = test_generate("R4")
        @test !(@isdefined Patient)
        include(output_file)
        @test @isdefined Patient
    end
end # end module TestGenerate
