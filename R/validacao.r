#' Validador Completo Para Dado Unico
#' 
#' Realiza validacao de nomes, tipos e limites de valores das colunas de uma tabela lida
#' 
#' @param dt dado lido por uma das funcoes `pfvio_getters`
#' @param nomes vetor de nomes esperados das colunas
#' @param tipos vetor nomeado (nomes iguais aos das colunas) de tipos de dado esperados das colunas
#' @param limites lista nomeada de (nomes iguais aos das colunas) de vetores indicando limite
#'     inferior e superior aceitaveis naquela coluna. Veja `valida_limites()`
#' 
#' @return `NULL` invisvel caso a validacao transcorra sem erros; levanta erro do contrario

valida_dado_singular_completo <- function(dt, nomes, tipos, limites) {
    val_nomes <- valida_nomes_colunas(dt, nomes)
    val_tipos <- valida_tipos_colunas(dt, tipos)
    val_limits <- valida_limites_colunas(dt, limites)

    invisible(NULL)
}

# AUXILIARES ---------------------------------------------------------------------------------------

#' Validador De Nomes De Colunas
#' 
#' Checa se colunas em `nomes` constam no dado `dt`
#' 
#' @param dt `data.table` no qual checar nomes
#' @param nomes vetor de nomes de colunas para procurar em `dt`
#' 
#' @return `NULL` se todos as checagens forem aprovadas; levanta erro do contrario

valida_nomes_colunas <- function(dt, nomes) {
    valid <- nomes %in% names(dt)
    all_valid <- all(valid)

    if (!all_valid) {
        not_valid <- nomes[!valid]
        msg <- paste0("Colunas [", paste0(not_valid, collapse = ","), "] nao encontradas em `dt`")
        stop(msg)
    } else {
        invisible(NULL)
    }
}

#' Validador De Tipos De Colunas
#' 
#' Checa se colunas do dado `dt` tem tipos declarados em `tipos`
#' 
#' `tipos` deve ser uma lista nomeada de tipos de dados (i.e. `"Date"`, `"numeric"` e etc.). Cada
#' elemento representa os tipos de valores da coluna correspondente a seu nome na lista. So serao
#' checadas as colunas com elementos homonimos em `tipos`
#' 
#' @param dt um `data.table` no qual realizar checagem
#' @param tipos lista nomeada de vetores numericos. Veja Detalhes
#' 
#' @return `NULL` se todos as checagens forem aprovadas; levanta erro do contrario

valida_tipos_colunas <- function(dt, tipos) {
    tipos <- extend_numeric(tipos)
    cols  <- names(tipos)
    valid <- sapply(cols, function(col) inherits(dt[[col]], tipos[[col]]))
    all_valid <- all(valid)

    if (!all_valid) {
        not_valid <- cols[!valid]
        msgs <- lapply(not_valid, function(col) {
            tipo <- paste0(tipos[[col]], collapse = ",")
            paste0("Coluna `", col, "` nao e do tipo '", tipo, "'")
        })
        msgs <- paste0(msgs, collapse = " -/- ")
        stop(msgs)
    } else {
        invisible(NULL)
    }
}

#' Aumenta Tipo `"numeric"` Para Conter `"integer"` Tambem
#' 
#' Auxiliar para validacao de tipos de colunas
#' 
#' @param tipos vetor ou lista nomeado de tipos de dados
#' 
#' @return `tipos` com posicoes originalmente `"numeric"` aumentadas para `c("numeric", "integer")`

extend_numeric <- function(tipos) {
    tipos <- as.list(tipos)
    is_numeric <- sapply(tipos, "==", "numeric")
    if (any(is_numeric)) {
        tipos[is_numeric] <- lapply(tipos[is_numeric], function(t) c("numeric", "integer"))
    }
    return(tipos)
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

#' Validador De Limites Numericos
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

valida_limites_colunas <- function(dt, limites) {
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
