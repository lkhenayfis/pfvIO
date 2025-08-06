

# AUXILIARES ---------------------------------------------------------------------------------------

valida_nomes_colunas <- function(dt, nomes) {
    valid <- all(nomes %in% names(dt))
}

#' Checa Se Valores Em `x` Pertencem Ao Intervalo Fechado `bounds`
#' 
#' @param x vetor numerico
#' @param bounds vetor de duas posicoes indicando o intervalo de dados
#' 
#' @return booleano indicando se todos os valores de `x` pertencem a `[bounds[1], bounds[2]]`

is_in_bounds <- function(x, bounds) {
    x <- na.omit(x)
    all(x %between% bounds)
}

#' Wrapper Para Validacao De Limites Numericos
#' 
#' Checa se colunas do dado `dt` pertencem aos intervalos declarados em `limites`
#' 
#' `limites` deve ser uma lista nomeada de vetores de duas posicoes cada. Cada vetor representa os
#' limites de valores da coluna correspondente a seu nome na lista. So serao checadas as colunas
#' com elementos homonimos em `limites`
#' 
#' @param dt um `data.table` no qual realizar checagem
#' @param limites lista nomeada de vetores numericos. Veja Detalhes
#' 
#' @return `NULL` se todos as checagens forem aprovadas; levanta erro do contrario

valida_limites <- function(dt, limites) {
    cols  <- names(limites)
    valid <- sapply(cols, function(col) is_in_bounds(dt[[col]], limites[[col]]))
    all_valid <- all(valid)

    if (!all_valid) {
        not_valid <- cols[!valid]
        msgs <- lapply(not_valid, function(col) {
            lims <- paste0(round(limites[[col]], 2), collapse = ",")
            paste0("Coluna `", col, "` nao possui valores no intervalo [", lims, "]")
        })
        msgs <- paste0(msgs, collapse = " -/- ")
        stop(msgs)
    } else {
        invisible(NULL)
    }
}
