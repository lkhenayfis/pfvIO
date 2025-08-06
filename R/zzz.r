
.onLoad <- function(libname, pkgname) {
    lg <- logger_setup()
    assign("lg", lg, asNamespace("pfvIO"))
}

.onUnload <- function(libname, pkgname) {
    rm(lg, envir = asNamespace("pfvIO"))
}