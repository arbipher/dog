open Core
open Graph
(* module Dot_ast = Dot_ast_copy *)

module Dot_vertex = struct
  type t = {
    node_id : Dot_ast.node_id;
    attrs : Graphviz.DotAttributes.vertex list;
  }

  let equal v1 v2 = Poly.equal v1.node_id v2.node_id
  let compare v1 v2 = Poly.compare v1.node_id v2.node_id
  let hash v = Hashtbl.hash v.node_id
end

let string_of_node_id (v : Dot_vertex.t) =
  let id = v.node_id |> fst in
  match id with
  | Dot_ast.Ident s | Dot_ast.Number s | Dot_ast.String s | Dot_ast.Html s -> s

let string_of_id (x : Dot_ast.id) =
  match x with Dot_ast.Ident s -> s | _ -> failwith "must be id"

let node_attr_of_attr (attr : Dot_ast.attr) : Graphviz.DotAttributes.vertex =
  match List.hd attr with
  | Some one_attr -> (
      let akey, aval = one_attr in
      let aid = string_of_id akey in
      match (aid, aval) with
      | "shape", Some (String "diamond") -> `Shape `Diamond
      | _, _ -> `Shape `House)
  | None -> `Shape `Box

module Dot_edge = struct
  type t = string

  let compare = String.compare
  let default = ""
end

module G = Persistent.Digraph.ConcreteLabeled (Dot_vertex) (Dot_edge)
