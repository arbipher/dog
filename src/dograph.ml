open Core
open Graph
open Scan_dot_ast

module Dot_vertex = struct
  type t = {
    node_id : Dot_ast.node_id;
    attrs : Graphviz.DotAttributes.vertex list;
    raw_attrs : Dot_ast.attr;
  }

  let equal v1 v2 = Poly.equal v1.node_id v2.node_id
  let compare v1 v2 = Poly.compare v1.node_id v2.node_id
  let hash v = Hashtbl.hash v.node_id
end

let string_of_node_id (v : Dot_vertex.t) =
  let id = v.node_id |> fst in
  match id with
  | Dot_ast.Ident s | Dot_ast.Number s | Dot_ast.String s | Dot_ast.Html s -> s

let partition_vertex_attrs attrs =
  List.partition_map (List.concat attrs) ~f:(fun one_attr ->
      let akey, aval = one_attr in
      let aid = scan_id akey in
      Fmt.pr "%s\n" aid ;
      let vtag = scan_vertex aid in
      match vtag with
      | `Shape ->
          let s = aval |> scan_id_exn |> scan_shape in
          Either.First (`Shape s)
      | `_Unmatched _ -> Either.Second one_attr
      | _ -> Either.Second one_attr)

let partition_edge_attrs attrs =
  List.partition_map (List.concat attrs) ~f:(fun one_attr ->
      let akey, aval = one_attr in
      let aid = scan_id akey in
      Fmt.pr "%s\n" aid ;
      let vtag = scan_vertex aid in
      match vtag with
      | `Arrowhead ->
          let s = aval |> scan_id_exn |> scan_arrow_style in
          Either.First (`Arrowhead s)
      | `_Unmatched _ -> Either.Second one_attr
      | _ -> Either.Second one_attr)

module Dot_edge = struct
  type t = {
    attrs : Graphviz.DotAttributes.edge list;
    raw_attrs : Dot_ast.attr;
  }

  let compare = Poly.compare
  let default = { attrs = []; raw_attrs = [] }
end

module G = struct
  module OG = Persistent.Digraph.ConcreteLabeled (Dot_vertex) (Dot_edge)
  include OG

  let foo = "hacking"
end
