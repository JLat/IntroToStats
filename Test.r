# Calculate power using R
alpha <- 0.03
sigma <- 0.25
mu_generic <- 1.4
n <- 36

# Find the critical z-values
z_alpha <- qnorm(1 - alpha / 2)

# Calculate the z-score for mu_generic
z <- (mu_generic - 1.5) / (sigma / sqrt(n))

# Calculate the power
power <- pnorm(z, lower.tail = FALSE) + pnorm(-z, lower.tail = TRUE)

print(power)
