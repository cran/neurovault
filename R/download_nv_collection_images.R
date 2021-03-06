#' Download Neurovault Collections Images
#'
#' @param id id of the collection
#' @param verbose print diagnostic messages
#' @param outdir output directory for images
#' @param overwrite Will only overwrite existing file if \code{TRUE}.
#' @param ... additional options to pass to \code{\link{GET}}
#'
#' @return A \code{data.frame} of the image information
#' and their output filenames
#' @export
#'
#' @importFrom httr GET write_disk progress status_code
#' @examples
#' res = download_nv_collection_images(id = 77)
#'
download_nv_collection_images = function(
  id,
  verbose = TRUE,
  outdir = tempfile(),
  overwrite = TRUE,
  ...) {

  res = nv_collection_images(id = id, verbose = verbose, ...)
  df = results_to_df(res$content$results)
  if (!dir.exists(outdir)) {
    dir.create(outdir, recursive = TRUE)
  }
  df$outfile = file.path(outdir, basename(df$file))
  dl_results = mapply(function(url, outfile) {
    image_res = GET(
      url,
      httr::write_disk(path = outfile, overwrite = overwrite),
      if (verbose) httr::progress())
    return(image_res)
  }, df$file, df$outfile, SIMPLIFY = FALSE)
  dl_results = lapply(dl_results, httr::warn_for_status)
  status_codes = sapply(dl_results, httr::status_code)
  df$dl_status_code = status_codes


  return(df)
}
