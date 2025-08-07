
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pfvIO

<!-- badges: start -->

[![R-CMD-check](https://github.com/lkhenayfis/pfvIO/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/lkhenayfis/pfvIO/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/lkhenayfis/pfvIO/graph/badge.svg)](https://app.codecov.io/gh/lkhenayfis/pfvIO)
<!-- badges: end -->

The goal of pfvIO is to …

## Instalacao

Este pacote nao se encontra disponibilizado no CRAN, de modo que deve
ser instalado diretamente a partir do repositorio utilizando:

``` r
# Caso a biblioteca remotes nao esteja instalada, execute install.packages("remotes") primeiro
remotes::install_github("lkhenayfis/pfvIO") # instalacao da versao de desenvolvimento
remotes::install_github("lkhenayfis/pfvIO@*release") # instalacao da ultima versao fechada
```

## Exemplo de uso

O pacote `pfvIO` funciona a base de duas funcoes, essencialmente:
`conectamock_pfv` e `get_dataset`. `conectamock_pfv` e necessaria para
estabelecer uma conexao com o banco, esteja ele local ou num bucket s3

``` r
# exemplo com os dados internos do pacote
conn <- conectamock_pfv(system.file("extdata", package = "pfvIO"))
print(conn)
#> * Banco 'mock' com tabelas: 
#> 
#> Tabela: corte_observado
#> - Conteudo:  
#> - Campos: id_fonte_observacao <string>, id_usina <string>, data_hora_observacao <datetime>, valor <float>, status <int> 
#> 
#> Tabela: geracao_observada
#> - Conteudo:  
#> - Campos: id_fonte_observacao <string>, id_usina <string>, data_hora_observacao <datetime>, valor <float>, status <int> 
#> 
#> Tabela: irradiancia_prevista
#> - Conteudo:  
#> - Campos: id_modelo_nwp <string>, latitude <float>, longitude <float>, data_hora_rodada <datetime>, data_hora_previsao <datetime>, valor <float> 
#> 
#> Tabela: melhor_historico_geracao_sem_cortes
#> - Conteudo:  
#> - Campos: id_fonte_observacao <string>, id_usina <string>, data_hora_observacao <datetime>, valor <float>, status <int> 
#> 
#> Tabela: melhor_historico_geracao
#> - Conteudo:  
#> - Campos: id_fonte_observacao <string>, id_usina <string>, data_hora_observacao <datetime>, valor <float>, status <int> 
#> 
#> Tabela: potencia_disponivel_observada
#> - Conteudo:  
#> - Campos: id_fonte_observacao <string>, id_usina <string>, data_hora_observacao <datetime>, valor <float>, status <int> 
#> 
#> Tabela: usinas
#> - Conteudo:  
#> - Campos: id_usina <string>, latitude <float>, longitude <float>, capacidade_instalada_MW <float>, data_inicio_operacao_comercial <datetime>
```

Uma vez estabelecida a conexao com um banco, `get_dataset` pode ser
utilizada para ler um conjunto completo de dados

``` r
dataset <- get_dataset(conn, id_usina = "BAUFI1", data_hora_observacao = "2025-07-01",
    data_hora_previsao = "2025-07-01")
lapply(dataset, head)
#> $usinas
#>    id_usina latitude longitude capacidade_instalada_MW
#>      <char>    <num>     <num>                   <num>
#> 1:   BAUFI1 -12.5873  -44.1069                      28
#>    data_inicio_operacao_comercial
#>                            <POSc>
#> 1:            2017-08-05 03:00:00
#> 
#> $potencia_disponivel_observada
#>    id_fonte_observacao id_usina data_hora_observacao valor status
#>                 <char>   <char>               <POSc> <int>  <int>
#> 1:                  PI   BAUFI1  2025-07-01 00:00:00    30     NA
#> 2:                  PI   BAUFI1  2025-07-01 00:30:00    30     NA
#> 3:                  PI   BAUFI1  2025-07-01 01:00:00    30     NA
#> 4:                  PI   BAUFI1  2025-07-01 01:30:00    30     NA
#> 5:                  PI   BAUFI1  2025-07-01 02:00:00    30     NA
#> 6:                  PI   BAUFI1  2025-07-01 02:30:00    30     NA
#> 
#> $geracao_observada
#>    id_fonte_observacao id_usina data_hora_observacao valor status
#>                 <char>   <char>               <POSc> <num>  <int>
#> 1:                CCEE   BAUFI1  2025-07-01 00:00:00   999     NA
#> 2:                CCEE   BAUFI1  2025-07-01 00:30:00   999     NA
#> 3:                CCEE   BAUFI1  2025-07-01 01:00:00   999     NA
#> 4:                CCEE   BAUFI1  2025-07-01 01:30:00   999     NA
#> 5:                CCEE   BAUFI1  2025-07-01 02:00:00   999     NA
#> 6:                CCEE   BAUFI1  2025-07-01 02:30:00   999     NA
#> 
#> $corte_observado
#>    id_fonte_observacao id_usina data_hora_observacao valor status
#>                 <char>   <char>               <POSc> <int>  <int>
#> 1:                  PI   BAUFI1  2025-07-01 00:00:00     0     NA
#> 2:                  PI   BAUFI1  2025-07-01 00:30:00     0     NA
#> 3:                  PI   BAUFI1  2025-07-01 01:00:00     0     NA
#> 4:                  PI   BAUFI1  2025-07-01 01:30:00     0     NA
#> 5:                  PI   BAUFI1  2025-07-01 02:00:00     0     NA
#> 6:                  PI   BAUFI1  2025-07-01 02:30:00     0     NA
#> 
#> $irradiancia_prevista
#>    id_modelo_nwp latitude longitude data_hora_rodada  data_hora_previsao  valor
#>           <char>    <num>     <num>           <POSc>              <POSc>  <num>
#> 1:           GFS   -12.75    -44.75       2025-06-15 2025-07-01 00:00:00 706.91
#> 2:           GFS   -12.75    -44.75       2025-06-16 2025-07-01 00:00:00  34.87
#> 3:           GFS   -12.75    -44.75       2025-06-16 2025-07-01 03:00:00  69.75
#> 4:           GFS   -12.75    -44.75       2025-06-16 2025-07-01 06:00:00 104.62
#> 5:           GFS   -12.75    -44.75       2025-06-16 2025-07-01 09:00:00 307.17
#> 6:           GFS   -12.75    -44.75       2025-06-16 2025-07-01 12:00:00 509.71
#> 
#> $melhor_historico_geracao
#>    id_fonte_observacao id_usina data_hora_observacao valor status
#>                 <char>   <char>               <POSc> <num>  <int>
#> 1:              Consis   BAUFI1  2025-07-01 00:00:00     0      1
#> 2:              Consis   BAUFI1  2025-07-01 00:30:00     0      1
#> 3:              Consis   BAUFI1  2025-07-01 01:00:00     0      1
#> 4:              Consis   BAUFI1  2025-07-01 01:30:00     0      1
#> 5:              Consis   BAUFI1  2025-07-01 02:00:00     0      1
#> 6:              Consis   BAUFI1  2025-07-01 02:30:00     0      1
#> 
#> $melhor_historico_geracao_sem_cortes
#>    id_fonte_observacao id_usina data_hora_observacao valor status
#>                 <char>   <char>               <POSc> <num>  <int>
#> 1:              Consis   BAUFI1  2025-07-01 00:00:00     0      1
#> 2:              Consis   BAUFI1  2025-07-01 00:30:00     0      1
#> 3:              Consis   BAUFI1  2025-07-01 01:00:00     0      1
#> 4:              Consis   BAUFI1  2025-07-01 01:30:00     0      1
#> 5:              Consis   BAUFI1  2025-07-01 02:00:00     0      1
#> 6:              Consis   BAUFI1  2025-07-01 02:30:00     0      1
```

Os argumentos nomeados de `get_dataset` correspondem aos subsets sendo
aplicados. Para mais detalhes a respeito, use `help("pfvio_getters")`
