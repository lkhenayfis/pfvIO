#' Construtor Externo De Conexao Com Banco
#' 
#' Gera uma conexao com banco no padrao `dbinterface` para uso das funcionalidades de leitura
#' 
#' Usualmente o `dbinterface` espera encontrar um arquivo `"schema.json"` a partir do qual montar o
#' banco de dados. No caso do modelo PFV, e necessario fazer interface com os dados sem este
#' arquivo, se baseando em schemas internamente definidos pelo pacote.
#' 
#' `conectamock_pfv` consiste em uma "volta" no processo natural de construcao do `mock` a partir de
#' um `"schema.json"`, realizando diversas de suas tarefas a partir dos schemas internos para gerar
#' entao uma conexao com o banco
#' 
#' @param uri caminho dos dados, local ou bucket no s3; neste segundo caso informar bucket e prefixo
#'     como um caminho completo, em string
#' 
#' @examples 
#' 
#' uri <- system.file("extdata/", package = "pfvIO")
#' conn <- conectamock_pfv(uri)
#' 
#' \dontrun{
#' # caso de um banco em bucket s3
#' uri <- "s3://nome_do_bucket/prefixo/do/banco"
#' conn <- conectamock_pfv(uri)
#' }
#' 
#' @return objeto `mock`; Veja [`dbinterface::conectamock`]
#' 
#' @export

conectamock_pfv <- function(uri) {
    uri <- classifica_uri(uri)

    arquivos  <- lista_arquivos(uri)
    extensoes <- id_tipo_arquivo(arquivos)

    which_config <- grepl("json(c)?", extensoes)
    config  <- arquivos[which_config]
    tabelas <- valida_filtra_tabelas(arquivos[!which_config])

    schemas <- get_schemas(tabelas)
    schemas <- mapply(
        function(s, f, uri) fix_uri_filetype(s, uri, f),
        schemas,
        extensoes[!which_config],
        MoreArgs = list(uri = uri),
        SIMPLIFY = FALSE
    )

    # valida cada tabela contra o schema
    #     para validar vai precisar pegar um head de cada tabela, sem usar o getfromdb ainda

    schemas <- lapply(schemas, coltype2dbinterface)
    tabelas <- lapply(schemas, dbinterface:::schema2tabela)

    fake_mock(tabelas, uri, config)
}

#' Construtor Interno De Conexao Com Banco
#' 
#' Gera um objeto `mock` "por fora" do `dbinterface`
#' 
#' @param tabelas lista de tabelas preprocessadas
#' @param uri caminho local ou no s3 do banco. Veja [`conectamock_pfv`]
#' @param config caminho local ou no s3 do arquivo de configuracao no banco
#' 
#' @return objeto `mock` de conexao com o banco

fake_mock <- function(tabelas, uri, config) {
    out <- structure(list(tabelas = tabelas), class = "mock")
    attr(out, "uri") <- uri
    attr(out, "config") <- config

    return(out)
}
