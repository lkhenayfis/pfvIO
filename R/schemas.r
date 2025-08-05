#' Getter De Schemas De Tabelas
#' 
#' Wrapper para buscar schemas de multiplas tabelas suportadas pelo pacote
#' 
#' @param tabelas vetor com nomes de tabelas; sera validado e retorna erro caso alguma tabela
#'     solicitada nao conste no schema do pfv
#' 
#' @return lista nomeada de schemas por tabela

get_schemas <- function(tabelas) {
    valid_tabelas(tabelas)
    out <- lapply(tabelas, get_single_schema)
    names(out) <- tabelas
    return(out)
}

#' Getter De Schema Unitario
#' 
#' Wrapper para buscar schema de uma unica tabela
#' 
#' @param tabela nome da tabela cujo schema deve ser buscado
#' 
#' @return lista representando schema da tabela

get_single_schema <- function(tabela) {
    fun <- str2lang(paste0("get_schema_", tabela))
    cc  <- as.call(list(fun))
    eval(cc)
}

# SCHEMAS INDIVIDUAIS ------------------------------------------------------------------------------

#' Wrappers De Schemas Individuais
#' 
#' Funcoes dummy que retornam um schema para cada tabela suportada pelo pfv
#' 
#' @return lista representando o schema da tabela
#' 
#' @name getters_schemas_individuais
NULL

#' @rdname getters_schemas_individuais

get_schema_usinas <- function() {
    list(
        name = "usinas",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_usina", type = "character"),
            list(name = "latitude", type = "numeric"),
            list(name = "longitude", type = "numeric"),
            list(name = "capacidade_instalada_MW", type = "numeric"),
            list(name = "data_inicio_operacao_comercial", type = "POSIXct")
        )
    )
}

#' @rdname getters_schemas_individuais

get_schema_potencia_disponivel_observada <- function() {
    list(
        name = "potencia_disponivel_observada",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_fonte_observacao", type = "character"),
            list(name = "id_usina", type = "character"),
            list(name = "data_hora_observacao", type = "POSIXct"),
            list(name = "valor", type = "numeric"),
            list(name = "status", type = "integer")
        )
    )
}

#' @rdname getters_schemas_individuais

get_schema_geracao_observada <- function() {
    list(
        name = "potencia_disponivel_observada",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_fonte_observacao", type = "character"),
            list(name = "id_usina", type = "character"),
            list(name = "data_hora_observacao", type = "POSIXct"),
            list(name = "valor", type = "numeric"),
            list(name = "status", type = "integer")
        )
    )
}

#' @rdname getters_schemas_individuais

get_schema_corte_observado <- function() {
    list(
        name = "potencia_disponivel_observada",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_fonte_observacao", type = "character"),
            list(name = "id_usina", type = "character"),
            list(name = "data_hora_observacao", type = "POSIXct"),
            list(name = "valor", type = "numeric"),
            list(name = "status", type = "integer")
        )
    )
}

#' @rdname getters_schemas_individuais

get_schema_irradiancia_prevista <- function() {
    list(
        name = "potencia_disponivel_observada",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_modelo_nwp", type = "character"),
            list(name = "latitude", type = "numeric"),
            list(name = "longitude", type = "numeric"),
            list(name = "data_hora_rodada", type = "POSIXct"),
            list(name = "data_hora_previsao", type = "POSIXct"),
            list(name = "valor", type = "numeric")
        )
    )
}

#' @rdname getters_schemas_individuais

get_schema_melhor_historico_geracao <- function() {
    list(
        name = "potencia_disponivel_observada",
        description = "",
        uri = "",
        fileType = "",
        columns = list(
            list(name = "id_fonte_observacao", type = "character"),
            list(name = "id_usina", type = "character"),
            list(name = "data_hora_observacao", type = "POSIXct"),
            list(name = "valor", type = "numeric"),
            list(name = "status", type = "integer")
        )
    )
}
