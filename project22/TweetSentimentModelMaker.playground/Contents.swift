import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/Will_Lowry/Downloads/twitter-sanders-apple3.csv"))

let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Will Lowry", shortDescription: "A model trained to classify sentiment on tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/Will_Lowry/Downloads/TweetSentimentClassifier.mlmodel"))

