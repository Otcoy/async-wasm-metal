# Design

no clk - run as fast as possible

## Design 1

modules:

memory - handle load / store

core - run every non load / store instructions and wait the memory module

a core might manage multiple stacks - hyper-threading

## Design 2

modules:

+ thread

executor:

+ memory
+ core
+ io

a thread is connected to one or zero executor
