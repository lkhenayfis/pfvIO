test_that("coltype2dbrenovaveis", {
    schema <- get_schema_usinas()
    schema$columns <- list(
        list(name = "col1", type = "character"),
        list(name = "col2", type = "numeric"),
        list(name = "col3", type = "integer"),
        list(name = "col4", type = "Date"),
        list(name = "col5", type = "POSIXct")
    )
    schema2 <- coltype2dbrenovaveis(schema)

    expect_identical(
        schema[-which(names(schema) == "columns")],
        schema2[-which(names(schema2) == "columns")]
    )

    types <- sapply(schema$columns, "[[", "type")
    types2 <- sapply(schema2$columns, "[[", "type")

    expect_true(types2[types == "character"] == "string")
    expect_true(types2[types == "numeric"] == "float")
    expect_true(types2[types == "integer"] == "int")
    expect_true(types2[types == "Date"] == "date")
    expect_true(types2[types == "POSIXct"] == "datetime")
})

test_that("fix_uri_filetype", {
    schema <- get_schema_usinas()
    schema2 <- fix_uri_filetype(schema, "/caminho/teste", ".extensao.teste")

    expect_equal(schema2$uri, "/caminho/teste")
    expect_equal(schema2$fileType, ".extensao.teste")
})

test_that("get_schemas", {

    expect_identical(
        get_schemas("usinas")[[1]],
        get_schema_usinas()
    )

    expect_identical(
        get_schemas("corte_observado")[[1]],
        get_schema_corte_observado()
    )

    expect_identical(
        get_schemas("geracao_observada")[[1]],
        get_schema_geracao_observada()
    )

    expect_identical(
        get_schemas("irradiancia_prevista")[[1]],
        get_schema_irradiancia_prevista()
    )

    expect_identical(
        get_schemas("melhor_historico_geracao_sem_cortes")[[1]],
        get_schema_melhor_historico_geracao_sem_cortes()
    )

    expect_identical(
        get_schemas("melhor_historico_geracao")[[1]],
        get_schema_melhor_historico_geracao()
    )

    expect_identical(
        get_schemas("potencia_disponivel_observada")[[1]],
        get_schema_potencia_disponivel_observada()
    )

    expect_error(get_schemas("tabela_errada"))
})