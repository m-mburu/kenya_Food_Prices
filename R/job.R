
#library(rmarkdown)

#render("R/README2.Rmd", output_format = "github_document", output_file = "R/README2.md")

sample <- sample(1:150, sample(1:50, 1))
iris_subset <- iris[sample, ]

write.csv(iris_subset, "data/iris_subset.csv")
