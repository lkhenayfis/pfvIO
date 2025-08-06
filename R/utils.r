# SCHEMA.R -----------------------------------------------------------------------------------------

#' Validador De Nomes De Tabelas Do Banco
#' 
#' Checa se os nomes em `tabelas` sao nomes validos no schema do banco
#' 
#' O PFV atualmente suporta as tabelas
#' 
#' * `usinas`
#' * `potencia_disponivel_observada`
#' * `geracao_observada`
#' * `corte_observado`
#' * `irradiancia_prevista`
#' * `melhor_historico_geracao`
#' * `melhor_historico_geracao_sem_cortes`
#' 
#' Qualquer nome diferente destes levantara um erro
#' 
#' @param tabelas um vetor de nomes de tabelas a serem batidos contra as existentes no banco
#' 
#' @return `NULL` invisivel, se `tabelas` nao contiver nomes invalidos; levanta erro do contrario

valida_nomes_tabelas <- function(tabelas) {
    ref <- c(
        "usinas",
        "potencia_disponivel_observada",
        "geracao_observada",
        "corte_observado",
        "irradiancia_prevista",
        "melhor_historico_geracao",
        "melhor_historico_geracao_sem_cortes"
    )

    is_valid <- tabelas %in% ref

    if (!all(is_valid)) {
        invalidas <- tabelas[!is_valid]
        invalidas <- paste0(invalidas, collapse = ",")
        msg <- paste0("Tabelas [", invalidas, "] nao sao reconhecidas por `pfvIO`")
        stop(msg)
    }

    invisible(NULL)
}

# VALIDACAO.R --------------------------------------------------------------------------------------

#' Extratores De Caracteristicas De Tabela
#' 
#' Auxiliares para extrair de um schema os nomes, tipos e limites de cada coluna da tabela
#' 
#' @param tabela a tabela da qual extrair informacoes
#' 
#' @return nomes, tipos ou limites das colunas, dependendo da funcao chamada
#' 
#' @name guessers

#' @rdname guessers

guess_col_names <- function(tabela) {
    s <- get_schemas(tabela)[[1]]
    sapply(s$columns, "[[", "name")
}

#' @rdname guessers

guess_col_types <- function(tabela) {
    s <- get_schemas(tabela)[[1]]
    out <- sapply(s$columns, "[[", "type")
    names(out) <- guess_col_names(tabela)
    out
}

#' @rdname guessers

guess_col_limits <- function(tabela) {
    s <- get_schemas(tabela)[[1]]
    out <- lapply(s$columns, "[[", "limits")
    names(out) <- guess_col_names(tabela)
    out <- out[!sapply(out, is.null)]
    out
}