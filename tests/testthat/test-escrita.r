test_that("write_dataset", {
    path_local <- tempdir()
    write_dataset(mtcars, "mtcars_test.csv", path_local)
    dt <- fread(file.path(path_local, "mtcars_test.csv"))
    expect_equal(dt, as.data.table(mtcars))

    expect_error(write_dataset(mtcars, "mtcars_test.extnaosuportada", path_local))

    path_s3 <- "s3://ons-pem-historico/solar/"
    write_dataset(mtcars, "mtcars_test.csv", path_s3)
    dt_s3 <- aws.s3::s3read_using(fread, object = "solar/mtcars_test.csv",
        bucket = "ons-pem-historico", region = "sa-east-1")
    expect_equal(dt_s3, mtcars)
})