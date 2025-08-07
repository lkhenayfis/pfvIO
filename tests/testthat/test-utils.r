test_that("valida_nomes_tabelas", {

    nomes <- c(
        "usinas",
        "potencia_disponivel_observada",
        "geracao_observada",
        "corte_observado",
        "irradiancia_prevista",
        "melhor_historico_geracao",
        "melhor_historico_geracao_sem_cortes"
    )

    expect_null(valida_nomes_tabelas(nomes))

    nomes[1] <- "nome_novo"
    expect_error(valida_nomes_tabelas(nomes))
})

test_that("guessers", {

    # nomes

    nomes_usinas <- guess_col_names("usinas")
    expect <- c("id_usina", "latitude", "longitude",
        "capacidade_instalada_MW", "data_inicio_operacao_comercial")
    expect_true(all(nomes_usinas %in% expect))

    nomes_geracao_observada <- guess_col_names("geracao_observada")
    expect <- c("id_fonte_observacao", "id_usina", "data_hora_observacao", "valor", "status")
    expect_true(all(nomes_geracao_observada %in% expect))

    # tipos

    tipos_corte_obs <- guess_col_types("corte_observado")
    expect <- structure(
        c("character", "character", "POSIXct", "numeric", "integer"),
        names = c("id_fonte_observacao", "id_usina", "data_hora_observacao", "valor", "status")
    )
    expect_equal(tipos_corte_obs, expect)

    tipos_corte_obs <- guess_col_types("irradiancia_prevista")
    expect <- structure(
        c("character", "numeric", "numeric", "POSIXct", "POSIXct", "numeric"),
        names = c("id_modelo_nwp", "latitude", "longitude", "data_hora_rodada", "data_hora_previsao", "valor")
    )
    expect_equal(tipos_corte_obs, expect)

    # limites

    limites_pot_disp <- guess_col_limits("potencia_disponivel_observada")
    expect_equal(limites_pot_disp, list(valor = c(0, Inf)))

    limites_pot_disp <- guess_col_limits("usinas")
    expect <- list(latitude = c(-90, 90), longitude = c(-180, 180), capacidade_instalada_MW = c(0, Inf))
    expect_equal(limites_pot_disp, expect)
})