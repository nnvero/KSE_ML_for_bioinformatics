# One-time export of the real Bioconductor bladderbatch dataset to CSV
# Run this once in R. The resulting CSV files are then used by the Python/Quarto practical.

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

if (!requireNamespace("bladderbatch", quietly = TRUE)) {
  BiocManager::install("bladderbatch")
}

if (!requireNamespace("Biobase", quietly = TRUE)) {
  BiocManager::install("Biobase")
}

library(bladderbatch)
library(Biobase)

data(bladderdata)

# ExpressionSet:
#   rows    = Affymetrix probe sets
#   columns = biological samples
edata <- exprs(bladderEset)
pdata <- pData(bladderEset)

# Preserve the original assay orientation in the export:
#   rows    = Affymetrix probe sets
#   columns = biological samples
# This is a raw-orientation export, not raw/unprocessed microarray intensity.
expression_raw <- as.data.frame(edata, check.names = FALSE)
expression_raw$probe_set_id <- rownames(expression_raw)
expression_raw <- expression_raw[, c("probe_set_id", setdiff(names(expression_raw), "probe_set_id"))]

metadata_py <- as.data.frame(pdata)
metadata_py$sample_id <- rownames(metadata_py)
metadata_py <- metadata_py[, c("sample_id", setdiff(names(metadata_py), "sample_id"))]

write.csv(expression_raw, "bladder_expression_raw.csv", row.names = FALSE)
write.csv(metadata_py, "bladder_metadata.csv", row.names = FALSE)

cat("Exported:\n")
cat("  bladder_expression_raw.csv:", nrow(expression_raw), "probe sets x",
    ncol(expression_raw)-1, "samples\n")
cat("  bladder_metadata.csv:", nrow(metadata_py), "samples x",
    ncol(metadata_py)-1, "metadata columns\n")
