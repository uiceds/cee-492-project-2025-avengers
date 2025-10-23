
using CSV, DataFrames, StatsPlots
df = CSV.read("/Users/demiyu/Desktop/CEE492/Crime_Data_from_2020_to_Present.csv", DataFrame)
keydata = select(df, [:"Date Rptd", :"DATE OCC", :"TIME OCC", :"AREA", :"Vict Age", :"Vict Sex", :"Vict Descent"])
# Vict Descent Code: A - Other Asian B - Black C - Chinese D - Cambodian F - Filipino G - Guamanian H - Hispanic/Latin/Mexican I - American Indian/Alaskan Native J - Japanese K - Korean L - Laotian O - Other P - Pacific Islander S - Samoan U - Hawaiian V - Vietnamese W - White X - Unknown Z - Asian Indian
# Vict sex: F - Female M - Male X - Unknown

#analyze victim sex
sex_df = combine(groupby(df, :"Vict Sex"), nrow => :count)
total = sum(sex_df.count)
sex_df.percent = 100 .* sex_df.count ./ total
print(sex_df)

#analyze victim age

#analyze victim descent