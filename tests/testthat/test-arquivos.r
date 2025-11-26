test_that("uri_methods", {

    # local -------------------------------------

    local <- system.file("extdata/input", package = "pfvIO")
    uri <- classifica_uri(local)

    expect_equal(unclass(uri), local)
    expect_true(inherits(uri, "uri_local"))

    arqs <- lista_arquivos(uri)
    expect <- c("corte_observado.csv", "geracao_observada.csv", "irradiancia_prevista.csv",
        "irradiancia_observada.csv", "melhor_historico_geracao_sem_cortes.csv",
        "melhor_historico_geracao.csv", "potencia_disponivel_observada.csv", "usinas.csv", "config.jsonc")
    expect_true(all(arqs %in% expect))

    # s3 ----------------------------------------

    s3 <- "s3://ons-pem-historico/solar/pfvIO-teste"
    uri <- classifica_uri(s3)

    expect_equal(unclass(uri), s3)
    expect_true(inherits(uri, "uri_s3"))

    arqs <- lista_arquivos(uri)
    expect_true(all(arqs %in% expect))
})

test_that("id_tipo_arquivo", {
    arquivos <- c("test.csv", "arq.parquet", "file.parquet.gzip")
    exts <- id_tipo_arquivo(arquivos)
    expect_equal(exts, c(".csv", ".parquet", ".parquet.gzip"))
})

test_that("split_bucket_prefix", {
    uri <- "s3://nome_do_bucket/nome/do/prefixo_teste"
    splitted <- split_bucket_prefix(uri)
    expect_equal(splitted[[1]], "s3://nome_do_bucket")
    expect_equal(splitted[[2]], "nome/do/prefixo_teste")
})
