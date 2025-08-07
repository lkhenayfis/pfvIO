#' Getter De Dataset Completo
#' 
#' Acessa todas as tabelas em uma conexao aplicando subsets igualmente
#' 
#' @param conn um objeto de conexao com banco como gerado por [`conectamock_pfv`]
#' @param ... definicoes de subset. Veja [`pfvio_getters`]
#' 
#' @return lista de `data.table`s contendo todas as tabelas do banco nos subsets definidos por `...`
#' 
#' @export

get_dataset <- function(conn, ...) {
    list(
        usinas = get_usinas(conn, ...),
        potencia_disponivel_observada = get_potencia_disponivel_observada(conn, ...),
        geracao_observada = get_geracao_observada(conn, ...),
        corte_observado = get_corte_observado(conn, ...),
        irradiancia_prevista = get_irradiancia_prevista(conn, ...),
        melhor_historico_geracao = get_melhor_historico_geracao(conn, ...),
        melhor_historico_geracao_sem_cortes = get_melhor_historico_geracao_sem_cortes(conn, ...)
    )
}

#' Getters De Dados Individuais
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
#' @param conn um objeto de conexao com banco como gerado por [`conectamock_pfv`]
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
#' dt <- get_geracao_observada(conn, id_usina = "BAUFI1", id_fonte_observacao = "PI")
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
#' dt <- get_geracao_observada(conn, id_usina = "BAUFI1",
#'     data_hora_observacao = "2025-06-20 10:00:00/2025-06-25 19:30:00")
#' 
#' @name pfvio_getters
NULL

#' @rdname pfvio_getters
#' 
#' @export

get_usinas <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados das usinas...")

    dt <- dbrenovaveis::getfromdb(conn, "usinas", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("usinas"),
        guess_col_types("usinas"),
        guess_col_limits("usinas")
    )

    lg$debug("Dados das usinas lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_potencia_disponivel_observada <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de potencia disponivel observada...")

    dt <- dbrenovaveis::getfromdb(conn, "potencia_disponivel_observada", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("potencia_disponivel_observada"),
        guess_col_types("potencia_disponivel_observada"),
        guess_col_limits("potencia_disponivel_observada")
    )

    lg$debug("Dados de potencia disponivel observada lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_geracao_observada <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de geracao observada...")

    dt <- dbrenovaveis::getfromdb(conn, "geracao_observada", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("geracao_observada"),
        guess_col_types("geracao_observada"),
        guess_col_limits("geracao_observada")
    )

    lg$debug("Dados de geracao observada lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_corte_observado <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de corte observado...")

    dt <- dbrenovaveis::getfromdb(conn, "corte_observado", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("corte_observado"),
        guess_col_types("corte_observado"),
        guess_col_limits("corte_observado")
    )

    lg$debug("Dados de corte observado lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_irradiancia_prevista <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de irradiancia prevista...")

    dt <- dbrenovaveis::getfromdb(conn, "irradiancia_prevista", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("irradiancia_prevista"),
        guess_col_types("irradiancia_prevista"),
        guess_col_limits("irradiancia_prevista")
    )

    lg$debug("Dados de irradiancia prevista lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_melhor_historico_geracao <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de melhor historico de geracao...")

    dt <- dbrenovaveis::getfromdb(conn, "melhor_historico_geracao", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("melhor_historico_geracao"),
        guess_col_types("melhor_historico_geracao"),
        guess_col_limits("melhor_historico_geracao")
    )

    lg$debug("Dados de melhor historico de geracao lidos com sucesso")

    return(dt)
}

#' @rdname pfvio_getters
#' 
#' @export

get_melhor_historico_geracao_sem_cortes <- function(conn, ...) {
    lg <- get_pkg_logger()
    lg$debug("Lendo dados de melhor de historico geracao sem cortes...")

    dt <- dbrenovaveis::getfromdb(conn, "melhor_historico_geracao_sem_cortes", ...)
    valida_dado_singular_completo(dt,
        guess_col_names("melhor_historico_geracao_sem_cortes"),
        guess_col_types("melhor_historico_geracao_sem_cortes"),
        guess_col_limits("melhor_historico_geracao_sem_cortes")
    )

    lg$debug("Dados de melhor historico de geracao sem cortes lidos com sucesso")

    return(dt)
}
