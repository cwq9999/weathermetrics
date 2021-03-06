heat.index.algorithm <-
function (t = NA, rh = NA) 
{
    if (is.na(rh) | is.na(t)) {
        hi <- NA
    } else if (t <= 40) {
        hi <- t
    } else {
        alpha <- 61 + ((t - 68) * 1.2) + (rh * 0.094)
        hi <- 0.5*(alpha + t)
        if (hi > 79) {
            hi <- -42.379 + 2.04901523 * t + 10.14333127 * rh - 
                0.22475541 * t * rh - 6.83783 * 10^-3 * t^2 - 
                5.481717 * 10^-2 * rh^2 + 1.22874 * 10^-3 * t^2 * 
                rh + 8.5282 * 10^-4 * t * rh^2 - 1.99 * 10^-6 * 
                t^2 * rh^2
            if (rh <= 13 & t >= 80 & t <= 112) {
                adjustment1 <- (13 - rh)/4
                adjustment2 <- sqrt((17 - abs(t - 95))/17)
                total.adjustment <- adjustment1 * adjustment2
                hi <- hi - total.adjustment
            } else if (rh > 85 & t >= 80 & t <= 87) {
                adjustment1 <- (rh - 85)/10
                adjustment2 <- (87 - t)/5
                total.adjustment <- adjustment1 * adjustment2
                hi <- hi + total.adjustment
            }
        }
    }
    return(hi)
}
