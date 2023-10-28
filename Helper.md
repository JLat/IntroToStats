# Stats Functions Cheat Sheet


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Stats Functions Cheat Sheet](#stats-functions-cheat-sheet)
  - [Definition](#definition)
  - [Equations](#equations)
    - [Mean](#mean)
    - [Expected Value](#expected-value)
    - [Standard Deviation](#standard-deviation)
    - [Variance](#variance)
    - [Gold Standard](#gold-standard)
    - [Bayes Theorem](#bayes-theorem)
    - [Normal Distribution](#normal-distribution)
    - [Poisson Distribution](#poisson-distribution)
    - [Combination](#combination)
    - [Central Limit Theorem](#central-limit-theorem)
    - [Confidence Interval](#confidence-interval)
- [R Overview](#r-overview)
  - [Basics:](#basics)
    - [Creating a variable](#creating-a-variable)
    - [Creating a new list of numbers:](#creating-a-new-list-of-numbers)
    - [Creating a new list of Strings (words)](#creating-a-new-list-of-strings-words)
  - [Statistics Functions:](#statistics-functions)
    - [Simple Functions:](#simple-functions)
    - [Normal Distribution](#normal-distribution-1)
    - [Poisson Distribution](#poisson-distribution-1)
  - [Importing Data:](#importing-data)
  - [Dataset Filtering:](#dataset-filtering)
    - [Getting a specific column:](#getting-a-specific-column)
    - [Filter based off of column:](#filter-based-off-of-column)
  - [Procedures:](#procedures)
    - [Bootstraping](#bootstraping)
    - [Power](#power)
  - [Graphs:](#graphs)
    - [Histogram:](#histogram)
    - [Bar Graph](#bar-graph)
    - [Boxplot:](#boxplot)

<!-- /code_chunk_output -->

## Definition
to be added....

## Equations

### Mean
$$mean = \mu = {\text{sum of observations} \over \text{number of observations}} = {\sum x_i \over n}$$

### Expected Value
```math
\displaylines{
 E(X) = \sum X\cdot P(X) \\
 E(C \cdot X + N) = CE(X) + N
}
```

### Standard Deviation
$$ \text{standard devation} = \sigma = \sqrt {{1\over N} \sum (x_i - \mu)^2} $$

### Variance
```math
\displaylines{
variance = \sigma^2 ={1\over N} \sum (x_i - \mu)^2 \\
Var (C\cdot X + N) = C^2 Var(X)
}
```

### Gold Standard

```math
\displaylines{
\text{Sensitivity (True Positive)} = P(+ | D) = {a \over (a + c)}\\
\text{Specificity (True Negative)} = P(- | D^c) = {d \over (b + d)}\\
\text{Positive predictive value (PPV)} = P(D | +) = {P(+|D)P(D) \over {P(+|D)P(D) + P(+|D^c)P(D^c)}} = { (Sens)(Prev) \over (Sens)(Prev) + (1-Spec)(1-Prev)}= {TP \over TP + FP} \\
\text{Negative predictive value (NPV)} = P(D^c | -) = {{P(-|D^c)P(D^c) \over P(-|D^c)P(D^c) + P(-|D)P(D)}} = {(Spec)(1-Prev)\over (Spec)(1 -Prev) + (1- Sens)(Prev)} =  {TN \over TN + FN}
}
```


### Bayes Theorem
$$ P(A | B) = {P(B | A) \cdot P(A) \over P(B) }$$

### Normal Distribution
```math
\displaylines{
f(x) = {1 \over \sigma \sqrt{2 \pi}} e^{-{1\over 2} {x - \mu \over \sigma}^2} \\
P(X < x) = P({x - \mu_x\over \sigma} < Z) \rightarrow \text{use table} \\
P(X \geq x) = 1 - P(X < x)
}
```

### Poisson Distribution
$$ P(X = k) = {\lambda^k e^{-\lambda}\over k!} $$

### Combination
$${n \choose k} = {n! \over k! (n-k)!}$$

### Central Limit Theorem
- Holds for sample size > 35
```math
\displaylines{
\sigma_{\overline{x}} = \frac{\sigma}{\sqrt{n}} \\
\mu_{\overline{x}} = \mu\\
}
```

### Confidence Interval
```math
\displaylines{
CI = \overline{x} \pm Z_{1 - \alpha / 2} {s \over \sqrt{n}}\\
Width = W =  2 Z_{1 - \alpha / 2}{\sigma \over \sqrt{2}}\\
SampleSize = n = \left( \frac{2Z_{1 - \alpha / 2}\sigma}{W} \right)^2
}
```
# R Overview

## Basics:

### Creating a variable
newNum <- 1423\
newString <- "Yoshi"

### Creating a new list of numbers:
newList <- c(1,2,3,4,5)

### Creating a new list of Strings (words)
newList <- c("Yoshi", "Sally")


## Statistics Functions:

### Simple Functions:
* Five number summary
    * fivenum(newList)
* Mean
    * mean(newList)
* Median
    * median(newList)
* Mode
    * mode(newList)
* Standard Deviation
    * sd(newList)
* Variance
    * var(newList)
* Number of items
    * length(newList)

### Normal Distribution

* Solve PDF
    * dnorm( x, mean, sd)
* Get probability 
    * pnorm( quantity, mean, sd , lower.tail)
* Get quantity
    * qnorm( probability, mean, sd , lower.tail)

### Poisson Distribution
* Solve Poisson PDF
    * dpois( x, mean, sd)
* Get probability of certain number of successess
    * pnorm( number of successes, lambda)
* Get number of successess from probability
    * qnorm( percentile, lambda)

## Importing Data:
- Ensure file is in current working directory
- headers = true if first line has titles

importedData <- read.table("TextFileName.txt", header = TRUE)

## Dataset Filtering:
```
newDataSet <- data.frame(gender = c("F", "F", "F", "M", "M"), temperature = c(98, 99, 97, 98, 97))

    gender  temperature
1    F          98
2    F          99
3    F          97
4    M          98
5    M          97
```


### Getting a specific column:
temperature <- newDataSet$temperature
```
[1] 98 99 97 98 97
```
### Filter based off of column:
```
white_temperatures <- newDataSet[newDataSet$gender == "F",]

    gender  temperature
1    F          98
2    F          99
3    F          97
```

## Procedures:

### Bootstraping

```
originalData <- read.tables("TextFileName.txt", header = TRUE)
numBootstrapSteps <- 1000
sampleSize <- 75

data <- vector ('list', numBootStrapSteops)

for (i in 1:numBootstrapSteps){
    data[[i]] <- sample (originalData, sampleSize)
}

bootstrappedData <- unlist(lapply(data, mean))
```

### Power

```
install.packge("pwr")
require("pwr")
pwr.norm.test(d, n, sig.level, power, alternative)
```

## Graphs:

### Histogram:
```
histData <- c(4,6,2,5,3,6,4,2,4)
hist(data1, main = "TITLE", xlab = "X AXIS LABEL")
```


### Bar Graph
```
freq <- c(31,30,31)
label <- c("October", "November", "December")
barplot(freq, names.arg = label, xlab = "Month", ylab = "Number of days)
```



### Boxplot:
```
data1  <- c(19,17,23,20,19)
data2 <- c(23,27,25,24,25,25)
labels <- c("name1", "name2")
boxplot(data1, data2,  name = , main = "TITLE", ylab = "Y AXIS LABEL", xlab = "X AXIS LABEL")
```
