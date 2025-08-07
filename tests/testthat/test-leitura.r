test_that("get_dataset", {

    # local

    conn <- conectamock_pfv(system.file("extdata/", package = "pfvIO"))
    dataset <- get_dataset(conn, id_usina = "BAUFI3")

    expect_identical(
        dataset$usinas,
        dbrenovaveis::getfromdb(conn, "usinas", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$corte_observado,
        dbrenovaveis::getfromdb(conn, "corte_observado", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$geracao_observada,
        dbrenovaveis::getfromdb(conn, "geracao_observada", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$irradiancia_prevista,
        dbrenovaveis::getfromdb(conn, "irradiancia_prevista", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$melhor_historico_geracao_sem_cortes,
        dbrenovaveis::getfromdb(conn, "melhor_historico_geracao_sem_cortes", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$melhor_historico_geracao,
        dbrenovaveis::getfromdb(conn, "melhor_historico_geracao", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$potencia_disponivel_observada,
        dbrenovaveis::getfromdb(conn, "potencia_disponivel_observada", id_usina = "BAUFI3")
    )

    # s3

    conn <- conectamock_pfv("s3://ons-pem-historico/solar/pfvIO-teste")
    dataset <- get_dataset(conn, id_usina = "BAUFI3")

    expect_identical(
        dataset$usinas,
        dbrenovaveis::getfromdb(conn, "usinas", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$corte_observado,
        dbrenovaveis::getfromdb(conn, "corte_observado", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$geracao_observada,
        dbrenovaveis::getfromdb(conn, "geracao_observada", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$irradiancia_prevista,
        dbrenovaveis::getfromdb(conn, "irradiancia_prevista", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$melhor_historico_geracao_sem_cortes,
        dbrenovaveis::getfromdb(conn, "melhor_historico_geracao_sem_cortes", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$melhor_historico_geracao,
        dbrenovaveis::getfromdb(conn, "melhor_historico_geracao", id_usina = "BAUFI3")
    )

    expect_identical(
        dataset$potencia_disponivel_observada,
        dbrenovaveis::getfromdb(conn, "potencia_disponivel_observada", id_usina = "BAUFI3")
    )
})
