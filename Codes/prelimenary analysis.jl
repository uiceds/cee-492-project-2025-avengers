using CSV, DataFrames, StatsPlots, CategoricalArrays, Measures
df = CSV.read("/Users/demiyu/Desktop/CEE492/Crime_Data_from_2020_to_Present.csv", DataFrame)
keydata = select(df, [:"Date Rptd", :"DATE OCC", :"TIME OCC", :"AREA", :"Vict Age", :"Vict Sex", :"Vict Descent"])
# Vict Descent Code: A - Other Asian B - Black C - Chinese D - Cambodian F - Filipino G - Guamanian H - Hispanic/Latin/Mexican I - American Indian/Alaskan Native J - Japanese K - Korean L - Laotian O - Other P - Pacific Islander S - Samoan U - Hawaiian V - Vietnamese W - White X - Unknown Z - Asian Indian
# Vict sex: F - Female M - Male X - Unknown

#analyze victim sex
sex_df = combine(groupby(df, :"Vict Sex"), nrow => :count)
total_sex = sum(sex_df.count)
sex_df.percent = 100 .* sex_df.count ./ total_sex
print(sex_df)

#analyze victim age
print(first(keydata))
agedata = filter(row -> !ismissing(row."Vict Age") && row."Vict Age" > 0, keydata)
edges = [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,Inf]
labels = ["0–4","5–9","10–14","15–19","20–24","25–29","30–34","35–39",
          "40–44","45–49","50–54","55–59","60–64","65–69","70–74",
          "75–79","80–84","85+"]
agedata.age_group = cut(agedata."Vict Age", edges; labels=labels, extend=true)

age_df = combine(groupby(agedata, :age_group), nrow => :count)
age_df.percent = 100 .* age_df.count ./ sum(age_df.count)
print(age_df)
## Histogram of victim age
@df age_df bar(
    :age_group,
    :count,
    xlabel = "Victim Age Group",
    ylabel = "Number of Cases",
    #title = "Age Distribution of Crime Victims",
    legend = false,
    bar_width = 0.7,
    fillalpha = 0.8,
    rotation = 30 
)
savefig("figures/victim_age_hist.png")
#analyze victim descent
descent_map = Dict(
    "A" => "Other Asian",
    "B" => "Black",
    "C" => "Chinese",
    "D" => "Cambodian",
    "F" => "Filipino",
    "G" => "Guamanian",
    "H" => "Hispanic/Latin/Mexican",
    "I" => "American Indian/Alaskan Native",
    "J" => "Japanese",
    "K" => "Korean",
    "L" => "Laotian",
    "O" => "Other",
    "P" => "Pacific Islander",
    "S" => "Samoan",
    "U" => "Hawaiian",
    "V" => "Vietnamese",
    "W" => "White",
    "X" => "Unknown",
    "Z" => "Asian Indian"
)
descentdata = filter(row -> !ismissing(row."Vict Descent"), keydata)
descentdata = filter(row -> row."Vict Descent" != "-", descentdata)
descent_df = combine(groupby(descentdata, :"Vict Descent"), nrow => :count)
total_descent = sum(descent_df.count)
descent_df.percent = [(round(100 * descent_df.count[i] / total_descent; digits=2)) for i in 1:nrow(descent_df)]
print(descent_df)
# Add descent name column
descent_df.descent_name = [get(descent_map, code, "Unknown") for code in descent_df."Vict Descent"]
sort!(descent_df, :percent, rev=true)
@df descent_df bar(
    :descent_name,              # x-axis categories
    :percent,                   # y-axis values
    xlabel = "Victim Descent",
    ylabel = "Percentage (%)",
    #title = "Descent Distribution of Crime Victims",
    legend = false,
    bar_width = 0.7,
    xticks = :all,
    xtickfontsize = 7, 
    fillalpha = 0.8,
    rotation = 30               # tilt labels to avoid overlap
)
savefig("figures/victim_descent_hist.png")
print(descent_df)

#create a heatmap for age and descent
age_descent_df = filter(row ->
    !ismissing(row."Vict Age") && row."Vict Age" > 0 &&
    !ismissing(row."Vict Descent") && row."Vict Descent" != "-",
    keydata)
print(first(age_descent_df, 5))
age_descent_df.age_group = cut(age_descent_df."Vict Age", edges; labels=labels, extend=true)
age_descent_df.descent_name = map(x -> get(descent_map, x, "Unknown"), age_descent_df."Vict Descent")
age_descent = combine(groupby(age_descent_df, [:age_group, :descent_name]), nrow => :count)

# age_descent has columns: :age_group, :descent_name, :count
wide = unstack(age_descent, :age_group, :descent_name, :count)
sort!(wide, :age_group)  # keep bins in order

# Fill missings in all non-age_group columns
for c in names(wide)
    c == :age_group && continue
    wide[!, c] = coalesce.(wide[!, c], 0)
end

# Columns to plot (Symbols) and x tick labels (Strings)
xsyms   = filter(n -> n != :age_group, names(wide))[2:end]   # e.g. [:White, :Black, ...]
xlabels = String.(xsyms)
print(xsyms)
# Y tick labels from the age_group column
ylabels = String.(wide.age_group)

# Numeric matrix (rows = age groups, cols = descents)
Z = Matrix(select(wide, xsyms))

nx, ny = size(Z, 2), size(Z, 1)
heatmap(
    1:nx, 1:ny, Z;
    xticks = (1:nx, xlabels),
    yticks = (1:ny, ylabels),
    xlabel = "Victim Descent",
    ylabel = "Victim Age Group",
    #title  = "Count of Cases by Age Group and Descent",
    colorbar = true,
    yflip = true,      # youngest on top
    xrotation = 30,
    xtickfontsize = 7,
    leftmargin = 8mm,
    rightmargin = 5mm

)
savefig("figures/age_descent_heatmap.png")
