# Stats Functions Cheat Sheet


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [Stats Functions Cheat Sheet](#stats-functions-cheat-sheet)
  - [Definition](#definition)
    - [Bayes Theorem](#bayes-theorem)
    - [Gold Standard](#gold-standard)
    - [Binomial Distribution](#binomial-distribution)
    - [Poisson Random Variable](#poisson-random-variable)
    - [Normal Distribution](#normal-distribution)
    - [The Central Limit Theorem](#the-central-limit-theorem)
    - [Confidence Interval](#confidence-interval)
    - [Confidence Interval for a T-Test (Unknown population variance)](#confidence-interval-for-a-t-test-unknown-population-variance)
    - [Propeties of a Sampling Distribution](#propeties-of-a-sampling-distribution)
    - [2 Sample T-Test Unequal Variances](#2-sample-t-test-unequal-variances)
  - [Equations](#equations)
    - [Mean](#mean)
    - [Expected Value](#expected-value)
    - [Standard Deviation](#standard-deviation)
    - [Variance](#variance)
    - [Gold Standard](#gold-standard-1)
    - [Bayes Theorem](#bayes-theorem-1)
    - [Normal Distribution](#normal-distribution-1)
    - [Poisson Distribution](#poisson-distribution)
    - [Combination](#combination)
    - [Central Limit Theorem](#central-limit-theorem)
    - [Confidence Interval](#confidence-interval-1)
- [R Overview](#r-overview)
  - [Basics:](#basics)
    - [Creating a variable](#creating-a-variable)
    - [Creating a new list of numbers:](#creating-a-new-list-of-numbers)
    - [Creating a new list of Strings (words)](#creating-a-new-list-of-strings-words)
  - [Statistics Functions:](#statistics-functions)
    - [Simple Functions:](#simple-functions)
    - [Normal Distribution](#normal-distribution-2)
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

These are Brianna's notes

### Bayes Theorem
$$ P(A | B) = {P(B | A) \cdot P(A) \over P(B) }$$

### Gold Standard

| Test | D | $D^c$ ||
|-|-|-|-
| + | a | b | a+b|
-|c|d|c+d
Total| a+c|b+d|N


```math
\displaylines{
\text{Sensitivity (True Positive)} = P(+ | D) = {a \over (a + c)}\\
\text{Specificity (True Negative)} = P(- | D^c) = {d \over (b + d)}\\
\text{Positive predictive value (PPV)} = P(D | +) = {P(+|D)P(D) \over {P(+|D)P(D) + P(+|D^c)P(D^c)}} = { (Sens)(Prev) \over (Sens)(Prev) + (1-Spec)(1-Prev)}= {TP \over TP + FP} \\
\text{Negative predictive value (NPV)} = P(D^c | -) = {{P(-|D^c)P(D^c) \over P(-|D^c)P(D^c) + P(-|D)P(D)}} = {(Spec)(1-Prev)\over (Spec)(1 -Prev) + (1- Sens)(Prev)} =  {TN \over TN + FN}
}
```

You can't use a contingency table for PPV & NPV. Study could have been designed to over sample those who are likely to have the disease

### Binomial Distribution

Notation: $X\sim Bin(n,p)$  
Probability of binomial events  
$P(X = x) = P (\text{x successes among n trials})$  
$\frac{n!}{x!(n-x)!}p^x(1-p)^n-x, \text{where x = 0,1,2...n}$

Population mean: $E(X) = n-p$  
Population variance: $Var(x) = np(1-p)$  
Population SD = $SD(X) = \sqrt{np(1-p)}$  

R Code
```
dbinom(x,n,p) binomial probability for a single x value
pbinom(x,n,p) binomial probability for values less then or equal to X
```

Assumption:
1. Fixed # of traits
2. Mutually exclusive
3. Independence
4. Consistent probability of success

### Poisson Random Variable
- Used for discrete distribution
- Used for counts of events in a fixed span of time, length, area, volume

Assumptions:
- The random variable is the number of occurrences of an event over a specified interval
- Occurrences are random
- The occurrences are independent of each other in an interval and between intervals
- The occurrences are uniformly distributed over the interval

$$ P(X = x) = P(\text{x events occur in given interval}) = {\lambda^x e^{-\lambda}\over x!} \text{where x = 0,1,2,3} $$ 

Notation: $X \sim P_o(\lambda)$  
Population mean = $E(x) = \lambda$  
Population variance: $Var(x) \approx \lambda$  
Population SD = $SD(X) = \sqrt{\lambda}$  

R Code:
```
dpois(x, lambda)  single value
ppois(x, lambda)  values < or equal to x
```

### Normal Distribution

Normal Probability Density Function:
$$f(x) = {1 \over \sigma \sqrt{2 \pi}} e^{-{1\over 2} {x - \mu \over \sigma}^2}$$

Notation: $X \sim N(\mu, \sigma^2)$ *Joel Note: internet says it isn't squared?*

Assumptions
1. Unimodal & max values occur at the population mean
2. Normla distribution is symmetric about the mean
3. Rangnge: $(-\infty, \infty)$
4. 68 - 95 - 99.7

Transforming non standard normal distribution to standard normal distribution

$Z = \frac{x - \mu}{\sigma}$ is standard normal $(z - N |0,1|)$

```
qqnorm()
qqline()
```

### The Central Limit Theorem
The standardized version of the sample mean $\overline{X}$ is approximately distributed accordingly
```math
\displaylines{
\overline{X} \sim N (\mu, \frac{\sigma^2}{n}) \rightarrow \frac{\overline{x} - \mu}{\sigma\over{\sqrt{n}}} \sim N(0,1)
}
```

Key Points:
1. The CLT applies regardless of distributions of the individual values
2. The quality of the normal approximation varies if the underlying distribution is normal, the approximation is perfect. If the underlying distribution is skewed, the approximation may be poor for small to moderate sample size
3. Sample size: 30 (at least)
4. SD = variability within a single sample
SError = variability across multiple sample means

### Confidence Interval

$\overline{X} \pm \text{ confidence coefficient} \frac{\sigma}{\sqrt{n}}$
point estimate $\pm$ (conf coef)(s.e)
confidence width: $2 Z_{1 - \alpha / 2}{\sigma \over \sqrt{2}}$
sample size: $\left( \frac{2Z_{1 - \alpha / 2}\sigma}{W} \right)^2$

Hypothesis test
1. Define $\mu$
2. Define $H_0$ & $H_1$
3. Set $\alpha = 0.05$
4. Assumptions: random sample from normal distributions, random sample of $n \ge 30$
5. $TS = \frac{\overline{x} - \mu}{\sigma\over{\sqrt{n}}} \sim N(0,1)$ under $H_0$
6. Reject $H_0$ if TS is large " $\rightarrow$ Reject if TS *Joel Note: WHAT?*
7. State the test statistic

### Confidence Interval for a T-Test (Unknown population variance)
$CI = x \pm t_{(n-1) \frac{\alpha}{2}}\frac{s}{\sqrt{n}}$ *Joel Note: I can't read your handwriting...*

Test statistic for hypothesis for an unknown variance.
$T = \frac{\overline{x}-\mu}{\frac{s}{\sqrt{n}}}$

One sample T-Test in R  
$H_1 > H_0$
```
t.test(variable name, mu = hypothesized value, alternative = "greater", conf.level = 0.95)
```
$H_1 < H_0$
```
t.test(variable name, mu = hypothesized value, alternative = "less", conf.level = 0.95)
```

$H_1 \neq H_0$ *Joel Note How is this different then the cases above then?*
```
t.test(variable name, mu = hypothesized value, conf.level = 0.95)
```

Power Calculations
*Joel Note: I can not tell what symbol this was supposed to be*
```math
\displaylines{
H_1 \mu > \mu_0 Power = P(z > z_{1-\alpha} - d\sqrt{n}) \\
H_1 \mu< \mu_0  Power = P(z < z_{1-\alpha} - d\sqrt{n})
}
```

### Propeties of a Sampling Distribution

```math
\displaylines{
\overline{x}_1 - \overline{x}_2 \\
\mu_{\overline{x}_1 - \overline{x}_2} = E(\overline{x}_1 - \overline{x}_2) = E(\overline{x}_1) - E(\overline{x}_2) = \mu_1 - \mu_2\\
\sigma^2_{\overline{x}_1 - \overline{x}_2} = var(\overline{x}_1) + var(\overline{x}_2) = \frac{\sigma^2_1}{n_1} + \frac{\sigma^2_2}{n_2}
}
```
Notation: $\overline{x}_1 - \overline{x}_2 \sim N (\mu_1 - \mu_2 \frac{\sigma^2_1}{n_1} + \frac{\sigma^2_2}{n_2})$

Necessary assumption
- Both groups are independent
- Sufficiently large sample > 30 for each group
- Normality check w/ qq c histogram

equal varaince
```math
\displaylines{
CI = (\overline{x}_1 - \overline{x}_2) \pm t_{n_1 + n_2 - 2}, \frac{\alpha}{2} s \sqrt{\frac{1}{n_1} + \frac{1}{n+_2}}
}
```
*Joel Note: Would recommend not writing math formulas with a caligraphy pen...

2 Sample T-Test
$H_0: \mu_1 - \mu_0 = 0 \rightarrow \mu1 = \mu2\text{ vs } H_1: \mu_1 -\mu_2 \neq 0 \rightarrow \mu_1 \neq \mu2$

Assumptions
- 2 independent groups
- 2 normally distributed groups
- Equal variance

```math
\displaylines{
T = \frac{\overline{x}_1 - \overline{x}_2 - \mu_1 - \mu_2}{s\sqrt{\frac{1}{n_1} + \frac{1}{n_2}}} \text{ where } S = \sqrt{(n_1-1)s_1^2 + (n_2-1)s_2^2}\\
T = t_{n_1 + n+2 - 2} \text{ under } H_0 \rightarrow T - t_20
}
```

### 2 Sample T-Test Unequal Variances
```math
\displaylines{
T = \frac{\overline{x}_1 - \overline{x}_2 - \mu_1 - \mu_2}{s\sqrt{\frac{1}{n_1} + \frac{1}{n_2}}} \sim tdf \text{ under } H_0\\
df = \frac{(v_1 + v_2)^2}{\frac{v_1^2}+{n_1 -1} + \frac{v_2^2}+{n_2 -1}}\text{ where } \frac{s_1^2}{n_1}v_2\frac{s_2^2}{n_2}
}
```
*Joel Note: What?*

CI for a difference of means & unequal variance
$(\overline{x}_1 - \overline{x}_2)\pm t_df \frac{\alpha}{2}\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}$

R Code
```
#Two sample t-test & CI
#Alternative Hypothesis
t.test(variabke ~ group, alternative, varequal=False, conf.interval=0.95)

#Two smaple test
t.test(varible ~ group, alternative, varequal=False, conf.interval=0.95)
```

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
