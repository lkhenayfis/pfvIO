#' Escritor De Artefato De Modelo
#' 
#' Wrapper para salvamento de artefatos de modelos gerados
#' 
#' @param object objeto a ser salvo
#' @param filename nome do arquivo do artefato a ser lido SEM EXTENSAO; por padrao todos os
#'     artefatos sao salvos como objetos rds
#' @param path caminho onde o artefato esta salvo
#' 
#' @return nao ha retorno; apenas salva `object` como `path/filename.rds`
#' 
#' @export

write_model_artifact <- function(object, filename, path) {
    filename <- paste0(filename, ".rds")
    path <- file.path(path, filename)
    path <- classifica_uri(path)
    wf  <- dbinterface:::switch_writer_func("rds", inherits(path, "uri_s3"))
    wf(object, path)
}

#' Escritor De Dados Tabelados
#' 
#' Wrapper para salvamento de dados tabelados em formatos suportados
#' 
#' @param object objeto a ser salvo
#' @param filename nome do arquivo do artefato a ser lido INCLUINDO EXTENSAO; observe que apenas
#'     `c("csv", "parquet", "parquet.gzip")` sao suportados atualmente
#' @param path caminho onde o artefato esta salvo
#' 
#' @return nao ha retorno; apenas salva `object` como `path/filename.rds`
#' 
#' @export

write_dataset <- function(object, filename, path) {
    path <- file.path(path, filename)
    checa_extensao_suportada(filename)
    path <- classifica_uri(path)
    ext <- sub(".*\\.", "", filename)
    wf  <- dbinterface:::switch_writer_func(ext, inherits(path, "uri_s3"))
    wf(object, path)
}

checa_extensao_suportada <- function(filename) {
    ext <- sub(".*\\.", "", filename)
    sups <- c("csv", "parquet", "parquet.gzip")
    if (!(ext %in% sups)) {
        msg <- paste0("Extensao de arquivo .", ext, " nao e suportada pelo pfvIO")
        stop(msg)
    }
}