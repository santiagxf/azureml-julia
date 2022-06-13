using Pkg

Pkg.add(["CSV","DataFrames","DecisionTree", "Plots", "JLD2"])
Pkg.add("CategoricalArrays")

using CSV, DataFrames, Plots, DecisionTree
using CategoricalArrays

model_path = ARGS[1]
input_dataset = ARGS[2]