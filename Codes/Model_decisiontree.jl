using CategoricalArrays
using CSV, DataFrames, StatsPlots, CategoricalArrays, Measures, StatsBase
using DecisionTree
df = CSV.read("/Users/demiyu/Desktop/CEE492/Crime_Data_from_2020_to_Present.csv", DataFrame)
keydata = select(df, [:"TIME OCC", :"AREA", :"Crm Cd Desc"])
crimetype_counts = countmap(keydata."Crm Cd Desc")
sorted_crimes = sort(collect(crimetype_counts), by = x -> x[2], rev = true)
top20 = sorted_crimes[1:20]
mydata = filter(:"Crm Cd Desc" => x -> x in [crime for (crime, count) in top20], keydata)
#unique_areas = unique(mydata."AREA")
function time_to_hour(t)
    hour = floor(Int, t / 100)
    return hour
end
mydata.time = time_to_hour.(mydata."TIME OCC")
mydata."AREA" = Int.(mydata."AREA")
#make decision tree

features = float.(hcat(time_code, area_code))
labels   = String.(mydata."Crm Cd Desc")

n = size(features, 1)
n_train = round(Int, 0.8n)
Xtr, ytr = features[1:n_train, :], labels[1:n_train]
Xte, yte = features[n_train+1:end, :], labels[n_train+1:end]


n_subfeatures       = 0        # use all features
max_depth           = 10    
min_samples_leaf    = 50       
min_samples_split   = 100      
min_purity_increase = 1e-3    

model = build_tree(ytr, Xtr,
                   n_subfeatures,
                   max_depth,
                   min_samples_leaf,
                   min_samples_split,
                   min_purity_increase)

#model = prune_tree(model, 0.95)
ŷ = apply_tree(model, Xte)
accuracy = sum(ŷ .== yte) / length(yte)
