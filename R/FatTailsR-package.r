



#' @title Package FatTailsR 
#'
#' @description
#' A set of functions to manipulate power hyperbolas, 
#' power hyperbolic functions and Kiener distributions of  
#' type I, II, III and IV which exhibit left and right fat tails  
#' like those that occur in financial markets. These distributions 
#' can be used to estimate with a high accuracy market risks,  
#' value-at-risk and expected shortfalls. 
#' Download the pdf cited in the references to get an overview of  
#' the theoretical part and several examples on stocks and indices.
#' 
#' @details
#' With so many functions, this package could look fat. But it's not! 
#' It's rather agile and easy to use! It addresses two topics: 
#' power hyperbolic functions and Kiener distributions. 
#' The various functions can be assigned to the following groups:
#' \enumerate{
#'   \item Miscellaneous functions for general purpose:
#'         \itemize{
#'         \item \code{\link{logit}}, invlogit.
#'         }
#'   \item Miscellaneous functions for power hyperbolas: 
#'         \itemize{
#'         \item \code{\link{kashp}}, dkashp_dx, ashp.
#'         }
#'   \item Power hyperbolas and power hyperbolic functions: 
#'         \itemize{
#'         \item \code{\link{exphp}}, coshp, sinhp, tanhp, sechp, cosechp, 
#'               cotanhp.
#'         }
#'   \item Inverse power hyperbolas and inverse power hyperbolic functions:  
#'         \itemize{
#'         \item \code{\link{loghp}}, acoshp, asinhp, atanhp, asechp, 
#'               acosechp, acotanhp.
#'         }
#'   \item The logishp function and its variants which combines the logistic 
#'         function and the power hyperbolas: 
#'         \itemize{
#'         \item d, p, q, r, dp, dq, l, dl, ql \code{\link{logishp}}.
#'         }
#'   \item The Kiener distributions of type I, II, III and IV:
#'         \itemize{
#'         \item d, p, q, r, dp, dq, l, dl, ql \code{\link{kiener1}},
#'         \item d, p, q, r, dp, dq, l, dl, ql \code{\link{kiener2}},
#'         \item d, p, q, r, dp, dq, l, dl, ql \code{\link{kiener3}},
#'         \item d, p, q, r, dp, dq, l, dl, ql \code{\link{kiener4}}.
#'         }
#'   \item Conversion functions between parameters pertaining to Kiener 
#'         distributions of type II, III and IV:
#'         \itemize{
#'         \item \code{\link{aw2k}}, aw2d, aw2e, kd2a, kd2w, ke2a, ke2w, ke2d, 
#'                kd2e, de2k.
#'         }
#'   \item Regression functions to estimate the distribution parameters 
#'         of a given dataset with Kiener distributions and Laplace-Gauss
#'         normal distribution:
#'         \itemize{
#'         \item \code{\link{regkienerLX}}, \code{\link{laplacegaussnorm}}.
#'         }
#' }
#' For a quick start on Kiener distributions, jump to the function 
#' \code{\link{regkienerLX}} and run the examples. 
#' Then, download and read the document in pdf format cited in the references 
#' which gives a complete overview on all functions. 
#' Finally, explore the other examples. 
#' 
#' @references
#' P. Kiener, Explicit models for bilateral fat-tailed distributions and 
#' applications in finance with the package FatTailsR, 8th R/Rmetrics Workshop 
#' and Summer School, Paris, 27 June 2014. Download it from: 
#' \url{http://www.inmodelia.com/exemples/2014-0627-Rmetrics-Kiener-en.pdf}
#'
#' @keywords symbolmath distribution models
#' 
#' @examples     
#' 
#' require(graphics)
#' require(minpack.lm)
#' require(timeSeries)
#' 
#' prices2returns <- function(x) { 100*diff(log(x)) }
#' 
#' ### Load the various datasets (1-16)
#' DS <- list(
#' "USDCHF"       = prices2returns(as.numeric(USDCHF)) ,
#' "Microsoft"    = prices2returns(as.numeric(MSFT[,4])) ,
#' "DAX"          = prices2returns(as.numeric(EuStockMarkets[,1])) ,
#' "SMI"          = prices2returns(as.numeric(EuStockMarkets[,2])) ,
#' "CAC"          = prices2returns(as.numeric(EuStockMarkets[,3])) ,
#' "FTSE"         = prices2returns(as.numeric(EuStockMarkets[,4])) ,
#' "SBI"          = as.numeric(LPP2005REC[,1]) ,
#' "SPI"          = as.numeric(LPP2005REC[,2]) ,
#' "SII"          = as.numeric(LPP2005REC[,3]) ,
#' "LMI"          = as.numeric(LPP2005REC[,4]) ,
#' "MPI"          = as.numeric(LPP2005REC[,5]) ,
#' "ALT"          = as.numeric(LPP2005REC[,6]) ,
#' "LPP25"        = as.numeric(LPP2005REC[,7]) ,
#' "LPP40"        = as.numeric(LPP2005REC[,8]) ,
#' "LPP60"        = as.numeric(LPP2005REC[,9]) ,
#' "sunspot.year" = prices2returns(as.numeric(sunspot.year)+1000) )
#' 
#' 
#' ### Select one dataset number (1-16)
#' j      <- 5
#' 
#' ### and run this block
#' X      <- DS[[j]]
#' nameX  <- names(DS)[j]
#' reg    <- regkienerLX(X)
#' lgn    <- laplacegaussnorm(X)
#' lleg   <- c("logit(0.999) = 6.9", "logit(0.99)   = 4.6", 
#'            "logit(0.95)   = 2.9", "logit(0.50)   = 0", 
#'            "logit(0.05)   = -2.9", "logit(0.01)   = -4.6", 
#'            "logit(0.001) = -6.9  ")
#' pleg   <- c( paste("m =",  reg$coefr4[1]), paste("g  =", reg$coefr4[2]), 
#'              paste("k  =", reg$coefr4[3]), paste("e  =", reg$coefr4[4]) )
#' 
#' ## Main plot
#' op     <- par(mfrow = c(1,1), mgp = c(1.5,0.8,0), mar = c(3,3,2,1))
#' plot(reg$dfrXP, main = nameX)
#' legend("top", legend = pleg, cex = 0.9, inset = 0.02 )
#' lines(reg$dfrEP, col = 2, lwd = 2)
#' points(reg$dfrQkPk, pch = 3, col = 2, lwd = 2, cex = 1.5)
#' lines(lgn$dfrXPn, col = 2, lwd = 2)
#' 
#' ## Plot F(X) > 0,97
#' front = c(0.06, 0.39, 0.50, 0.95)
#' par(fig = front, new = TRUE, mgp = c(1.5, 0.6, 0), las = 0)
#' plot( reg$dfrXP[which(reg$dfrXP$P > 0.97),] , pch = 1, xlab = "", ylab = "", main = "F(X) > 0,97" )
#' lines(reg$dfrEP[which(reg$dfrEP$P > 0.97),], type="l", col = 2, lwd = 3 )
#' lines(lgn$dfrXPn[which(lgn$dfrXPn$Pn > 0.97),], type = "l", col = 7, lwd= 2 )
#' points(reg$dfrQkPk, pch = 3, col = 2, lwd = 2, cex = 1.5)
#' points(lgn$dfrQnPn, pch = 3, col = 7, lwd = 2, cex = 1)
#' 
#' ## Plot F(X) < 0,03
#' front = c(0.58, 0.98, 0.06, 0.61)
#' par(fig = front, new = TRUE, mgp = c(0.5, 0.6, 0), las = 0 )
#' plot( reg$dfrXP[which(reg$dfrXP$P < 0.03),] , pch = 1, xlab = "", ylab = "", main = "F(X) < 0,03")
#' lines(reg$dfrEP[which(reg$dfrEP$P < 0.03),], type = "l", col = 2, lwd = 3 )
#' lines(lgn$dfrXPn[which(lgn$dfrXPn$Pn < 0.03),], type = "l", col= 7, lwd= 2 )
#' points(reg$dfrQkPk, pch = 3, col = 2, lwd = 2, cex = 1.5)
#' points(lgn$dfrQnPn, pch = 3, col = 7, lwd = 2, cex = 1)
#' ### End block
#' 
#' 
#' @import  minpack.lm
#' @import  stats
#' @aliases fattailsR
#' @aliases fattailsr
#' @aliases FatTailsR
#' @aliases FatTailsR-package
#' @name    FatTailsR-package
#' @docType package
NULL
