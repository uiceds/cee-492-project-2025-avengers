using PlutoUI        # Interactive widgets and UI elements in Pluto notebooks  
using DataFrames     # Work with tabular data (rows and columns)  
using RDatasets      # Access 1,000+ classic datasets for practice  
using Statistics     # Basic statistical functions (mean, std, correlation, etc.)  
using StatsPlots     # Easy plotting of statistical data (histograms, boxplots, etc.)  
using CSV            # Fast reading and writing of CSV files  
using StatsBase      # Extra statistical tools (sampling, weights, counts) 

#Loading the CSV file
df = CSV.read(raw"/Users/macbookair/Downloads/Github Repository/DataFrame/Crime_Data_from_2020_to_Present.csv", DataFrame)


# ----------------------- DataFrame Cleaning for Temporal Analysis  ------------------------------------------
df_temp=df[:, [
    "DR_NO", 
    "Date Rptd", 
    "DATE OCC", 
    "TIME OCC", 
    "AREA", 
    "AREA NAME", 
    "Part 1-2",  
    "Crm Cd Desc",  
    "LAT", 
    "LON", 
]]


    # Remove the time substring from DATE OCC
    df_temp[!, "DATE OCC"] = replace.(df_temp[!, "DATE OCC"], r"\s+\d{1,2}:\d{2}:\d{2}\s*(AM|PM)" => "")
    df_temp

    # Remove the time substring from Date Rptd
    df_temp[!, "Date Rptd"] = replace.(df_temp[!, "Date Rptd"], r"\s+\d{1,2}:\d{2}:\d{2}\s*(AM|PM)" => "")
    df_temp

    df_clean=df_temp

# ----------------------- Heatmap for hourly incident frequency  ------------------------------------------

using DataFrames, Dates, StatsPlots, Missings
    # --- 1) Make sure types are right and derive day-of-week & hour ---
    dfh = deepcopy(df_clean)

    # parse DATE OCC (e.g. "11/07/2020") -> Date
    dfh[!, :DATE_OCC_Date] = Date.(dfh[!, "DATE OCC"], dateformat"m/d/y")

    # extract day-of-week (1=Mon ... 7=Sun) and day name
    dfh[!, :DOW]      = dayofweek.(dfh[!, :DATE_OCC_Date])
    dfh[!, :DOW_name] = dayname.(dfh[!, :DATE_OCC_Date])

    # TIME OCC is HHMM integer (e.g., 1830 -> 18)
    gethour(x) = ismissing(x) ? missing : (x == 2400 ? 0 : clamp(div(x, 100), 0, 23))
    dfh[!, :HOUR] = gethour.(dfh[!, "TIME OCC"])

    # keep rows with valid hour/date
    dropmissing!(dfh, [:DATE_OCC_Date, :HOUR])

    # --- 2) Count incidents by (day-of-week, hour) and form a 7x24 matrix ---
    g = combine(groupby(dfh, [:DOW, :HOUR]), nrow => :count)

    allhours = 0:23
    alldow   = 1:7
    dow_names = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    # ensure all 7×24 cells exist (fill missing with 0)
    full = DataFrame(DOW = repeat(alldow, inner=24),
                 HOUR = repeat(collect(allhours), outer=7))
    g2 = leftjoin(full, g, on=[:DOW, :HOUR])
    replace!(g2.count, missing => 0)

    # reshape to matrix with rows = DOW (Mon..Sun), cols = hour 0..23
    Z = permutedims(reshape(g2.count, 24, 7))  # 7×24

    # --- 3) Plot heatmap ---
    heatmap(allhours, 1:7, Z;
        yticks=(1:7, dow_names),
        xlabel="Hour of Day (0–23)",
        ylabel="Day of Week",
        colorbar_title="Incident Count",
        title="Hourly Heatmap of Incident Frequency",
        size=(800, 400))


# ----------------------- Normalizing Crime Description  ------------------------------------------

# Assuming df_clean is your cleaned dataset
unique_crimes = unique(df_clean[!, "Crm Cd Desc"])

#  Write the full list to a text file
using CSV
CSV.write("crime_descriptions_list.csv", DataFrame(CrimeType = unique_crimes))


norm_desc(s::AbstractString) = let t = uppercase(String(s))
    # unifying punctuation/spaces
    t = replace(t, '–' => '-', '—' => '-', '’' => '\'', '“' => '"', '”' => '"')
    t = replace(t, r"[^A-Z0-9/\s-]" => "")   # keep letters, digits, slash, dash, space
    t = replace(t, r"\s+" => " ")
    strip(t)
end

# ---------- 2) Ordered rules (first match wins) ----------
# Tailored to your list; extend as needed. Grouping keeps attempts with their base where sensible.
const RULES = [
    # LIFE / PERSON
    (r"\bCRIMINAL HOMICIDE\b|\bMANSLAUGHTER\b",                                  "HOMICIDE"),
    (r"\bKIDNAPPING\b",                                                           "KIDNAPPING"),
    (r"\bHUMAN TRAFFICKING\b|\bPANDERING\b|\bPIMPING\b",                          "HUMAN TRAFFICKING"),
    (r"\bRAPE\b|\bSODOMY\b|\bORAL COPULATION\b|\bSEXUAL PENETRATION\b",          "SEXUAL ASSAULT"),
    (r"\bBATTERY WITH SEXUAL CONTACT\b|\bLEWD\b|\bINDECENT EXPOSURE\b|\bPEEPING", "SEX OFFENSE (OTHER)"),
    (r"\bASSAULT WITH DEADLY WEAPON\b|AGGRAVATED ASSAULT\b|ON POLICE OFFICER\b",  "ASSAULT (AGGRAVATED)"),
    (r"\bBATTERY\b|\bSIMPLE ASSAULT\b|\bOTHER ASSAULT\b|INTIMATE PARTNER - SIMPLE", "ASSAULT (SIMPLE)"),
    (r"\bINTIMATE PARTNER - AGGRAVATED ASSAULT\b",                                "IPV (AGGRAVATED)"),
    (r"\bCHILD ABUSE\b|\bCHILD NEGLECT\b|\bCHILD ANNOYING\b|\bLEWD/LASCIVIOUS ACTS WITH CHILD\b|\bCRM AGNST CHLD\b", "CHILD ABUSE/ENDANGERMENT"),
    (r"\bCHILD STEALING\b|\bFALSE IMPRISONMENT\b",                                "CUSTODY/RESTRAINT"),
    # ROBBERY / TRESPASS / COURT
    (r"\bROBBERY\b",                                                              "ROBBERY"),
    (r"\bSTALKING\b|\bCRIMINAL THREATS\b|\bTHREATENING PHONE",                    "THREATS/STALKING"),
    (r"\bTRESPASS\b|\bPROWLER\b",                                                 "TRESPASS/PROWLING"),
    (r"\bVIOLATION OF (TEMPORARY )?RESTRAINING ORDER\b|\bVIOLATION OF COURT ORDER\b|\bCONTEMPT OF COURT\b|\bSEX OFFENDER REGISTRANT OUT OF COMPLIANCE\b|\bFIREARMS (RO|EPO)\b", "COURT/ORDER VIOLATION"),
    (r"\bRESISTING ARREST\b|\bFALSE POLICE REPORT\b|\bFAILURE TO DISPERSE\b|\bINCITING A RIOT\b|\bDISRUPT SCHOOL\b|\bBLOCKING DOOR\b", "PUBLIC ORDER"),
    # BURGLARY / VANDALISM / ARSON / WEAPONS
    (r"\bBURGLARY FROM VEHICLE\b|\bBURGLARY, ATTEMPTED\b|\bBURGLARY FROM VEHICLE, ATTEMPTED\b", "BURGLARY FROM VEHICLE"),
    (r"\bBURGLARY\b",                                                             "BURGLARY (STRUCTURE)"),
    (r"\bVANDALISM\b|\bGRAFFITI\b|\bTELEPHONE PROPERTY - DAMAGE\b",              "VANDALISM"),
    (r"\bARSON\b",                                                                "ARSON"),
    (r"\bWEAPONS POSSESSION\b|\bBRANDISH WEAPON\b|\bDISCHARGE FIREARMS\b|\bSHOTS FIRED\b|\bREPLICA FIREARMS\b|\bTHROWING OBJECT AT MOVING VEHICLE\b", "WEAPONS/FIREARMS"),
    (r"\bSHOTS FIRED AT INHABITED DWELLING\b|\bAT MOVING VEHICLE\b|\bTRAIN OR AIRCRAFT\b",      "WEAPONS/FIREARMS"),
    # THEFT FAMILY
    (r"\bVEHICLE - STOLEN\b|\bDWOC\b|\bVEHICLE, STOLEN - OTHER\b|BOAT - STOLEN\b|BIKE - STOLEN\b|BIKE - ATTEMPTED STOLEN\b", "MOTOR VEHICLE/BIKE THEFT"),
    (r"\bTHEFT FROM MOTOR VEHICLE\b",                                             "THEFT FROM VEHICLE"),
    (r"\bTHEFT PLAIN\b|SHOPLIFTING\b|PURSE SNATCHING\b|PICKPOCKET\b|TILL TAP\b|PETTY THEFT - AUTO REPAIR\b|THEFT, PERSON\b", "THEFT (PERSONAL/RETAIL)"),
    (r"\bTHEFT.*GRAND\b|\bGRAND THEFT\b|\bINSURANCE FRAUD\b|GRAND THEFT / AUTO REPAIR\b",       "GRAND THEFT (OTHER)"),
    (r"\bTHEFT.*PETTY\b",                                                         "PETTY THEFT (OTHER)"),
    (r"\bTHEFT.*COIN MACHINE\b",                                                  "COIN/MACHINE THEFT"),
    (r"\bTHEFT FROM PERSON\b|\bPURSE SNATCHING\b|\bPICKPOCKET\b",                 "THEFT FROM PERSON"),
    (r"\bTHEFT.*ATTEMPT\b|SHOPLIFTING - ATTEMPT\b|\bPICKPOCKET, ATTEMPT\b|\bPURSE SNATCHING - ATTEMPT\b|\bTHEFT FROM PERSON - ATTEMPT\b", "THEFT (ATTEMPT)"),
    (r"\bTHEFT OF IDENTITY\b|\bCREDIT CARDS, FRAUD USE\b|\bFORGERY\b|\bCOUNTERFEIT\b",          "FRAUD/ID/CARD/FORGERY"),
    (r"\bBUNCO\b|\bEMBEZZLEMENT\b|\bDEFRAUDING INNKEEPER\b|\bDOCUMENT WORTHLESS\b|\bDISHONEST EMPLOYEE\b|\bDRUNK ROLL\b", "FRAUD/SCAM/FINANCIAL"),
    # CYBER / ADMIN / TRAFFIC / MISC
    (r"\bUNAUTHORIZED COMPUTER ACCESS\b",                                         "CYBER/COMPUTER"),
    (r"\bRECKLESS DRIVING\b|\bFAILURE TO YIELD\b",                                "TRAFFIC (NON-DUI)"),
    (r"\bILLEGAL DUMPING\b|\bDISORDERLY|DISTURBING THE PEACE\b",                  "NUISANCE/QUALITY-OF-LIFE"),
    (r"\bANIMALS\b|BEASTIALITY",                                                  "ANIMAL CRIME"),
    (r"\bEXTORTION\b|\bBRIBERY\b|\bCONSPIRACY\b",                                 "EXTORTION/BRIBERY/CONSPIRACY"),
    (r"\bINCEST\b",                                                                "INCEST"),
    (r"\bBOMB SCARE\b|TRAIN WRECKING\b",                                          "PUBLIC SAFETY (BOMB/RAIL)"),
    (r"\bLYNCHING\b",                                                              "GROUP VIOLENCE"),
    (r"\bOTHER MISCELLANEOUS CRIME\b|\bPROWLER\b",                                 "OTHER"),
]

bucketize(s::AbstractString) = begin
    t = norm_desc(s)
    for (rx, label) in RULES
        occursin(rx, t) && return label
    end
    "OTHER"
end

# ---------- 3) Apply on your data ----------
using DataFrames, Dates, StatsPlots, Plots
df_b = copy(df_clean)
rename!(df_b, "Crm Cd Desc" => :CrmDesc)
df_b.crime_bucket = bucketize.(df_b.CrmDesc)

# Optional short label for plots
shorten(s; n=24) = (length(s) <= n ? s : s[1:n-1]*"…")
df_b.crime_bucket_short = shorten.(df_b.crime_bucket)

# Quick check: top buckets
combine(groupby(df_b, :crime_bucket), nrow => :count) |> x -> sort(x, :count, rev=true)

# ----------------------- Temporal Trend of Top Crime Buckets  ------------------------------------------
using DataFrames, Dates, StatsPlots

# make column names consistent
df_sym = copy(df_b)
rename!(df_sym, "DATE OCC" => :DATE_OCC)

# keep years 2020–2024
df_plot = select(df_sym, :crime_bucket, :DATE_OCC)
df_plot.year = year.(Date.(df_plot.DATE_OCC, dateformat"m/d/y"))
df_plot = df_plot[(2020 .<= df_plot.year .<= 2024), :]

# counts per bucket per year
yearly = combine(groupby(df_plot, [:year, :crime_bucket]), nrow => :count)

# top 10 buckets overall
top10 = first(sort(combine(groupby(yearly, :crime_bucket), :count => sum => :total),
                   :total, rev=true), 10).crime_bucket
yearly_top = yearly[in.(yearly.crime_bucket, Ref(top10)), :]

# shorter legend labels
short_label(s) = length(s) > 25 ? s[1:25]*"…" : s
yearly_top.short_label = short_label.(yearly_top.crime_bucket)

@df yearly_top groupedbar(
    :year, :count, group=:short_label,
    bar_position=:dodge,
    xlabel="Year", ylabel="Incident Count",
    title="Top 10 Crime List (2020–2024)",
    legend=:outertop, lw=0, framestyle=:box,
    size=(1000, 600),
    label_font_size=7, legendfontsize=7, tickfontsize=7,
    titlefontsize=10, guidefontsize=9
)
plot!(xticks=(2020:2024, string.(2020:2024)), xrotation=15)


# ----------------------- Temporal & Spatial Correlation  ------------------------------------------
begin
    using DataFrames, Dates, Plots, Statistics

    # ------------------------ use df_clean ------------------------
    dfm = copy(df_clean)

    # Parse DATE OCC -> Date (robust to either "m/d/y" or "m/d/y H:M:S p")
    function parse_occ_date(x)
        x === missing && return missing
        xs = String(x)
        try
            return Date(xs, dateformat"m/d/y")
        catch
            try
                # if the column still has " 12:00:00 AM"
                return Date(DateTime(xs, dateformat"m/d/y H:M:S p"))
            catch
                return missing
            end
        end
    end
    dfm.occ_date = parse_occ_date.(dfm."DATE OCC")

    # Coerce coords (handles if stored as strings)
    dfm.lat = tryparse.(Float64, string.(dfm."LAT"))
    dfm.lon = tryparse.(Float64, string.(dfm."LON"))

    # Keep valid rows + years 2020..2024 (drop 2025+)
    dfm = filter(r -> !ismissing(r.occ_date) && !ismissing(r.lat) && !ismissing(r.lon), dfm)
    dfm = filter(r -> 24 ≤ r.lat ≤ 50 && -125 ≤ r.lon ≤ -66, dfm)
    dfm = filter(r -> 2020 ≤ year(r.occ_date) ≤ 2024, dfm)

    @assert nrow(dfm) > 0 "No rows remain after filtering for valid date/coords and years 2020–2024."

    # Month "period" key = first of month
    dfm.period = Date.(year.(dfm.occ_date), month.(dfm.occ_date), 1)

    # ------------------------ pick peak months ------------------------
    per_counts = combine(groupby(dfm, :period), nrow => :count)
    per_counts.year = year.(per_counts.period)

    selected_periods = Date[]
    for yr in 2020:2024
        sub = per_counts[per_counts.year .== yr, :]
        if nrow(sub) > 0
            push!(selected_periods, sub.period[argmax(sub.count)])
        end
    end
    selected_periods = unique(selected_periods)

    # If fewer than 6 panels, add next global peak months
    if length(selected_periods) < 6
        for r in eachrow(sort(per_counts, :count, rev=true))
            (r.period in selected_periods) && continue
            push!(selected_periods, r.period)
            length(selected_periods) == 6 && break
        end
    end
    @assert !isempty(selected_periods)

    sort!(selected_periods)  # chronological order
    nplots = min(length(selected_periods), 6)

    # ------------------------ fixed map bounds ------------------------
    lon_min, lon_max = quantile(skipmissing(dfm.lon), (0.01, 0.99))
    lat_min, lat_max = quantile(skipmissing(dfm.lat), (0.01, 0.99))

    # ------------------------ 2x3 scatter panels ------------------------
    default(fmt = :png)
    theme(:default)
    default(markerstrokewidth=0, markersize=2, alpha=0.6)

    plt = plot(layout=(2,3), legend=false, size=(1200, 800))

    for (k, p) in enumerate(selected_periods[1:nplots])
        sub = dfm[dfm.period .== p, :]
        ttl = string(Dates.format(p, dateformat"U yyyy"), "   (n=$(nrow(sub)))")
        scatter!(
            plt, sub.lon, sub.lat;
            xlim=(lon_min, lon_max), ylim=(lat_min, lat_max),
            xlabel="Longitude", ylabel="Latitude",
            title=ttl, color=:dodgerblue, grid=false, framestyle=:box,
            subplot=k
        )
    end

    display(plt)
    # savefig(plt, "incident_peaks_2x3.png")
end

# ----------------------- Delay distributed reported incidents  ------------------------------------------
begin
    using DataFrames, Dates, StatsPlots, Statistics

    # Work on a copy
    dfd = copy(df_clean)

    # Parse date-only strings: "m/d/y"
    dfd.occ_dt = Date.(dfd."DATE OCC", dateformat"m/d/y")
    dfd.rpt_dt = Date.(dfd."Date Rptd", dateformat"m/d/y")

    # Keep valid rows and years 2020–2024
    filter!(r -> !ismissing(r.occ_dt) && !ismissing(r.rpt_dt), dfd)
    filter!(r -> 2020 ≤ year(r.occ_dt) ≤ 2024, dfd)

    # Delay in days (non-negative, trim long tails for viz)
    dfd.delay_days = (dfd.rpt_dt .- dfd.occ_dt) ./ Day(1)
    filter!(r -> 0 ≤ r.delay_days ≤ 60, dfd)

    μ   = mean(dfd.delay_days)
    med = median(dfd.delay_days)

    # Plot
    default(fmt = :png)
    @df dfd begin
        histogram(:delay_days;
            bins=0:1:30, normalize=:pdf, alpha=0.6, linecolor=:white,
            xlabel="Reporting Delay (days) = Date Rptd − DATE OCC",
            ylabel="Density",
            title="Delay Distribution of Reported Incidents (2020–2024)",
            label="Histogram (PDF)", legend=:topright, color=:steelblue, grid=:y)
        density!(:delay_days; color=:darkred, lw=2, label="KDE")
        vline!([μ];   color=:green,  lw=2, ls=:dash, label="Mean = $(round(μ,digits=2)) d")
        vline!([med]; color=:purple, lw=2, ls=:dot,  label="Median = $(round(med,digits=2)) d")
    end
end
