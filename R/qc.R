library(GenomicRanges)
library(Rsamtools)

#' Plot distribution of mismatches and indels in reads. 
#' 
#' @param bamfile string bamfile filepath
#' @param plotfile string output png filepath 
PlotMMDist <- function(bamfile, plotfile) {
  param <- ScanBamParam(tag="NM")
  aln <- readGAlignments(bamfile, param=param)
  mm.counts <- table(mcols(aln)$NM)
  png(filename=plotfile, width=1024, height=512)
  barplot(mm.counts,
          main="Mismatch distribution in the alignments",
          xlab="Number of mismatches and indels within a read alignment",
          ylab="Number of reads",
          cex.lab=2, cex.main=2)
  dev.off()
}

#' Plot fraction of mismatches and indels.
#'
#' It is calculated by dividing read length
#' by edit distance (NM tag in bam file).
#' @param bamfile string bamfile filepath
#' @param plotfile string output png filepath 
PlotMMFracDist <- function(bamfile, plotfile) {
  param <- ScanBamParam(tag="NM")
  aln <- readGAlignments(bamfile, param=param)
  mcols(aln)$mmfrac <- round(mcols(aln)$NM / width(aln), 2)
  breaks <- max(mcols(aln)$mmfrac) * 100
  png(filename=plotfile, width=1024, height=512)
  hist(mcols(aln)$mmfrac,
       breaks=breaks,
       main="Mismatch distribution in the alignments",
       xlab="Number of mismatches and indels within a read alignment",
       ylab="Number of reads",
       cex.lab=2, cex.main=2)
  dev.off()
}