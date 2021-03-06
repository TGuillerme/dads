% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make.traits.R
\name{make.traits}
\alias{make.traits}
\title{make.traits}
\usage{
make.traits(
  process = BM.process,
  n = NULL,
  start = NULL,
  process.args = NULL,
  trait.names = NULL,
  add = NULL,
  update = NULL,
  test = TRUE
)
}
\arguments{
\item{process}{The trait process(es) (default is \code{\link{BM.process}}).}

\item{n}{Optional, the number of traits per process (default is \code{1}).}

\item{start}{Optional, the starting values for each traits (default is {0}).}

\item{process.args}{Optional, a named list of optional arguments for the trait process.}

\item{trait.names}{Optional, the name(s) of the process(s).}

\item{add}{Optional, another previous \code{"dads"} traits object to which to add the trait.}

\item{update}{Optional, another previous \code{"dads"} traits object to update (see details).}

\item{test}{Logical, whether to test if the traits object will work with \code{\link{dads}} (\code{TRUE} - default).}
}
\description{
Making traits objects for dads
}
\details{
When using \code{update}, the provided arguments (to \code{make.traits}) will be the ones updated in the \code{"traits"} object.
If the \code{"traits"} object contains multiple processes, you can specify which ones should be affected with the \code{trait.names} argument.
Note that you cannot update the \code{traits.names} or the number of traits per processes (\code{n}) not use the \code{add} argument when updating a \code{"traits"} object.

More details about the \code{"dads"} \code{"traits"} objects is explained in the \code{dads} manual: \url{http://tguillerme.github.io/dads}.
}
\examples{
## A simple Brownian motion trait (default)
make.traits()

## Two independent Brownian motion traits
make.traits(n = 2)

## Two different traits with different process
## (Brownian motion and Ornstein-Uhlenbeck)
make.traits(process = list(BM.process, OU.process))

## A multidimensional Brownian motion trait with correlation
## and different starting points
my_correlations <- matrix(1/3, ncol = 3, nrow = 3)
(my_traits <- make.traits(n = 3, start = c(0, 1, 3),
                          process.args = list(Sigma = my_correlations)))

## Adding a Ornstein-Uhlenbeck trait to the previous trait object
make.traits(process = OU.process, trait.names = "OU_trait",
            add = my_traits)

}
\seealso{

}
\author{
Thomas Guillerme
}
