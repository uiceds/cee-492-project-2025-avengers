using CSV, DataFrames, StatsPlots, CategoricalArrays
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
    title = "Age Distribution of Crime Victims",
    legend = false,
    bar_width = 0.7,
    fillalpha = 0.8,
    rotation = 30 
)

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
    title = "Descent Distribution of Crime Victims",
    legend = false,
    bar_width = 0.7,
    xticks = :all,
    xtickfontsize = 7, 
    fillalpha = 0.8,
    rotation = 30               # tilt labels to avoid overlap
)
print(descent_df)