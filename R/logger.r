#' Gera Um Objeto [`lgr::Logger`]
#' 
#' Funcao interna para uso no loading do pacote, nao deve ser chamada diretamente pelo usuario
#' 
#' @param level nivel de logging. Procura a variavel de ambiente `"LOG_LEVEL"` e, caso nao exista,
#'     usa `"info"`
#' 
#' @return objeto [`lgr::Logger`]

logger_setup <- function(level = Sys.getenv("LOG_LEVEL", unset = "info")) {
    lg <- lgr::get_logger()
    lg$set_threshold(level)
    layout <- lgr::LayoutFormat$new(timestamp_fmt = "%Y-%m-%d %H:%M:%S")
    lg$appenders$console$set_layout(layout)

    lg
}

#' Getter Do Logger Interno Do Pacote
#'
#' Funcao auxiliar para acesso ao logger do pacote
#'
#' @return objeto [`lgr::Logger`] gerado por [`logger_setup`]
#'
#' @export

get_pkg_logger <- function() {
    get("lg", envir = asNamespace("pfvIO"))
}
