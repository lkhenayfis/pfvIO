# pfvIO 0.3.1

## Misc

* Passa a exportar funcoes `get_model_artifact`, `write_model_artifact` e `write_dataset`
* Inclui paginas de documentacao faltantes destas funcoes

# pfvIO 0.3

## New features

* Add funcao `get_model_artifact` para leitura de artefatos salvos previamente
* Add funcoes de escrita `write_model_artifact` e `write_dataset` para salvar tanto artefatos quanto
  dados gerados
* Add suporte a leitura de irradiancia_observada

# pfvIO 0.2.2

## Misc

* Eleva versao minima de `dbinterface` para 0.8.2, que resolve bug na leitura de parquets gerados
  por fora do R

# pfvIO 0.2.1

## Misc

* Muda dependencia `dbrenovaveis`, pacote nao mais em desenvolvimento, para seu sucessor
  `dbinterface`
* Depreca funcao `get_dataset()`; cada aplicacao vai ler dados diferentes de formas diferentes, de
  modo que deverao criar suas proprias `get_dataset()`s

# pfvIO 0.2

## New features

* Adiciona suporte a arquivos `json[c]` nos bancos mock e incui uma `get_config()` para acessa-lo

# pfvIO 0.1

Funcionalidades De Input/Output Para O Modelo De Previsão De Geracao Solar Fotovoltaica
