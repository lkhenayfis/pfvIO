#' Adiciona Elementos `uri` e `fileType` A Um Schema
#' 
#' Auxiliar para compatibilizar o schema fixo com partes dinamicas, dependendo da fonte de dados
#' 
#' @param schema um schema unitario lido por `get_single_schema()`
#' @param uri string indicando a uri a substituir
#' @param fileType string indicando a extensao (com `"."` inicial) a substituir
#' 
#' @return `schema` com elementos `uri` e `fileType` substituidos

fix_uri_filetype <- function(schema, uri, fileType) {
    schema$uri <- uri
    schema$fileType <- fileType
    return(schema)
}

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
        name = "geracao_observada",
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
        name = "corte_observado",
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
        name = "irradiancia_prevista",
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
        name = "melhor_historico_geracao",
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

get_schema_melhor_historico_geracao_sem_cortes <- function() {
    list(
        name = "melhor_historico_geracao_sem_cortes",
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
