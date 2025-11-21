### A Pluto.jl notebook ###
# v0.20.17

using Markdown
using InteractiveUtils

# ╔═╡ 5546d670-b0cf-11f0-0c74-e18a04df526d
using CSV, DataFrames, Colors, Measurements, Plots, Measures, ColorSchemes, NearestNeighbors, Statistics, PlutoUI, StatsBase   

# ╔═╡ 65be33b5-fe67-4d0e-a25f-6c50e705caa6
begin
	#Layers 
	#crime
	file_path = "C:\\Users\\Acs\\Downloads\\Crime_Data_from_2020_to_Present.csv"
	#Boundry
	boundry = "C:\\Users\\Acs\\Downloads\\City_Boundary_of_Los_Angeles.csv"
	#Lights
	lights = "C:\\Users\\Acs\\Downloads\\STLIGHT.csv"
end

# ╔═╡ 096415a2-b7fe-43b5-9a69-45b2464b8db9
data_csv = CSV.read(file_path, DataFrame)

# ╔═╡ 17c5b77d-18d6-401e-884f-4527ec6aa151
df = select(data_csv, :LAT, :LON, :7 => :Dist)


# ╔═╡ 6a6adf42-e6fc-4d9c-80dc-529d80a37f30
df_g = groupby(df, :Dist)

# ╔═╡ f04c25c8-17cb-4806-86e4-d46a1141333e
df_c = sort(combine(df_g, nrow => :Crime_Counts))

# ╔═╡ 32f4bb40-2235-479c-8bc0-6c3ecb76b984
df_c_sorted = sort(df_c, :Crime_Counts, rev = true)

# ╔═╡ 19cc5ae0-a07a-468e-a132-cfdbf4455d69
df_top_500 = df_c_sorted[1:500, :]

# ╔═╡ 17518608-734d-4da3-b3b5-5451696f8c52
begin
	n = nrow(df_top_500)
	cols = palette(:blues, n)

	bar(
		string.(df_top_500.Dist),
		df_top_500.Crime_Counts;
		fillcolor = cols,
		linecolor = :black,
		lw = 0.3,
		legend = false,
		bar_width = 0.8,
		grid = true,
		gridalpha = 0.3,
		gridstyle = :dash,
		framestyle = :box,
		xlabel = "District Number",
		ylabel = "Crime Count",
		title = "Top 500 Districts by Crime Frequency in Los Angeles",
		xrotation = 45,
		tickfont = font("Times New Roman", 9),
		guidefont = font("Times New Roman", 11, :bold),
		titlefont = font("Times New Roman", 12, :bold),
		size = (900, 600),
		dpi = 600,
		margin = 5mm
	)
end

# ╔═╡ a373e3ae-8bd4-467b-9b65-561762c7ce61
let 
bar(
    1:nrow(df_top_500), df_top_500.Crime_Counts;
    xlabel = "Ranked Districts",
    ylabel = "Crime Count",
    xticks = (1:50:500, string.(df_top_500.Dist[1:50:500])),  # label every 50th bar
    fillcolor = palette(:blues, nrow(df_top_500)),
    linecolor = :black,
    lw = 0.3,
    legend = false,
    grid = true,
    gridalpha = 0.3,
    gridstyle = :dash,
    framestyle = :box,
    title = "Crime Frequency by District (Top 500)"
)

end

# ╔═╡ b8cbb720-4a14-4456-b618-7dada03c00ed
begin
nc = nrow(df_top_500)
colsc = palette(:blues, nc)

scatter(
    1:n, df_top_500.Crime_Counts;
    xlabel = "Ranked Districts",
    ylabel = "Crime Count",
    title = "Top 500 Districts by Crime Frequency in Los Angeles",
    legend = false,
    markersize = 4,
    markercolor = colsc,
    markerstrokecolor = :black,
    markerstrokewidth = 0.2,
    grid = true,
    gridalpha = 0.3,
    gridstyle = :dash,
    framestyle = :box,
    xrotation = 0,
    tickfont = font("Times New Roman", 9),
    guidefont = font("Times New Roman", 11, :bold),
    titlefont = font("Times New Roman", 12, :bold),
    size = (900, 600),
    dpi = 600
)

end

# ╔═╡ ab9757eb-f5bc-480b-af5c-7ad71d9841d6
let
nc = nrow(df_top_500)
colsc = palette(:blues, nc)

scatter(
    1:n, df_top_500.Crime_Counts;
    xlabel = "Ranked Districts",
    ylabel = "Crime Count",
    title = "Top 500 Districts by Crime Frequency in Los Angeles",
    legend = false,
    markersize = 4,
    markercolor = colsc,
    markerstrokecolor = :black,
    markerstrokewidth = 0.2,
    grid = true,
    gridalpha = 0.3,
    gridstyle = :dash,
    framestyle = :box,
    xrotation = 0,
    tickfont = font("Times New Roman", 9),
    guidefont = font("Times New Roman", 11, :bold),
    titlefont = font("Times New Roman", 12, :bold),
    size = (900, 600),
    dpi = 600
)
	bar!(
    1:nrow(df_top_500), df_top_500.Crime_Counts;
    xlabel = "Ranked Districts",
    ylabel = "Crime Count",
    xticks = (1:50:500, string.(df_top_500.Dist[1:50:500])),  # label every 50th bar
    fillcolor = palette(:blues, nrow(df_top_500)),
    linecolor = :black,
    lw = 0.3,
    legend = false,
    grid = true,
    gridalpha = 0.3,
    gridstyle = :dash,
    framestyle = :box,
    title = "Crime Frequency by District (Top 500)"
)
end

# ╔═╡ b4f6ce7e-2d7d-4884-adc2-3554a848f22b
df2 = select(data_csv, :LAT, :LON, :7 => :Dist)

# ╔═╡ 7fa4103b-4402-4b95-aa00-2978efd46527
begin
# file paths to your CSVs (strings)
lights_csv   = lights    # e.g., "/path/to/street_lights.csv"
end


# ╔═╡ b5012d15-541a-4901-9560-fa8e7f6a3f17
begin
# file paths to your CSVs (strings)
boundary_csv = boundry   # e.g., "/path/to/city_boundary.csv"
end

# ╔═╡ 69a842a1-46d1-44b6-96b8-3b1b76f5d841
begin
	data_lights = CSV.read(lights_csv, DataFrame)

end

# ╔═╡ 27ad33df-f559-4835-8b59-8868ae79121f
begin
	data_boundry = CSV.read(boundary_csv, DataFrame)

end

# ╔═╡ b004b000-4522-415e-ba22-75bd0065dc92
function parse_point_wkt(s::AbstractString)
    if (m = match(r"POINT\s*\(\s*([+-]?\d+(?:\.\d+)?)\s+([+-]?\d+(?:\.\d+)?)\s*\)", s)) !== nothing
        return parse(Float64, m.captures[1]), parse(Float64, m.captures[2])
    end
    return nothing
end

# ╔═╡ 63a9bbec-ddd3-4980-adcc-dfb299db9845
begin
	# pick the WKT column (adjust name if needed)
	wktcol = :the_geom
	@assert hasproperty(data_lights, wktcol) "Column `the_geom` not found in data_lights"
	
end

# ╔═╡ ccea3727-073a-422c-a42e-721c38520423
begin
	# build lon/lat arrays + keep only rows with valid points
lons = Float64[]; lats = Float64[]; keep = Int[]
for (i, g) in enumerate(data_lights[!, wktcol])
    if g !== missing
        p = parse_point_wkt(String(g))
        if p !== nothing
            push!(lons, p[1]); push!(lats, p[2]); push!(keep, i)
        end
    end
end

df_pts = data_lights[keep, :]              # filtered copy
df_pts[!, :lon] = lons
df_pts[!, :lat] = lats

end

# ╔═╡ f8d00b52-765d-4ee2-8d3e-140e67409d94
begin
	# compute padded bounds and plot
xmin, xmax = extrema(df_pts.lon)
ymin, ymax = extrema(df_pts.lat)
padx = max(1e-4, 0.02 * (xmax - xmin))
pady = max(1e-4, 0.02 * (ymax - ymin))

p = scatter(
    df_pts.lon, df_pts.lat;
    markersize = 2,
    markerstrokewidth = 0,
    aspect_ratio = 1,          # equal aspect so map isn’t squished
    xlabel = "Longitude",
    ylabel = "Latitude",
    framestyle = :box,
    xlim = (xmin - padx, xmax + padx),
    ylim = (ymin - pady, ymax + pady),
    title = "LA Street Lights (n=$(nrow(df_pts)))"
)
p

end

# ╔═╡ 7de906aa-ff50-45d6-85e2-e21452679d70
function _groups_at_depth(s::AbstractString, target_depth::Int)
    groups = String[]
    depth = 0
    start = 0
    @inbounds for (i, c) in enumerate(s)
        if c == '('
            depth += 1
            if depth == target_depth
                start = i + 1  # start just after '('
            end
        elseif c == ')'
            if depth == target_depth && start > 0
                push!(groups, s[start:i-1])
                start = 0
            end
            depth -= 1
        end
    end
    return groups
end


# ╔═╡ d0e75de2-f368-4940-814c-891d437e79d7
function parse_polygonish_wkt(wkt::AbstractString)
    s = strip(wkt)
    polys = Vector{Vector{Tuple{Vector{Float64},Vector{Float64}}}}()

    if startswith(uppercase(s), "MULTIPOLYGON")
        inner = strip(s[findfirst('(', s)+1 : findlast(')', s)-1])  # between outer (...)
        # top-level groups at depth=1 are individual POLYGON payloads
        poly_groups = _groups_at_depth(inner, 1)
        for pg in poly_groups
            rings = _groups_at_depth(pg, 1)  # rings inside this polygon
            pr = Vector{Tuple{Vector{Float64},Vector{Float64}}}()
            for rg in rings
                xs = Float64[]; ys = Float64[]
                for token in split(rg, ',')
                    parts = split(strip(token))
                    length(parts) == 2 || continue
                    push!(xs, parse(Float64, parts[1]))
                    push!(ys, parse(Float64, parts[2]))
                end
                push!(pr, (xs, ys))
            end
            push!(polys, pr)
        end

    elseif startswith(uppercase(s), "POLYGON")
        inner = strip(s[findfirst('(', s)+1 : findlast(')', s)-1])  # between outer (...)
        rings = _groups_at_depth(inner, 1)
        pr = Vector{Tuple{Vector{Float64},Vector{Float64}}}()
        for rg in rings
            xs = Float64[]; ys = Float64[]
            for token in split(rg, ',')
                parts = split(strip(token))
                length(parts) == 2 || continue
                push!(xs, parse(Float64, parts[1]))
                push!(ys, parse(Float64, parts[2]))
            end
            push!(pr, (xs, ys))
        end
        push!(polys, pr)

    else
        error("Unsupported WKT type for boundary: expected POLYGON or MULTIPOLYGON.")
    end

    return polys
end


# ╔═╡ e6d8253b-b179-4085-abe2-2fe9e7657a66
begin
@assert hasproperty(data_boundry, :the_geom) "Column `the_geom` not found in data_boundry"
@assert nrow(data_boundry) > 0 "data_boundry is empty"

boundary_wkt = String(data_boundry.the_geom[1])
boundary_polys = parse_polygonish_wkt(boundary_wkt)

end

# ╔═╡ 6b1cf198-429c-4269-8da3-f89bfeabb2b6
# --- normalize parsed boundary to always be: Vector{Vector{(xs,ys)}} ---
function normalize_polys(obj)
    # Case A: already Vector{Vector{Tuple{...}}}  (MULTIPOLYGON style)
    if !(obj isa AbstractVector)
        error("Unexpected boundary structure")
    end
    if !isempty(obj) && obj[1] isa Tuple
        # Case B: Vector{Tuple{...}}  (POLYGON with rings)
        return [obj]  # wrap as a single polygon
    else
        return obj    # already multi-polygons
    end
end


# ╔═╡ 0e23fa53-ea62-495c-a221-ec56a777adbd
begin
	norm_polys = normalize_polys(boundary_polys)
	
	# If you still have the lights scatter plot `p`, overlay; otherwise build a fresh plot.
	if @isdefined p
	    for poly in norm_polys
	        for (xs, ys) in poly
	            plot!(p, xs, ys; lw=1.2, linecolor=:black, alpha=0.9, legend = false)
	        end
	    end
	    display(p)
	else
	    # make a boundary-only map with equal aspect
	    allx = Float64[]; ally = Float64[]
	    for poly in norm_polys, (xs, ys) in poly
	        append!(allx, xs); append!(ally, ys)
	    end
	    xmin1, xmax1 = extrema(allx); ymin1, ymax1 = extrema(ally)
	    padx1 = max(1e-4, 0.02*(xmax1 - xmin1)); pady1 = max(1e-4, 0.02*(ymax1 - ymin1))
	
	    pb = plot(; aspect_ratio=1, framestyle=:box,
	              xlabel="Longitude", ylabel="Latitude",
	              xlim=(xmin - padx1, xmax1 + padx1), ylim=(ymin1 - pady1, ymax1 + pady1),
	              title="LA City Boundary")
	    for poly in norm_polys
	        for (xs, ys) in poly
	            plot!(pb, xs, ys; lw=1.2, linecolor=:black, alpha=0.9)
	        end
	    end
	    pb
	end

	gr(); default(size=(900,700))

# assume: boundary_polys defined; normalize_polys defined; maybe `p` (lights) exists

mapplot = let
    norm_polys = normalize_polys(boundary_polys)

    # If a lights plot `p` exists, overlay on it; otherwise make boundary-only plot
    plot_out =
        if @isdefined p
            for poly in norm_polys
                for (xs, ys) in poly
                    plot!(p, xs, ys; lw=1.2, linecolor=:black, alpha=0.9)
                end
            end
            p
        else
            # build boundary-only plot with equal aspect
            allx = Float64[]; ally = Float64[]
            for poly in norm_polys, (xs, ys) in poly
                append!(allx, xs); append!(ally, ys)
            end
            xmin, xmax = extrema(allx); ymin, ymax = extrema(ally)
            padx = max(1e-4, 0.02*(xmax - xmin)); pady = max(1e-4, 0.02*(ymax - ymin))

            pb = plot(; aspect_ratio=1, framestyle=:box,
                      xlabel="Longitude", ylabel="Latitude",
                      xlim=(xmin1 - padx, xmax1 + padx), ylim=(ymin1 - pady, ymax1 + pady),
                      title="LA City Boundary")
            for poly in norm_polys
                for (xs, ys) in poly
                    plot!(pb, xs, ys; lw=1.2, linecolor=:black, alpha=0.9)
                end
            end
            display(pb)
        end

    plot_out  # ← IMPORTANT: last line returns the Plot object for Pluto to render
end
	
end

# ╔═╡ 2bb66d09-53d7-4d6b-8f9c-9ce78b17fbc9
df_coordinates = select(data_csv, :LAT, :LON)


# ╔═╡ 12a11760-e615-4b94-b04b-7237d1d6d891
let
    gr(); default(size=(1800,1300), dpi=220, legend=false)

    @assert isdefined(@__MODULE__, :boundary_polys) "Run the boundary parsing cell first."
    @assert isdefined(@__MODULE__, :df_pts) "Run the lights parsing cell first (creates df_pts with :lon/:lat)."

    # Prepare crime coordinates
    if isdefined(@__MODULE__, :df_coordinates)
        df_crime = select(df_coordinates, :LON => :lon, :LAT => :lat)
    else
        @assert (:LAT ∈ names(data_csv) && :LON ∈ names(data_csv)) "Need :LAT and :LON in data_csv"
        df_crime = select(data_csv, :LON => :lon, :LAT => :lat)
    end
    df_crime = dropmissing(df_crime)
    df_crime = filter(:lon => x -> x isa Real && !isnan(x), df_crime)
    df_crime = filter(:lat => x -> x isa Real && !isnan(x), df_crime)

    # ---- safe handle for normalize_polys without shadowing ----
    _normalize_polys = isdefined(@__MODULE__, :normalize_polys) ?
        getfield(@__MODULE__, :normalize_polys) :
        (obj -> ((!isempty(obj) && obj[1] isa Tuple) ? [obj] : obj))

    norm_polys = _normalize_polys(boundary_polys)

    # Boundary bounds
    bx = Float64[]; by = Float64[]
    for poly in norm_polys, (xs, ys) in poly
        append!(bx, xs); append!(by, ys)
    end
    bxmin, bxmax = extrema(bx); bymin, bymax = extrema(by)

    # Clip crimes to city bbox
    df_crime = filter(row -> (bxmin <= row.lon <= bxmax) && (bymin <= row.lat <= bymax), df_crime)

    # Combined bounds
    allx = [bx; df_pts.lon; df_crime.lon]
    ally = [by; df_pts.lat; df_crime.lat]
    xmin, xmax = extrema(allx); ymin, ymax = extrema(ally)
    padx = max(1e-4, 0.02*(xmax - xmin)); pady = max(1e-4, 0.02*(ymax - ymin))

    # Compose map
    plt = plot(; aspect_ratio=1, framestyle=:box,
               xlabel="Longitude", ylabel="Latitude",
               xlim=(xmin - padx, xmax + padx), ylim=(ymin - pady, ymax + pady),
               legend=false)

    # Boundary outline
    for poly in norm_polys
        for (xs, ys) in poly
            plot!(plt, xs, ys; lw=1.4, linecolor=:black, alpha=0.95, label=false)
        end
    end

    # Lights (faint)
    scatter!(plt, df_pts.lon, df_pts.lat;
             markersize=1.5, markerstrokewidth=0, alpha=0.30, label=false)

    # Crimes (highlight)
    scatter!(plt, df_crime.lon, df_crime.lat;
             markersize=3.0, markerstrokewidth=0, alpha=0.75, color=:red, label=false)

    plt
end


# ╔═╡ 589e6baa-4dfd-45cd-98d6-912638ff4a01
let
    gr(); default(size=(1800,1300), dpi=500, legend=false)

    @assert isdefined(@__MODULE__, :boundary_polys) "Run the boundary parsing cell first."
    @assert isdefined(@__MODULE__, :df_pts) "Run the lights parsing cell first (creates df_pts with :lon/:lat)."

    # Prepare crime coordinates
    if isdefined(@__MODULE__, :df_coordinates)
        df_crime = select(df_coordinates, :LON => :lon, :LAT => :lat)
    else
        @assert (:LAT ∈ names(data_csv) && :LON ∈ names(data_csv)) "Need :LAT and :LON in data_csv"
        df_crime = select(data_csv, :LON => :lon, :LAT => :lat)
    end
    df_crime = dropmissing(df_crime)
    df_crime = filter(:lon => x -> x isa Real && !isnan(x), df_crime)
    df_crime = filter(:lat => x -> x isa Real && !isnan(x), df_crime)

    # ---- normalize polys ----
    _normalize_polys = isdefined(@__MODULE__, :normalize_polys) ?
        getfield(@__MODULE__, :normalize_polys) :
        (obj -> ((!isempty(obj) && obj[1] isa Tuple) ? [obj] : obj))
    norm_polys = _normalize_polys(boundary_polys)

    # Boundary bounds
    bx = Float64[]; by = Float64[]
    for poly in norm_polys, (xs, ys) in poly
        append!(bx, xs); append!(by, ys)
    end
    bxmin, bxmax = extrema(bx); bymin, bymax = extrema(by)

    # Clip crimes to city bbox
    df_crime = filter(row -> (bxmin <= row.lon <= bxmax) && (bymin <= row.lat <= bymax), df_crime)

    # Combined bounds
    allx = [bx; df_pts.lon; df_crime.lon]
    ally = [by; df_pts.lat; df_crime.lat]
    xmin, xmax = extrema(allx); ymin, ymax = extrema(ally)
    padx = max(1e-4, 0.02*(xmax - xmin)); pady = max(1e-4, 0.02*(ymax - ymin))

    # ---- tuning knobs (adjust if it feels too light/dark) ----
    lights_ms     = 1.0
    lights_alpha  = 0.06    # very faint so overlaps don't overwhelm
    crimes_ms     = 2.4
    crimes_alpha  = 0.08    # faint => darker where many crimes stack

    # Compose map
    plt = plot(; aspect_ratio=1, framestyle=:box,
               xlabel="Longitude", ylabel="Latitude",
               xlim=(xmin - padx, xmax + padx), ylim=(ymin - pady, ymax + pady),
               legend=false)

    # Boundary outline
    for poly in norm_polys
        for (xs, ys) in poly
            plot!(plt, xs, ys; lw=1.2, linecolor=:black, alpha=0.9, label=false)
        end
    end

    # Lights (faint, cool hue)
    scatter!(plt, df_pts.lon, df_pts.lat;
             markersize=lights_ms, markerstrokewidth=0,
             alpha=lights_alpha, color=:blue, label=false)

    # Crimes (on top, faint but larger so stacking darkens)
    scatter!(plt, df_crime.lon, df_crime.lat;
             markersize=crimes_ms, markerstrokewidth=0,
             alpha=crimes_alpha, color=:Crimson, label=false)

    plt
end


# ╔═╡ ff17c734-d29d-49ba-ab9d-b9e64f6d34f6
begin

    # --- helper to find likely lon/lat columns (case/underscore insensitive) ---
    find_col(tbl, candidates) = let
        cols = names(tbl)
        norm(s) = lowercase(replace(String(s), r"[^a-z0-9]" => ""))
        bynorm = Dict(norm(c) => c for c in cols)
        for c in candidates
            k = norm(c)
            if haskey(bynorm, k)
                return bynorm[k]
            end
        end
        error("None of the candidate columns found: $(candidates)")
    end

    to_float(v) = Float64[
        x === missing || x === nothing ? NaN :
        x isa Real ? float(x) :
        try parse(Float64, String(x)) catch; NaN end
        for x in v
    ]

    @assert isdefined(@__MODULE__, :df) "Define `df` first (your lights DataFrame)."

    lonc = find_col(df, ["lon","longitude","x","long","lng","X","LONGITUDE","Shape@X"])
    latc = find_col(df, ["lat","latitude","y","Y","LATITUDE","Shape@Y"])

    # Standardize to :lon/:lat and clean
    df_pts1 = DataFrame(lon = to_float(df[!, lonc]), lat = to_float(df[!, latc]))
    df_pts1 = filter(:lon => isfinite, df_pts)
    df_pts1 = filter(:lat => isfinite, df_pts)
end

# ╔═╡ 4852e810-c3a9-4dae-9838-c6730deb615c
let
    gr(); default(size=(1800,1300), dpi=220, legend=false)

    @assert isdefined(@__MODULE__, :boundary_polys) "Run the boundary parsing cell first."
    @assert isdefined(@__MODULE__, :df_pts) "Run the lights parsing cell first (creates df_pts with :lon/:lat)."

    # --- collect crime coordinates from either df_coordinates or data_csv ---
    local df_crime_raw
    if isdefined(@__MODULE__, :df_coordinates)
        df_crime_raw = select(df_coordinates, :LON => :lon, :LAT => :lat)
    elseif isdefined(@__MODULE__, :data_csv)
        @assert (:LAT ∈ names(data_csv) && :LON ∈ names(data_csv)) "Need :LAT and :LON in data_csv"
        df_crime_raw = select(data_csv, :LON => :lon, :LAT => :lat)
    else
        error("Provide either `df_coordinates` or `data_csv` with :LON/:LAT")
    end

    df_crime = dropmissing(df_crime_raw, [:lon, :lat])
    df_crime = filter(:lon => x -> x isa Real && isfinite(x), df_crime)
    df_crime = filter(:lat => x -> x isa Real && isfinite(x), df_crime)

    # ---- safe handle for normalize_polys without shadowing ----
    _normalize_polys = isdefined(@__MODULE__, :normalize_polys) ?
        getfield(@__MODULE__, :normalize_polys) :
        (obj -> ((!isempty(obj) && obj[1] isa Tuple) ? [obj] : obj))

    norm_polys = _normalize_polys(boundary_polys)

    # Boundary bounds
    bx = Float64[]; by = Float64[]
    for poly in norm_polys, (xs, ys) in poly
        append!(bx, xs); append!(by, ys)
    end
    bxmin, bxmax = extrema(bx); bymin, bymax = extrema(by)

    # Clip crimes to city bbox
    df_crime = filter(row -> (bxmin <= row.lon <= bxmax) && (bymin <= row.lat <= bymax), df_crime)

    # Combined bounds for plotting window
    allx = vcat(bx, df_pts.lon, df_crime.lon)
    ally = vcat(by, df_pts.lat, df_crime.lat)
    xmin, xmax = extrema(allx); ymin, ymax = extrema(ally)
    padx = max(1e-4, 0.02*(xmax - xmin)); pady = max(1e-4, 0.02*(ymax - ymin))

    # Compose map
    plt = plot(; aspect_ratio=1, framestyle=:box,
               xlabel="Longitude", ylabel="Latitude",
               xlim=(xmin - padx, xmax + padx), ylim=(ymin - pady, ymax + pady),
               legend=false)

    # Boundary outline
    for poly in norm_polys
        for (xs, ys) in poly
            plot!(plt, xs, ys; lw=1.4, linecolor=:black, alpha=0.95, label=false)
        end
    end

    # Lights (faint)
    scatter!(plt, df_pts.lon, df_pts.lat;
             markersize=1.5, markerstrokewidth=0, alpha=0.30, label=false)

    # Crimes (highlight)
    scatter!(plt, df_crime.lon, df_crime.lat;
             markersize=3.0, markerstrokewidth=0, alpha=0.75, color=:red, label=false)

    plt
end


# ╔═╡ 1930f6c6-323f-4bfa-9b62-199963d78713
begin
    @assert isdefined(@__MODULE__, :data_lights) "Load lights CSV into `data_lights` first."

    # Try to detect a WKT column like:  POINT ( -118.41 34.21 )
    const RX_POINT = r"POINT\s*\(\s*([+-]?\d+(?:\.\d+)?)\s+([+-]?\d+(?:\.\d+)?)\s*\)"
    function find_wkt_col(df::AbstractDataFrame)
        for c in names(df)
            col = df[!, c]
            hits = 0
            for v in col
                v === missing && continue
                occursin(RX_POINT, string(v)) && (hits += 1)
                hits ≥ 3 && return c           # enough evidence
            end
        end
        return nothing
    end

    parse_xy_wkt = function (s)
        s === missing && return (lon=missing, lat=missing)
        m = match(RX_POINT, string(s))
        m === nothing && return (lon=missing, lat=missing)
        (lon = parse(Float64, m.captures[1]),
         lat = parse(Float64, m.captures[2]))
    end

    # Fallback: common numeric lon/lat headers
    function find_numeric_lonlat(df::AbstractDataFrame)
        lon_candidates = (:LON, :Lon, :lon, :LONGITUDE, :Longitude, :longitude, :X, Symbol("Shape@X"))
        lat_candidates = (:LAT, :Lat, :lat, :LATITUDE, :Latitude, :latitude, :Y, Symbol("Shape@Y"))
        loncol = findfirst(c -> c ∈ names(df), lon_candidates)
        latcol = findfirst(c -> c ∈ names(df), lat_candidates)
        return (loncol === nothing ? nothing : lon_candidates[loncol]),
               (latcol === nothing ? nothing : lat_candidates[latcol])
    end

    # Build the new coordinates DataFrame
    src = data_lights
    if (wktcol1 = find_wkt_col(src)) !== nothing
        df_lights_coords = select(src, wktcol1 => ByRow(parse_xy_wkt) => AsTable)
    else
        loncol, latcol = find_numeric_lonlat(src)
        @assert loncol !== nothing && latcol !== nothing "No WKT column found and no numeric lon/lat columns detected."
        # be tolerant of strings in numeric columns
        tofloat(v) = v === missing ? missing :
                     v isa Real    ? float(v) :
                     try parse(Float64, string(v)) catch; missing end
        df_lights_coords = DataFrame(
            lat = tofloat.(src[!, latcol]),
			lon = tofloat.(src[!, loncol]),

        )
    end

    # drop rows we couldn't parse
    df_lights_coords = dropmissing(df_lights_coords, [:lon, :lat])
end

# ╔═╡ bcbccb25-175c-4017-9f6a-899a38d4513d
light_cord = Matrix(df_lights_coords)

# ╔═╡ 87510e53-efdd-4eb7-8323-da7930a6e838
crime_happened = select(data_csv, :LON, :LAT)

# ╔═╡ 6d29b022-058b-415c-a637-703fc74a20e1
crime_cord = Matrix(crime_happened)

# ╔═╡ 4072c3ae-2e5a-4d8d-b1a9-6c13a29c14a3
begin
    # ---- helpers (local) ----
    pickname(df, alts) = begin
        for a in alts
            if a ∈ names(df); return a; end
        end
        nothing
    end
    tofloat_local(v) = v === missing ? missing :
                       v isa Real    ? float(v) :
                       try parse(Float64, string(v)) catch; missing end

    # =========================
    # Lights -> light_cord
    # =========================
    if isdefined(@__MODULE__, :light_cord) && light_cord isa AbstractMatrix
        # already provided as matrix [lon lat]
        light_mat = Matrix(light_cord)
    else
        # find a DataFrame for lights under various names/types
        _lights_df = nothing
        if isdefined(@__MODULE__, :df_slights_coord) && df_slights_coord isa DataFrame
            _lights_df = df_slights_coord
        elseif isdefined(@__MODULE__, :df_slights_coords)
            tmp = getfield(@__MODULE__, :df_slights_coords)
            _lights_df = tmp isa DataFrame ? tmp :
                         (tmp isa Tuple && !isempty(tmp) && first(tmp) isa DataFrame ? first(tmp) : nothing)
        elseif isdefined(@__MODULE__, :df_lights_coords) && df_lights_coords isa DataFrame
            _lights_df = df_lights_coords
        end
        @assert _lights_df !== nothing "Couldn't find lights data as a DataFrame or matrix."

        lonL = pickname(_lights_df, (:lon,:LON,:Longitude,:LONGITUDE,:X,Symbol("Shape@X")))
        latL = pickname(_lights_df, (:lat,:LAT,:Latitude,:LATITUDE,:Y,Symbol("Shape@Y")))
        @assert lonL !== nothing && latL !== nothing "Lights: no lon/lat columns found."

        dfl_clean = dropmissing(DataFrame(
            lon = tofloat_local.(_lights_df[!, lonL]),
            lat = tofloat_local.(_lights_df[!, latL])
        ))
        light_mat = Matrix(select(dfl_clean, :lon, :lat))
    end

    # =========================
    # Crimes -> crime_cord
    # =========================
    if isdefined(@__MODULE__, :crime_cord) && crime_cord isa AbstractMatrix
        crime_mat = Matrix(crime_cord)
    else
        _crimes_df = nothing
        if isdefined(@__MODULE__, :df_crimes_coord) && df_crimes_coord isa DataFrame
            _crimes_df = df_crimes_coord
        elseif isdefined(@__MODULE__, :df_crimes_coords) && df_crimes_coords isa DataFrame
            _crimes_df = df_crimes_coords
        elseif isdefined(@__MODULE__, :crime_happened) && crime_happened isa DataFrame
            _crimes_df = crime_happened
        end
        @assert _crimes_df !== nothing "Couldn't find crimes data as a DataFrame or matrix."

        lonC = pickname(_crimes_df, (:LON,:lon,:Longitude,:LONGITUDE,:X))
        latC = pickname(_crimes_df, (:LAT,:lat,:Latitude,:LATITUDE,:Y))
        @assert lonC !== nothing && latC !== nothing "Crimes: no LON/LAT (or lon/lat) columns found."

        dfc_clean = dropmissing(DataFrame(
            lon = tofloat_local.(_crimes_df[!, lonC]),
            lat = tofloat_local.(_crimes_df[!, latC])
        ))
        crime_mat = Matrix(select(dfc_clean, :lon, :lat))
    end

    # expose canonical matrices for downstream cells
    global light_cord1 = light_mat
    global crime_cord1 = crime_mat
end


# ╔═╡ 26e6d7a9-02df-49b1-81e1-fce419545a51
begin

    @assert size(light_cord1,2) == 2 "light_cord1 must be N×2 [lon lat]"
    @assert size(crime_cord1,2)  == 2 "crime_cord1 must be M×2 [lon lat]"

    # local equirectangular projection (accurate enough at city scale)
    R_earth = 6_371_000.0
    lat0 = mean(light_cord1[:,2]); lon0 = mean(light_cord1[:,1])
    lat0r = deg2rad(lat0)

    # lights → meters
    xL = R_earth .* deg2rad.(light_cord1[:,1] .- lon0) .* cos(lat0r)
    yL = R_earth .* deg2rad.(light_cord1[:,2] .- lat0)
    lamp_xy  = permutedims(hcat(xL, yL))        # 2×N

    # crimes → meters (use SAME reference)
    xC = R_earth .* deg2rad.(crime_cord1[:,1] .- lon0) .* cos(lat0r)
    yC = R_earth .* deg2rad.(crime_cord1[:,2] .- lat0)
    crime_xy = permutedims(hcat(xC, yC))        # 2×M

    kdt_lamps = KDTree(lamp_xy)
end


# ╔═╡ e4e8e41f-5d61-469e-86f1-6fe155af5b4e
### Cell — nearest-lamp distance for each crime (meters)
begin
    @assert size(crime_xy, 1) == 2 "crime_xy must be 2×M"
    @assert size(lamp_xy,  1) == 2 "lamp_xy must be 2×N"

    # k=1 nearest neighbor for all crimes
    inds, dists = knn(kdt_lamps, crime_xy, 1, true)  # returns indices and distances

    # Robustly flatten distances whether they come as Matrix (k×M) or Vector{Vector}
    dist_crime_to_lamp =
        dists isa AbstractMatrix ? vec(dists) : first.(dists)

    dist_crime_to_lamp
end


# ╔═╡ 9cc7c1fb-331e-480b-8dff-98461d8601eb
### Cell — set fixed radius (meters)
R = 100.0

# ╔═╡ a8813aea-68de-462d-814a-a694b4eed863
### Final summary tables (white background) — FIXED (∞-safe formatting) ###
let
    using PrettyTables, HypertextLiteral, Printf

    @assert isdefined(@__MODULE__, :dist_crime_to_lamp) "Run the nearest-distance cell first."

    # Use your chosen radius R if defined (fallback = 100 m)
    r = isdefined(@__MODULE__, :R) ? R :
        (isdefined(@__MODULE__, :R_METERS) ? R_METERS : 100.0)

    # Keep only valid, nonnegative distances
    d = [x for x in dist_crime_to_lamp if x isa Real && isfinite(x) && x ≥ 0]
    @assert !isempty(d) "No finite nonnegative distances."
    n = length(d)

    # Core summary stats
    qs = quantile(d, [0.25, 0.50, 0.75, 0.90, 0.95, 0.99])
    nR = count(x -> x ≤ r, d)

    # ---------- summary rows ----------
    summary_rows = [
        ("N (valid)", n),
        ("Min (m)", minimum(d)),
        ("Mean (m)", mean(d)),
        ("Std (m)", std(d)),
        ("p25 (m)", qs[1]),
        ("Median (m)", qs[2]),
        ("p75 (m)", qs[3]),
        ("p90 (m)", qs[4]),
        ("p95 (m)", qs[5]),
        ("p99 (m)", qs[6]),
        ("Max (m)", maximum(d)),
        ("≤R = $(round(r; digits=0)) m (count)", nR),
        ("≤R (%)", 100 * nR / n),
    ]

    # ---------- distance bands ----------
    edges0 = [0.0, 50.0, 100.0, 250.0, 500.0, r, 2r, 5_000.0, 50_000.0, Inf]
    edges  = sort(unique(edges0))

    isR(x)  = isfinite(r)  && isapprox(x, r;  atol=max(1e-9, 1e-12*r),  rtol=1e-12)
    is2R(x) = isfinite(2r) && isapprox(x, 2r; atol=max(1e-9, 1e-12*2r), rtol=1e-12)
    bstr(x) = isinf(x) ? "∞" : (isR(x) ? "R" : (is2R(x) ? "2R" : string(round(x; digits=0))))

    counts = Vector{Int}(undef, length(edges)-1)
    labels = Vector{String}(undef, length(edges)-1)
    for i in 1:length(edges)-1
        lo, hi = edges[i], edges[i+1]
        counts[i] = isfinite(hi) ? count(x -> lo ≤ x < hi, d) : count(x -> x ≥ lo, d)
        labels[i] =
            if i == 1
                "≤ $(bstr(hi)) m"
            elseif isfinite(hi)
                "$(bstr(lo))–$(bstr(hi)) m"
            else
                "> $(bstr(lo)) m"
            end
    end

    shares  = 100 .* (counts ./ n)
    cshares = cumsum(shares)

    band_rows = [
        (labels[i], edges[i], edges[i+1], counts[i],
         round(shares[i]; digits=2), round(cshares[i]; digits=2))
        for i in eachindex(counts)
    ]

    # ---------- to matrices ----------
    summary_tbl = hcat(first.(summary_rows), last.(summary_rows))
    band_tbl    = hcat((getindex.(band_rows, i) for i in 1:6)...)

    # ---------- formatters ----------
    fmt_summary = (v, i, j) -> begin
        if j == 2 && v isa Real
            if isfinite(v) && abs(v - round(v)) < 1e-9
                @sprintf("%d", Int(round(v)))
            else
                @sprintf("%.2f", float(v))
            end
        else
            v
        end
    end

    fmt_bands = (v, i, j) -> begin
        if v isa Real
            if j in (2, 3)  # bounds columns
                if isfinite(v)
                    @sprintf("%d", Int(round(v)))
                else
                    "∞"
                end
            elseif j == 4     # count
                v isa Integer ? string(v) : @sprintf("%d", Int(round(v)))
            elseif j in (5, 6) # percentages
                @sprintf("%.2f", float(v))
            else
                v
            end
        else
            v
        end
    end

    # ---------- render ----------
    io1 = IOBuffer()
    io2 = IOBuffer()

    pretty_table(io1, summary_tbl;
        header = ["Metric", "Value"],
        backend = Val(:html),
        tf = tf_html_simple,
        alignment = :l,
        formatters = fmt_summary,
        table_class = "whitebg",
    )

    pretty_table(io2, band_tbl;
        header = ["Band", "Lower (m)", "Upper (m)", "Count", "Share (%)", "Cum. Share (%)"],
        backend = Val(:html),
        tf = tf_html_simple,
        alignment = :l,
        formatters = fmt_bands,
        table_class = "whitebg",
    )

    @htl("""
    <style>
      table.whitebg { background: white !important; color: #111 !important; border-collapse: collapse; }
      table.whitebg th, table.whitebg td { border: 1px solid #e5e5e5; padding: 6px 8px; }
      table.whitebg th { font-weight: 600; }
      h3 { margin: 0.6rem 0 0.3rem 0; font-weight: 700; }
    </style>
    <h3>Nearest-Lamp Distance — Summary</h3>
    $(String(take!(io1)))
    <h3>Coverage by Distance Bands</h3>
    $(String(take!(io2)))
    """)
end


# ╔═╡ 95a10635-653b-4d14-9fe0-afb79607c5a3
### Cell — classify crimes within R & summary stats
begin
    # Use function form in Pluto so the message is attached to @assert (not @isdefined)
    @assert isdefined(@__MODULE__, :dist_crime_to_lamp) "Run the nearest-distance cell first."
    @assert isdefined(@__MODULE__, :R) "Define R (meters) first."

    crime_within = dist_crime_to_lamp .<= R
    n_total      = length(dist_crime_to_lamp)
    n_within     = count(crime_within)
    frac_within  = n_within / n_total

    (; n_total, n_within, frac_within, crime_within, R)
end


# ╔═╡ 8ddfbbbc-d7ae-4a83-bb51-eabeb261cc77
### Cell — nearest lamp per crime + lamp “load” (within R)
begin
    @assert size(crime_xy, 1) == 2 && size(lamp_xy, 1) == 2
    @assert isdefined(@__MODULE__, :dist_crime_to_lamp) "Run the nearest-distance cell first."
    @assert isdefined(@__MODULE__, :R) "Define R (meters) first."

    # compute inside a let so temp names don't collide with other cells
    nearest_idx, lamp_counts, lamp_counts_df = let
        I, _ = knn(kdt_lamps, crime_xy, 1, true)      # local (not global) indices
        ni = I isa AbstractMatrix ? vec(I) : first.(I)

        within_mask = dist_crime_to_lamp .<= R
        niw = ni[within_mask]

        lc = zeros(Int, size(lamp_xy, 2))
        @inbounds for i in niw
            lc[i] += 1
        end

        K = min(20, length(lc))
        topK = partialsortperm(lc, 1:K; rev=true)
        df = DataFrame(
            lamp_index  = topK,
            x_m         = lamp_xy[1, topK],
            y_m         = lamp_xy[2, topK],
            crime_count = lc[topK]
        )

        (ni, lc, df)
    end
end


# ╔═╡ ca508171-b789-425e-a190-424c88faeb91
begin
    @assert @isdefined dist_crime_to_lamp
    @assert @isdefined R
    gr(); default(size=(900,600), dpi=220, legend=false, framestyle=:box)

    p_dist = histogram(
        dist_crime_to_lamp;
        bins = 60,
        xlabel = "Nearest street-light distance (m)",
        ylabel = "Crimes",
        title  = "Crime → nearest light distance"
    )
    vline!([R]; label=false)
    annotate!((R, 0), text(" R = $(round(R; digits=0)) m", 8, :left))
    p_dist
end


# ╔═╡ 8f88994d-5e91-4dd3-935f-229d9fb99aeb
### Zoomed histogram (≤ p99) with R marked
let
    d = dist_crime_to_lamp[isfinite.(dist_crime_to_lamp)]
    xmax = quantile(d, 0.99)
    histogram(d[d .<= xmax];
        bins = 20,
        xlabel = "Nearest street-light distance (m)",
        ylabel = "Crimes",
        title  = "Crime → nearest light distance (≤ p99)")
    vline!([R]; lw=2, label = "R = $(R) m")
end

# ╔═╡ fb46a9b2-2e6f-43d5-8dda-4d4ddc94ed62
### Distances — summary stats table
let

    @assert isdefined(@__MODULE__, :dist_crime_to_lamp) "Run the nearest-distance cell first."

    r = isdefined(@__MODULE__, :R) ? R :
        (isdefined(@__MODULE__, :R_METERS) ? R_METERS : 1000.0)

    keep_idx = findall(x -> x isa Real && isfinite(x) && x ≥ 0, dist_crime_to_lamp)
    @assert !isempty(keep_idx) "No finite nonnegative distances."
    d = dist_crime_to_lamp[keep_idx]

    qs = quantile(d, [0.25, 0.50, 0.75, 0.90, 0.95, 0.99])
    n  = length(d)
    nR = sum(x -> x ≤ r, d)

    dist_summary_df = DataFrame(
        Metric = ["N","min (m)","mean (m)","std (m)","p25 (m)","median (m)","p75 (m)",
                  "p90 (m)","p95 (m)","p99 (m)","max (m)","≤R (count)","≤R (%)"],
        Value  = [n, minimum(d), mean(d), std(d), qs[1], qs[2], qs[3], qs[4], qs[5], qs[6], maximum(d),
                  nR, 100nR/n]
    )

    dist_summary_df
end


# ╔═╡ 1ef431e5-4303-4f98-94de-27c1674072d7
### Distances — coverage by bands (counts & %)
let

    r = isdefined(@__MODULE__, :R) ? R :
        (isdefined(@__MODULE__, :R_METERS) ? R_METERS : 1000.0)

    keep_idx = findall(x -> x isa Real && isfinite(x) && x ≥ 0, dist_crime_to_lamp)
    d = dist_crime_to_lamp[keep_idx]
    n = length(d)

    edges = [0.0, 50.0, 100.0, 250.0, 500.0, r, 2r, 5_000.0, 50_000.0, Inf]
    labels = [
        "≤ 50 m",
        "50–100 m",
        "100–250 m",
        "250–500 m",
        "500–$(round(r; digits=0)) m (≤R?)",
        "$(round(r; digits=0))–$(round(2r; digits=0)) m",
        "2R–5 km",
        "5–50 km",
        "> 50 km"
    ]

    function bandcount(lo, hi)
        isfinite(hi) ? sum(x -> (lo ≤ x < hi), d) : sum(x -> x ≥ lo, d)
    end

    counts = [bandcount(edges[i], edges[i+1]) for i in 1:length(edges)-1]
    share  = 100 .* (counts ./ n)
    cshare = cumsum(share)

    dist_bands_df = DataFrame(Band = labels,
                              Lower_m = edges[1:end-1],
                              Upper_m = edges[2:end],
                              Count = counts,
                              Share_pct = share,
                              CumShare_pct = cshare)

    dist_bands_df
end


# ╔═╡ 1fa6420d-4bc1-43d2-b58a-364d2d4ce162
### Distances — coverage by bands (counts & %)
let

    r = isdefined(@__MODULE__, :R) ? R :
        (isdefined(@__MODULE__, :R_METERS) ? R_METERS : 1000.0)

    keep_idx = findall(x -> x isa Real && isfinite(x) && x ≥ 0, dist_crime_to_lamp)
    d = dist_crime_to_lamp[keep_idx]
    n = length(d)

    edges = [0.0, 50.0, 100.0, 250.0, 500.0, r, 2r, 5_000.0, 50_000.0, Inf]
    labels = [
        "≤ 50 m",
        "50–100 m",
        "100–250 m",
        "250–500 m",
        "500–$(round(r; digits=0)) m (≤R?)",
        "$(round(r; digits=0))–$(round(2r; digits=0)) m",
        "2R–5 km",
        "5–50 km",
        "> 50 km"
    ]

    function bandcount(lo, hi)
        isfinite(hi) ? sum(x -> (lo ≤ x < hi), d) : sum(x -> x ≥ lo, d)
    end

    counts = [bandcount(edges[i], edges[i+1]) for i in 1:length(edges)-1]
    share  = 100 .* (counts ./ n)
    cshare = cumsum(share)

    dist_bands_df = DataFrame(Band = labels,
                              Lower_m = edges[1:end-1],
                              Upper_m = edges[2:end],
                              Count = counts,
                              Share_pct = share,
                              CumShare_pct = cshare)

    dist_bands_df
end


# ╔═╡ 12e2bbf0-29e3-4e11-be2c-b9209b484257
### Distances — top outliers to inspect
begin

    keep_idx = findall(x -> x isa Real && isfinite(x) && x ≥ 0, dist_crime_to_lamp)
    d = dist_crime_to_lamp[keep_idx]

    K = min(10, length(d))
    topK = partialsortperm(d, rev=true, 1:K)

    dist_outliers_df = DataFrame(
        crime_row   = keep_idx[topK],      # index into your original distance vector
        distance_m  = d[topK],
        distance_km = d[topK] ./ 1000
    )

    dist_outliers_df
end


# ╔═╡ ea40b484-d800-4b94-b50b-a97e186a57ea
### Distances — auto-written interpretation
let

    r = isdefined(@__MODULE__, :R) ? R :
        (isdefined(@__MODULE__, :R_METERS) ? R_METERS : 1000.0)

    keep_idx = findall(x -> x isa Real && isfinite(x) && x ≥ 0, dist_crime_to_lamp)
    d = dist_crime_to_lamp[keep_idx]
    n = length(d)

    q50 = quantile(d, 0.50)
    q90 = quantile(d, 0.90)
    q99 = quantile(d, 0.99)
    nR  = sum(x -> x ≤ r, d)
    pctR = 100nR/n
    maxd = maximum(d)
    n_big = sum(x -> x > 50_000, d)  # >50 km as obvious data issues

    md"""
**What the distances tell us**

- **Coverage near lights:** $(round(pctR, digits=1))% of crimes are within **R = $(round(r; digits=0)) m** of the nearest street-light.
- **Typical proximity:** median distance is **$(round(q50; digits=1)) m**; 90th percentile **$(round(q90; digits=1)) m**.
- **Long tail / data quality:** the 99th percentile is **$(round(q99; digits=1)) m**, with a maximum of **$(round(maxd/1000; digits=1)) km**.  
  There are **$(n_big)** records > **50 km**, which almost certainly reflect malformed or out-of-area coordinates.
- **Practical read:** most crimes occur **very close** to existing lights; conclusions should be drawn from the
  distribution up to ~p99 and **not** driven by a handful of extreme outliers.

**Next steps (recommended)**
1. Filter crimes to the city boundary (or clip to a reasonable max, e.g. 5–10 km) before analysis/plots.
2. Compare coverage across finer bands (≤50 m, 50–100 m, …) to see how quickly coverage drops with distance.
3. If planning interventions, map the **top lamp locations by attached crimes** within R and inspect those areas.
"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
ColorSchemes = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
NearestNeighbors = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
CSV = "~0.10.15"
ColorSchemes = "~3.30.0"
Colors = "~0.13.1"
DataFrames = "~1.7.1"
HypertextLiteral = "~0.9.5"
Measurements = "~2.14.0"
Measures = "~0.3.2"
NearestNeighbors = "~0.4.22"
Plots = "~1.40.19"
PlutoUI = "~0.7.71"
PrettyTables = "~2.4.0"
StatsBase = "~0.34.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "289e1e9da9f78a3f4f2eade43de8d4df690c8404"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9cb23bbb1127eefb022b022481466c0f1127d430"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.2"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "a656525c8b46aa6a1c76891552ed5381bb32ae7b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.30.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "0037835448781bb46feb39866934e243886d756a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "a37ac0840a1196cd00317b57e39d6586bf0fd6f6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.1"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "6c72198e6a101cccdd4c9731d3985e904ba26037"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.1"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

    [deps.Distances.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7bb1361afdb33c7f2b085aa49ea8fe1b0fb14e58"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.1+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "3bab2c5aa25e7840a4b065805c0cdfc01f3068d2"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.24"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "35fbd0cefb04a516104b8e183ce0df11b70a3f1a"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.84.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InlineStrings]]
git-tree-sha1 = "8f3d257792a522b4601c24a577954b0a8cd7334d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.5"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e95866623950267c1e4878846f848d94810de475"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "52e1296ebbde0db845b356abbbe67fb82a0a116c"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.9"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "706dfd3c0dd56ca090e86884db6eda70fa7dd4af"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d3c8af829abaeba27181db4acb485b18d15d89c6"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measurements]]
deps = ["Calculus", "LinearAlgebra", "Printf"]
git-tree-sha1 = "030f041d5502dbfa41f26f542aaac32bcbe89a64"
uuid = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
version = "2.14.0"

    [deps.Measurements.extensions]
    MeasurementsBaseTypeExt = "BaseType"
    MeasurementsJunoExt = "Juno"
    MeasurementsMakieExt = "Makie"
    MeasurementsRecipesBaseExt = "RecipesBase"
    MeasurementsSpecialFunctionsExt = "SpecialFunctions"
    MeasurementsUnitfulExt = "Unitful"

    [deps.Measurements.weakdeps]
    BaseType = "7fbed51b-1ef5-4d67-9085-a4a9b26f478c"
    Juno = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "ca7e18198a166a1f3eb92a3650d53d94ed8ca8a1"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.22"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2ae7d4ddec2e13ad3bddf5c0796f7547cf682391"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.2+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "275a9a6d85dc86c24d03d1837a0010226a96f540"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.3+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "0c5a5b7e440c008fe31416a3ac9e0d2057c81106"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.19"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "eb38d376097f47316fe089fc62cb7c6d85383a52"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "e1d5e16d0f65762396f9ca4644a5f4ddab8d452b"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "cbea8a6bd7bed51b1619658dec70035e07b8502f"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.14"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "725421ae8e530ec29bcbdddbe91ff8053421d023"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.1"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "6258d453843c466d84c17a58732dda5deeb8d3af"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.24.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "af305cc62419f9bd61b6644d19170a4d258c7967"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.7.0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╠═5546d670-b0cf-11f0-0c74-e18a04df526d
# ╠═65be33b5-fe67-4d0e-a25f-6c50e705caa6
# ╠═096415a2-b7fe-43b5-9a69-45b2464b8db9
# ╠═17c5b77d-18d6-401e-884f-4527ec6aa151
# ╠═6a6adf42-e6fc-4d9c-80dc-529d80a37f30
# ╠═f04c25c8-17cb-4806-86e4-d46a1141333e
# ╠═32f4bb40-2235-479c-8bc0-6c3ecb76b984
# ╠═19cc5ae0-a07a-468e-a132-cfdbf4455d69
# ╠═17518608-734d-4da3-b3b5-5451696f8c52
# ╠═a373e3ae-8bd4-467b-9b65-561762c7ce61
# ╠═b8cbb720-4a14-4456-b618-7dada03c00ed
# ╠═ab9757eb-f5bc-480b-af5c-7ad71d9841d6
# ╠═b4f6ce7e-2d7d-4884-adc2-3554a848f22b
# ╠═7fa4103b-4402-4b95-aa00-2978efd46527
# ╠═b5012d15-541a-4901-9560-fa8e7f6a3f17
# ╠═69a842a1-46d1-44b6-96b8-3b1b76f5d841
# ╠═27ad33df-f559-4835-8b59-8868ae79121f
# ╠═b004b000-4522-415e-ba22-75bd0065dc92
# ╠═63a9bbec-ddd3-4980-adcc-dfb299db9845
# ╠═ccea3727-073a-422c-a42e-721c38520423
# ╠═f8d00b52-765d-4ee2-8d3e-140e67409d94
# ╠═7de906aa-ff50-45d6-85e2-e21452679d70
# ╠═d0e75de2-f368-4940-814c-891d437e79d7
# ╠═e6d8253b-b179-4085-abe2-2fe9e7657a66
# ╠═6b1cf198-429c-4269-8da3-f89bfeabb2b6
# ╠═0e23fa53-ea62-495c-a221-ec56a777adbd
# ╠═2bb66d09-53d7-4d6b-8f9c-9ce78b17fbc9
# ╠═12a11760-e615-4b94-b04b-7237d1d6d891
# ╠═589e6baa-4dfd-45cd-98d6-912638ff4a01
# ╠═ff17c734-d29d-49ba-ab9d-b9e64f6d34f6
# ╠═4852e810-c3a9-4dae-9838-c6730deb615c
# ╠═1930f6c6-323f-4bfa-9b62-199963d78713
# ╠═bcbccb25-175c-4017-9f6a-899a38d4513d
# ╠═87510e53-efdd-4eb7-8323-da7930a6e838
# ╠═6d29b022-058b-415c-a637-703fc74a20e1
# ╠═4072c3ae-2e5a-4d8d-b1a9-6c13a29c14a3
# ╠═26e6d7a9-02df-49b1-81e1-fce419545a51
# ╠═e4e8e41f-5d61-469e-86f1-6fe155af5b4e
# ╠═9cc7c1fb-331e-480b-8dff-98461d8601eb
# ╠═95a10635-653b-4d14-9fe0-afb79607c5a3
# ╠═8ddfbbbc-d7ae-4a83-bb51-eabeb261cc77
# ╠═ca508171-b789-425e-a190-424c88faeb91
# ╠═fb46a9b2-2e6f-43d5-8dda-4d4ddc94ed62
# ╠═8f88994d-5e91-4dd3-935f-229d9fb99aeb
# ╠═1ef431e5-4303-4f98-94de-27c1674072d7
# ╠═1fa6420d-4bc1-43d2-b58a-364d2d4ce162
# ╠═12e2bbf0-29e3-4e11-be2c-b9209b484257
# ╠═ea40b484-d800-4b94-b50b-a97e186a57ea
# ╠═a8813aea-68de-462d-814a-a694b4eed863
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
