#' @name modifiers
#' @aliases branch.length selection speciation branch.length.trait speciation.trait
#' @title Modifiers
#'
#' @description Different modifiers for the birth death process implemented in dads.
#'
#' @usage branch.length(bd.params = NULL, lineage = NULL, trait.values = NULL, modify.fun = NULL)
#' @usage selection(bd.params = NULL, lineage = NULL, trait.values = NULL, modify.fun = NULL)
#' @usage speciation(bd.params = NULL, lineage = NULL, trait.values = NULL, modify.fun = NULL)
#'
#' @param bd.params      A named list of birth death parameters (see details).
#' @param lineage        A named list containing the lineage data (see details).
#' @param trait.values   A matrix containing the trait values (see details).
#' @param modify.fun     A list of internals functions that can modified by \code{events} (see details).
#' 
#' @details
#' \code{bd.params} can be either a named list of parameter values (e.g. \code{list("extinction" = 0, "speciation" = 1)}) but it is typically handled internally from a \code{"dads"} \code{"bd.params"} object.
#' 
#' \code{modifiers} are functions passed to the birth death process in \code{\link{dads}} to either generate the branch length (named \code{branch.length} and similar) or to decide whether to speciate or go extinct (named \code{speciation} and similar).
#'
#' For user defined functions, the \code{modifiers} \emph{must} have at least the arguments described above. For safety, we suggest setting these arguments to \code{NULL}.
#'
#' The pre-build \code{modifiers} in the \code{dads} package are (so far):
#'
#' \itemize{
#'
#'      \item \code{branch.length} the simple branch length generator that randomly gets a numeric value drawn from the exponential distribution (\code{\link[stats]{rexp}}) with a rate equal to the number of taxa (\code{lineage$n * bd.params$speciation + bd.params$extinction}).
#'
#'      \item \code{branch.length.trait} a modification of the \code{branch.length} \code{modifier} where the resulting branch length is changed by \code{modify.fun$modify} if the parent trait(s) meet the condition \code{modify.fun$condition}.
#'
#'      \item \code{selection} a function returning a randomly sampled integer among the number of taxa available.
#' 
#'      \item \code{speciation} a function returning \code{TRUE} (speciation) if a random uniform number (\code{\link[stats]{runif}}) is smaller than the ratio of speciation by speciation and extinction (\code{bd.params$speciation / (bd.params$speciation) + bd.params$extinction}). If it's bigger, the function returns \code{FALSE} (exinction).
#'
#'      \item \code{speciation.trait} a modification of the \code{speciation} \code{modifier} where the random uniform number is changed by \code{modify.fun$modify} if the parent trait(s) meet the condition \code{modify.fun$condition}.
#'
#'  }
#' 
#' More details about the \code{modifiers} functions is explained in the \code{dads} manual: \url{http://tguillerme.github.io/dads}.

modifiers <- function(bd.params = NULL, lineage = NULL, trait.values = NULL, modify.fun = NULL) {
    cat("modifiers functions implemented in dads:\n")
    cat("branch length generating functions:\n")
    cat("   ?branch.length\n")
    cat("   ?branch.length.trait\n")
    cat("lineage selection functions:\n")
    cat("   ?selection\n")
    cat("speciation trigger functions:\n")
    cat("   ?speciation\n")
    cat("   ?speciation.trait\n")
}

## Normal branch length
branch.length <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {

    ## Get the event probability
    event_probability <- sum(lineage$n * (bd.params$speciation + bd.params$extinction))

    ## Get the waiting time
    waiting_time <- rexp(1, event_probability)

    ## Modify the waiting time
    if(modify.fun$condition(lineage = lineage, trait.values = trait.values)) {
        waiting_time <- modify.fun$modify(x = waiting_time, lineage = lineage, trait.values = trait.values)
    }

    return(waiting_time)
}

## Normal speciation
speciation <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {
    ## Randomly trigger an event
    trigger_event <- runif(1)

    ## Modify the triggering
    if(modify.fun$condition(lineage = lineage, trait.values = trait.values)) {
        trigger_event <- modify.fun$modify(x = trigger_event, lineage = lineage, trait.values = trait.values)
    }

    ## Speciate?
    return(trigger_event < (bd.params$speciation/(bd.params$speciation + bd.params$extinction)))
}

## Normal selection
selection <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {
    return(sample(lineage$n, 1))
}


## Normal branch length (internal usage only)
branch.length.fast <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {

    ## Get the waiting time
    return(rexp(1, sum(lineage$n * (bd.params$speciation + bd.params$extinction))))
}

## Normal speciation  (internal usage only)
speciation.fast <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {
    ## Speciate?
    return(runif(1) < (bd.params$speciation/(bd.params$speciation + bd.params$extinction)))
}

## Normal selector (internal usage only)
selection.fast <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun = NULL) {
    ## Speciate?
    return(sample(lineage$n, 1))
}



## Trait dependent branch length
branch.length.trait <- function(bd.params, lineage = NULL, trait.values = NULL, modify.fun) {

    ## Get the event probability
    event_probability <- sum(lineage$n * (bd.params$speciation + bd.params$extinction))

    ## Get the waiting time
    waiting_time <- rexp(1, event_probability)

    ## Modify the waiting time
    if(modify.fun$condition(lineage = lineage, trait.values = trait.values)) {
        waiting_time <- modify.fun$modify(x = waiting_time, lineage = lineage, trait.values = trait.values)
    }

    return(waiting_time)
}

## Trait dependent speciation
speciation.trait <- function(bd.params, lineage, trait.values, modify.fun){

    ## Randomly trigger an event
    trigger_event <- runif(1)

    ## Modify the triggering
    if(modify.fun$condition(lineage, trait.values)) {
        trigger_event <- modify.fun$modify(x = trigger_event, lineage = lineage, trait.values = trait.values)
    }

    ## Speciate?
    return(trigger_event < (bd.params$speciation/(bd.params$speciation + bd.params$extinction)))
}
