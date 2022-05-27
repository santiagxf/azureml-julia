using Pkg

Pkg.add(["CSV","DataFrames","DecisionTree", "Plots", "JLD2"])
Pkg.add("CategoricalArrays")

using CSV, DataFrames, Plots, DecisionTree
using CategoricalArrays

input_dataset = ARGS[1]
df = CSV.read(input_dataset, DataFrame)

features = Matrix(df[:, 1:4])
labels = categorical(df[:, 5])

# train adaptive-boosted stumps, using 7 iterations
model, coeffs = build_adaboost_stumps(labels, features, 7);

# Quick test
sample = [5.9,3.0,5.1,1.9]
apply_adaboost_stumps(model, coeffs, sample)

apply_adaboost_stumps_proba(model, coeffs, sample, categorical(levels(labels)))

# run n-fold cross validation for boosted stumps, using 7 iterations and 3 folds
accuracy = nfoldCV_stumps(labels, features, 7, 3)

using JLD2

mkpath("outputs")
@save "outputs/iris.jld2" model