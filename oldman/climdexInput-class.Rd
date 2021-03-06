\name{climdexInput}
\alias{climdexInput-class}
\docType{class}
\title{climdexInput}
\description{
  The climdexInput class contains all the data necessary to compute the
  climdex indices.
}
\section{Slots}{
  \describe{
    \item{tmax}{Time series of daily maximum temperature.}
    \item{tmin}{Time series of daily minimum temperature.}
    \item{tavg}{Time series of daily mean temperature.}
    \item{prec}{Time series of daily total precipitation.}
    \item{namask.ann}{Data quality mask for annual data.}
    \item{namask.mon}{Data quality mask for monthly data.}
    \item{running.pctile.base}{Temperature percentiles used inside base period.}
    \item{running.pctile.notbase}{Temperature percentiles used outside
      base period.}
    \item{pctile}{Precipitation percentiles.}
    \item{dates}{Date sequence (type PCICt) corresponding to temperature and
      precipitation data.}
    \item{base.range}{Date range (type PCICt) of baseline period.}
    \item{annual.factor}{Factor used for creation of annual indices.}
    \item{monthly.factor}{Factor used for creation of monthly indices.}
    \item{northern.hemisphere}{Boolean used when computing growing
      season length.}
  }
}
\details{
  The \code{climdexInput} class consists of all the data necessary to compute
  the climdex indices. Users will not need to modify any of the slots in
  this class. That being said, users may want or need to repurpose this data for
  further analysis. The following description of the data is aimed at that
  audience.

  The \code{tmax}, \code{tmin}, \code{tavg}, and \code{prec} slots are
  time series of daily data of equal length and without any missing
  days, with NAs in place of data where no data was present. The
  \code{dates} slot is the corresponding series of dates (of type PCICt)
  for the daily data.

  To ease computation of monthly and annual data, \code{monthly.factor}
  and \code{annual.factor} are slots in the data structure. They are
  also of the same length as the time series. These can be reused for
  computation of any annual or monthly aggregates.

  The climdexInput class also includes NA masks for both monthly
  (\code{namask.mon}) and annual (\code{namask.ann}) data. These masks
  consist of a vector of numbers of the same length as the monthly or
  annual output data. The values used are 1 to signify that the data
  meets the QC criteria, and NA to signify it does not. Years with
  more than 15 days missing, and months with more than 3 days missing,
  are considered to be of poor quality and are masked here with NA.
  
  The \code{base.range} slot contains vector of type PCICt containing
  the first and last day included in the baseline.

  The \code{northern.hemisphere} slot contains a boolean indicating
  whether the data came from the northern hemisphere. If FALSE, data is
  assumed to have come from the southern hemisphere. This is used when
  computing growing season length; if the data is from the southern
  hemisphere, growing season length is the growing season starting in
  the beginning of July of the year indicated, running to the end of
  June of the following year.

  The \code{pctile} slot contains the 95th and 99th percentile values
  for the precipitation percentiles, computed on the base period.

  The \code{running.pctile.notbase} slot contains the data necessary for
  computing temperature based percentiles outside of the base
  period. This consists of one percentile for each day of the year, computed
  using an n-day (default is 5-day) running window surrounding that
  day. These percentiles are computed for both the 10th and 90th
  percentile for daily maximum and minimum temperature.

  The \code{running.pctile.base} slot contains the data necessary for
  computing temperature based percentiles inside the base period. As
  this is a somewhat unpleasant operation, so are the data
  requirements. Given n years of data to use as the base period, there
  are n * (n - 1) sets of daily quantiles of the same type as those for
  \code{running.pctile.notbase}.
}
\examples{
## Parse the dates into PCICt.
tmax.dates <- as.PCICt(do.call(paste, ec.1018935.tmax[,c("year",
"jday")]), format="\%Y \%j", cal="gregorian")
tmin.dates <- as.PCICt(do.call(paste, ec.1018935.tmin[,c("year",
"jday")]), format="\%Y \%j", cal="gregorian")
prec.dates <- as.PCICt(do.call(paste, ec.1018935.prec[,c("year",
"jday")]), format="\%Y \%j", cal="gregorian")

## Load the data in.
ci <- climdexInput.raw(ec.1018935.tmax$MAX_TEMP,
ec.1018935.tmin$MIN_TEMP, ec.1018935.prec$ONE_DAY_PRECIPITATION,
tmax.dates, tmin.dates, prec.dates, base.range=c(1971, 2000))


}
\seealso{
\code{\link{climdexInput.csv}}, \code{\link{climdexInput.raw}}.
}
\keyword{climate}
\keyword{ts}
