# DOTA is an extension for DOT

DOTA = DOT + Action

DOT-Action: script of human actions

A programmable way to process DOT file.

TODO:
- https://github.com/CodeFreezr/awesome-graphviz
- https://intranet.icar.cnr.it/wp-content/uploads/2018/12/RT-ICAR-PA-2018-06.pdf
- https://stackoverflow.com/questions/31321009/best-more-standard-graph-representation-file-format-graphson-gexf-graphml

# Notes

## Cluster & Subgraph

A cluster is a subgraph whose name has a leading `cluster_`. A cluster is readered 
in separate rectangular layout regions.

## Exhance OCamlgraph

`id EQUAL id` is supported by dot but not supported in OCamlgraph.

See https://graphviz.org/doc/info/lang.html
My fork: https://github.com/arbipher/ocamlgraph



## Understang Graphviz

_entities_ inside the top `graph` or `digraph` include `node` `edge` `subgraph`. _Entities_ can have attributes. They have shared attribute keys and also entity-specific and rendering engine-specific keys.

Keywords `node` `edge` and `graph` affect attributes in current scope. In the same scope, duplicate attribute overwrite the previous one. See `dot/tricky.dot`.

`diagraph D` has _pink_ `bgcolor`, neither _red_ defined earlier nor _lightgray_ defined inner.

Aside: lexical scope

static: bind-by-close-definition-symbol
runtime: bind-by-close-definition-value

dynamic scope

### Where re-binding occurs



## Difference between `subgraph` and `cluster`

## Question:

De-conflicts by evaluating (the JS-interpter-as-spec) approach

## Patch OCamlgraph

back-compatibility version 