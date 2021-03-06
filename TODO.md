# TODO list

 - [x] INIT
 - [x] Simple BD process
 - [x] BD process with traits
 - [ ] Add instant traits mechanism (i.e. allow saving and calculating trait values after any waiting time (needs to create internal nodes))
 - [ ] Add lineage tracking mechanism (i.e. allow `traits`, `modifiers` or `events` to be applied to specific lineages)
 - [ ] Add sampling mechanism (i.e. instead of having fixed values, allow using distributions)
    - [x] `make.bd.params`
    - [x] `plot.make.bd.params`
    - [ ] implement it in `dads` and `birth.death`


## TODO traits

 - [x] make list of traits
 - [x] `make.traits`
 - [x] document list of traits (Rd)
 - [x] document list of traits (gitbook)
 - [x] test `make.traits`
 - [x] add and test `print.traits`
 - [x] add and test `update` argument
 - [ ] test list of traits
 - [x] add + test `multi.OU.process`
 - [ ] add + test `repulsion.BM.process`

## TODO modifiers

 - [x] make list of modifiers
 - [x] `make.modifiers`
 - [x] document list of modifiers (Rd)
 - [x] test `make.modifiers`
 - [x] add and test `print.modifiers`
 - [x] add and test `update` argument

## TODO events

 - [ ] make list of events
 - [x] `make.events`
 - [ ] document list of events (Rd)
 - [ ] document list of events (gitbook)
 - [x] test `make.events`
 - [x] add and test `print.events`
 - [ ] test list of separate: conditions and modifications
 - [ ] allow events per clade (see TreeSim)
 - [ ] add abiotic events (see RPANDA)

### Make the following events work:

 - [x] taxa event: mass extinction based on % at time t
 - [x] taxa event: mass extinction based on traits at time t
 - [x] bd.params events: adding extinction parameter after reaching n taxa
 - [x] bd.params events: reducing speciation after reaching time t
 - [x] traits events: changing trait process at time t
 - [x] traits events: changing traits correlation when reaching trait value x for trait 1
 - [x] modifiers events: adding a speciation condition after reaching time t
 - [x] modifiers events: adding a branch length condition when reaching n taxa
 - [x] founding events: generate a new birth-death process for the first node to reach trait value x

## TODO utilities
 
 - [x] add utilities
 - [ ] add manual for utilities
 - [ ] add test for `parent.traits`

## TODO dads

 - [x] remove upper boundary on `bd.params`

## TODO package

 - [ ] add examples in functions

## TODO plot

 - [x] add a 2/3D plot option for traits (points coloured as a function of time) + optional links
 - [x] add a 3D plot version of plot dads with X Y being traits and Z being time
 - [x] add a time gradient option for col.
 - [x] distinguish tips from nodes with a circle option around the tips (in 2D)
 - [x] change colour to default for edges
 - [ ] adding legend options


## TODO: Manual

 - [ ] Bug in 4.3 The speciation function (speciation)
