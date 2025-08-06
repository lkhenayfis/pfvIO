#' Getters De Dados
#' 
#' Wrappers para acesso as tabelas do PFV em uma determinada conexao
#' 
#' O argumento `...` permite passar argumentos homonimos de colunas da tabela, cujos valores serao
#' utilizados para realizar subset do dado.
#' 
#' Se a coluna e de string ou inteiros, o subset sera realizado buscando onde aquela coluna assume o
#' valor passado. Por exemplo, para um dado com uma coluna `classe`, passar o argumento
#' `classe = "nivel_1"` realizaria o subset de todas as linhas nas quais a coluna `classe` tem valor
#' `"nivel_1"`.
#' 
#' No caso de colunas de data ou datahora, existe uma implementacao especial para facilitar a
#' especificacao de faixas temporais. Nestes casos pode ser passada uma string no formato
#' `"YYYY[-MM-[DD[ HH[:MM[:SS]]]]]/YYYY[-MM-[DD[ HH[:MM[:SS]]]]]"`. As partes entre colchetes sao
#' opcionais, tanto no limite inicial quanto final. Ademais, pode ser passada uma string com apenas
#' um dos limites; neste caso sera interpretado como "tudo a partir de" (caso de somente limite
#' inicial) ou "tudo ate" (caso contrario).
#' 
#' @param conn um objeto de conexao com banco como gerado por `conectamock_pfv()`
#' @param ... definicoes de subset. Veja Detalhes e Exemplos
#' 
#' @return todas as funcoes retornam um `data.table`, de dado que depende de qual funcao foi
#'     chamada, com subsets em `...` aplicados
#' 
#' @examples 
#' 
#' # conexao com o banco
#' dir  <- system.file("extdata/", package = "pfvIO")
#' conn <- conectamock_pfv(dir)
#' 
#' # buscando geracao observada de uma usina especifica e todas as fontes
#' dt <- get_geracao_observada(conn, id_usina = "BAUFI1")
#' 
#' # mesma usina e apenas dados do PI
#' dt <- get_geracao_observada(conn, usina = "BAUFI1", id_fonte_observacao = "PI")
#' 
#' # conjunto de tres usinas e apenas dados do PI
#' dt <- get_melhor_historico_geracao(conn, id_usina = c("BAUFI1", "BAUFI2", "BAUFI3"))
#' 
#' # EXEMPLOS DE SUBSET DE DATA ---------------------------
#' 
#' # pegando apenas o dia de 2025-06-10
#' dt <- get_geracao_observada(conn, id_usina = "BAUFI1", data_hora_observacao = "2025-06-10")
#' 
#' # pegando janela 2025-06-20 10:00:00 a 2025-06-25 19:30:00
#' dt <- get_geracao_observada(conn, id_usina = "BAUFI1", data_hora_observacao = "2025-06-20 10:00:00/2025-06-25 19:30:00")
#' 
#' @name pfvio_getters
NULL

#' @rdname pfvio_getters

get_usinas <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "usinas", ...)
}

#' @rdname pfvio_getters

get_potencia_disponivel_observada <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "potencia_disponivel_observada", ...)
}

#' @rdname pfvio_getters

get_geracao_observada <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "geracao_observada", ...)
}

#' @rdname pfvio_getters

get_corte_observado <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "corte_observado", ...)
}

#' @rdname pfvio_getters

get_irradiancia_prevista <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "irradiancia_prevista", ...)
}

#' @rdname pfvio_getters

get_melhor_historico_geracao <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "melhor_historico_geracao", ...)
}

#' @rdname pfvio_getters

get_melhor_historico_geracao_sem_cortes <- function(conn, ...) {
    dbrenovaveis::getfromdb(conn, "melhor_historico_geracao_sem_cortes", ...)
}
