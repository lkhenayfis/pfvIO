# estes testes sao propositalmente muito simples, uma vez que a parte de validacao ja e testada
# de forma dedicada e o backend `dbinterface` tambem e exaustivamente testado por si so

test_that("get_usinas", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_usinas(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "usinas", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_usinas(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "usinas", id_usina = "BAUFI3")
    )
})

test_that("get_corte_observado", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_corte_observado(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "corte_observado", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_corte_observado(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "corte_observado", id_usina = "BAUFI3")
    )
})

test_that("get_geracao_observada", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_geracao_observada(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "geracao_observada", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_geracao_observada(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "geracao_observada", id_usina = "BAUFI3")
    )
})

test_that("get_irradiancia_observada", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_irradiancia_observada(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "irradiancia_observada", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_irradiancia_observada(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "irradiancia_observada", id_usina = "BAUFI3")
    )
})

test_that("get_irradiancia_prevista", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_irradiancia_prevista(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "irradiancia_prevista", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_irradiancia_prevista(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "irradiancia_prevista", id_usina = "BAUFI3")
    )
})

test_that("get_melhor_historico_geracao_sem_cortes", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_melhor_historico_geracao_sem_cortes(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "melhor_historico_geracao_sem_cortes", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_melhor_historico_geracao_sem_cortes(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "melhor_historico_geracao_sem_cortes", id_usina = "BAUFI3")
    )
})

test_that("get_melhor_historico_geracao", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_melhor_historico_geracao(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "melhor_historico_geracao", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_melhor_historico_geracao(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "melhor_historico_geracao", id_usina = "BAUFI3")
    )
})

test_that("get_potencia_disponivel_observada", {
    conn_local <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dt <- get_potencia_disponivel_observada(conn_local, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_local, "potencia_disponivel_observada", id_usina = "BAUFI3")
    )

    conn_s3 <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dt <- get_potencia_disponivel_observada(conn_s3, id_usina = "BAUFI3")
    expect_identical(
        dt,
        dbinterface::getfromdb(conn_s3, "potencia_disponivel_observada", id_usina = "BAUFI3")
    )
})

test_that("get_config", {
    local <- system.file("extdata/", package = "pfvIO")
    conn_local <- conectamock_pfv(local)
    config_local <- get_config(conn_local)
    expect_equal(config_local, list(nome = 1))

    s3 <- "s3://ons-pem-historico/solar/pfvIO-teste"
    conn_s3 <- conectamock_pfv(s3)
    config_s3 <- get_config(conn_s3)
    expect_equal(config_s3, list(nome = 1))
})