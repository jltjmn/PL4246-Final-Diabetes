# Load libraries for bootnet, qgraph and igraph
library("bootnet") 
library("qgraph") 
library("igraph")

# Read data into R and view
diabetes5050 <- read.csv("diabetes5050.csv")
View(diabetes5050)

# Get sample of 5000 participants and view
data_sample <- diabetes5050[sample(1:nrow(diabetes5050),5000),]
View(data_sample)

set.seed(1)

# Network estimation with mgm (both binary and continuous data involved)
Net1 <- estimateNetwork(data_sample, default = "mgm")

# Obtain weights matrix
Net1$graph

# PNG of network

library(Cairo)
CairoPNG("Diabetes Network Graph.png", width = 20, height = 20, 
         units="in", dpi=350)

# Plot network
Net1graph <- plot(Net1, 
                  layout = "spring", 
                  title = "Diabetes Symptomatology",
                  vsize = 8,
                  labels = c("Diabetes",
                             "HighBP",
                             "HighChol",
                             "CholCheck",
                             "BMI",
                             "Smoker",
                             "Stroke",
                             "HeartIssue",
                             "PhysAct",
                             "Fruits",
                             "Veggies",
                             "HvyAlcCons",
                             "Healthcare",
                             "NoDocbcCost",
                             "GenHlth",
                             "MentHlth",
                             "PhysHlth",
                             "DiffWalk",
                             "Sex",
                             "Age",
                             "Edu",
                             "$$"),
                  color = c("lightpink",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white",
                            "white"))

dev.off()

# PNG of Centrality plot
library(Cairo)
CairoPNG("Diabetes Centrality Plot.png", width = 10, height = 5, 
         units="in", dpi=350)

# Centrality plot (symptomalogy)
centralityPlot(Net1graph,
               include = c("Strength",
                           "Closeness",
                           "Betweenness",
                           "ExpectedInfluence")) 
dev.off()

# Centrality table 
centrality(Net1graph)

# ToDo weights matrix and other metrics
W <- getWmat(Net1graph)
View(W)
