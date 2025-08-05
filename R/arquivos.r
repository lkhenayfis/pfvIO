
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
#' @return vetor de arquivos existentes em `uri`

lista_arquivos <- function(uri) UseMethod("lista_arquivos")

#' @method lista_arquivos uri_local

lista_arquivos.uri_local <- function(uri) list.files(uri, full.names = TRUE)

#' @method lista_arquivos uri_s3

lista_arquivos.uri_s3 <- function(uri) {
    splitted <- split_bucket_prefix(uri)
    arqs <- aws.s3::get_bucket(splitted[1], splitted[2])
    arqs <- sapply(unname(arqs), "[[", "Key")
    file.path(splitted[1], arqs)
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
    bucket <- regmatches(uri, regexpr("s3://([a-z]|\\-)+(?=/)", uri, perl = TRUE))
    prefix <- sub("s3://([a-z]|\\-)+/", "", uri, perl = TRUE)
    return(c(bucket, prefix))
}