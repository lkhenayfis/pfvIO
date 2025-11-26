test_that("valida_filtra_tabelas", {

    nomes <- c(
        "usinas",
        "potencia_disponivel_observada",
        "geracao_observada",
        "corte_observado",
        "irradiancia_prevista",
        "melhor_historico_geracao",
        "melhor_historico_geracao_sem_cortes"
    )

    expect_equal(valida_filtra_tabelas(nomes), nomes)
    expect_equal(valida_filtra_tabelas(paste0(nomes, ".parquet.gzip")), nomes)

    nomes[1] <- "nome_novo"
    expect_error(valida_filtra_tabelas(nomes))
})

test_that("valida_nomes_colunas", {

    dd <- fread(system.file("extdata/input/usinas.csv", package = "pfvIO"))
    nomes <- c("id_usina", "latitude", "longitude", "capacidade_instalada_MW", "data_inicio_operacao_comercial")
    expect_no_error(valida_nomes_colunas(dd, nomes))

    nomes[1] <- "erro"
    expect_error(valida_nomes_colunas(dd, nomes))

    nomes <- nomes[-1]
    expect_no_error(valida_nomes_colunas(dd, nomes))
})

test_that("valida_tipos_colunas", {

    dd <- fread(system.file("extdata/input/usinas.csv", package = "pfvIO"))
    tipos <- structure(
        c("character", "numeric", "numeric", "numeric", "POSIXct"),
        names = c("id_usina", "latitude", "longitude", "capacidade_instalada_MW",
            "data_inicio_operacao_comercial")
    )
    expect_no_error(valida_tipos_colunas(dd, tipos))

    tipos[1] <- "erro"
    expect_error(valida_tipos_colunas(dd, tipos))

    tipos <- tipos[-1]
    expect_no_error(valida_tipos_colunas(dd, tipos))

    # garante que inteiros sao entendidos como numerico tambem
    dd[, capacidade_instalada_MW := as.integer(capacidade_instalada_MW)]
    expect_no_error(valida_tipos_colunas(dd, tipos))
})

test_that("valida_limites_colunas", {

    dd <- fread(system.file("extdata/input/usinas.csv", package = "pfvIO"))
    limites <- structure(
        list(latitude = c(-90, 90), longitude = c(-180, 180), capacidade_instalada_MW = c(0, Inf)),
        names = c("latitude", "longitude", "capacidade_instalada_MW")
    )
    expect_no_error(valida_limites_colunas(dd, limites))

    limites[[1]] <- "erro"
    expect_error(valida_limites_colunas(dd, limites))

    limites[[1]] <- 1
    expect_error(valida_limites_colunas(dd, limites))

    limites[[1]] <- c(1:10)
    expect_error(valida_limites_colunas(dd, limites))

    limites <- limites[-1]
    expect_no_error(valida_limites_colunas(dd, limites))
})
