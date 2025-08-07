test_that("conectamock_pfv", {

    local <- system.file("extdata/", package = "pfvIO")
    conn_local <- conectamock_pfv(local)
    expect_true(inherits(conn_local, "mock"))
    expect_equal(attr(conn_local, "uri"), structure(local, class = "uri_local"))

    s3 <- "s3://ons-pem-historico/solar/pfvIO-teste"
    conn_s3 <- conectamock_pfv(s3)
    expect_true(inherits(conn_s3, "mock"))
    expect_equal(attr(conn_s3, "uri"), structure(s3, class = "uri_s3"))
})
