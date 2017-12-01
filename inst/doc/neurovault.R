## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(neurovault)
res = nv_collection_images(id = 77)
df = results_to_df(res$content$results)
head(df)

## ------------------------------------------------------------------------
library(neurobase)
res = download_nv_atlas(id = 1408)
atlas = readnii(res$outfile[1])
ortho2(atlas)

## ------------------------------------------------------------------------
nidm = nv_nidm_results()

