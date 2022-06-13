using Pkg

Pkg.add(["CSV","DataFrames","DecisionTree", "Plots", "JLD2"])
Pkg.add("CategoricalArrays")

using CSV, DataFrames, Plots, DecisionTree
using CategoricalArrays

model_path = ARGS[1]
input_dataset = ARGS[2]
output_path = ARGS[3]

using JLD2

trained_model = load(model_path * "/outputs/iris.jld2")
trained_coeffs = load(model_path * "/outputs/coeffs.jld2")

labels = categorical([String15("Iris-setosa"), String15("Iris-versicolor"), String15("Iris-virginica")])
scores = apply_adaboost_stumps_proba(trained_model["model"], trained_coeffs["coeffs"], features, labels)

CSV.write(output_path * "/predictions.csv", Tables.table(scores))
