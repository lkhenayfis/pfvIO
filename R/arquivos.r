
#' Classifica Um Caminho De Acordo Com Fonte
#' 
#' Classifica um caminho de dados de acordo com ser local ou bucket no s3
#' 
#' @param uri caminho de dados a classificar
#' 
#' @return uri com classe `"uri_s3"` ou `"uri_local"`

classifica_uri <- function(uri) {
    is_s3 <- grepl("^s3://", uri)
    tipo <- ifelse(is_s3, "uri_s3", "uri_local")

    structure(uri, class = tipo)
}

#' Lista Arquivos Em Um Caminho
#' 
#' Wrapper para listar arquivos em um diretorio local ou bucket s3
#' 
#' @param uri string indicando um diretorio local ou bucket no s3
#' 
#' @return vetor de arquivos, sem caminho, existentes em `uri`

lista_arquivos <- function(uri) UseMethod("lista_arquivos")

#' @method lista_arquivos uri_local

lista_arquivos.uri_local <- function(uri) list.files(uri, pattern = supported_files(TRUE))

#' @method lista_arquivos uri_s3

lista_arquivos.uri_s3 <- function(uri) {
    splitted <- split_bucket_prefix(uri)
    arqs <- aws.s3::get_bucket(splitted[1], splitted[2])
    arqs <- sapply(unname(arqs), "[[", "Key")
    arqs <- arqs[sapply(arqs, grepl, pattern = supported_files(TRUE))]
    sub(".*/", "", arqs)
}

#' Identifica Extensao De Arquivo
#' 
#' @param arquivos lista de nomes de arquivos
#' 
#' @return vetor com comprimento de `arquivos` contendo a extensao de cada um

id_tipo_arquivo <- function(arquivos) {
    exts <- strsplit(arquivos, "\\.")
    exts <- sapply(exts, function(e) {
        e <- e[-1]
        e <- paste0(e, collapse = ".")
        paste0(".", e)
    })
    exts
}

#' Wrapper De Lista De Tipos De Arquivos Suportados
#' 
#' Funcao dummy que retorna vetor de extensoes suportadas, opcionalmente como padrao para regex
#' 
#' Atualmente sao suportados os seguintes tipos de arquivos tabulares
#' 
#' * `.csv`
#' * `.parquet`
#' * `.parquet.gzip`
#' 
#' ... e arquivos de lista chave-valor
#' 
#' * `.json`
#' * `.jsonc`
#' 
#' @param as_regex booleano indicando se extensoes devem ser retornadas como padrao para regex
#' 
#' @return se `as_regex = FALSE` (padrao), vetor de extensoes; do contrario uma string combinando
#'     todas em padrao para uso com funcoes de regex (`sub`, `grep` e etc.)

supported_files <- function(as_regex = FALSE) {
    files <- c(".csv", ".parquet", ".parquet.gzip", ".json", ".jsonc")
    if (as_regex) {
        files <- paste0(files, collapse = "|")
        files <- paste0("(", files, ")$")
    }

    return(files)
}

# HELPERS ------------------------------------------------------------------------------------------

#' Helper Para Parse De Uri s3
#' 
#' Separa uma uri s3 em dois elementos: bucket e prefixo
#' 
#' @param uri caminho completo no s3 
#' 
#' @return vetor de duas posicoes: bucket e prefixo separados de `uri`

split_bucket_prefix <- function(uri) {
    bucket <- regmatches(uri, regexpr("s3://([a-z]|[\\_\\-])+(?=/)", uri, perl = TRUE))
    prefix <- sub("s3://([a-z]|[\\_\\-])+/", "", uri, perl = TRUE)
    return(c(bucket, prefix))
}