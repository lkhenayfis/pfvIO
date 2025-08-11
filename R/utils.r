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