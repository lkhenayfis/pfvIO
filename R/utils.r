
valid_tabelas <- function(tabelas) {
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

