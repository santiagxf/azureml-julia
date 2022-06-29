using Pkg

Pkg.add(["CSV","DataFrames","DecisionTree", "Plots", "JLD2"])
Pkg.add("CategoricalArrays")

using CSV, DataFrames, Plots, DecisionTree
using CategoricalArrays

model_path = ARGS[1]
input_dataset = ARGS[2]
output_path = ARGS[3]

println(readdir(model_path))

df = CSV.read(input_dataset, DataFrame)
features = Matrix(df[:, 1:4])

using JLD2

trained_model = load(model_path * "/iris.jld2")
trained_coeffs = load(model_path * "/coeffs.jld2")

class_labels = categorical([String15("Iris-setosa"), String15("Iris-versicolor"), String15("Iris-virginica")])
scores = apply_adaboost_stumps_proba(trained_model["model"], trained_coeffs["coeffs"], features, class_labels)

CSV.write(output_path * "/predictions.csv", Tables.table(scores))
