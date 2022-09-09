open Core
open Graph
(* module Dot_ast = Dot_ast_copy *)

module Dot_vertex = struct
  type t = { id : Dot_ast.node_id; attrs : Dot_ast.attr list }

  let equal v1 v2 = Poly.equal v1.id v2.id
  let compare v1 v2 = Poly.compare v1.id v2.id
  let hash v = Hashtbl.hash v.id
end

let string_of_node_id (v : Dot_vertex.t) =
  let id = v.id |> fst in
  match id with
  | Dot_ast.Ident s | Dot_ast.Number s | Dot_ast.String s | Dot_ast.Html s -> s

module Dot_edge = struct
  type t = string

  let compare = String.compare
  let default = ""
end

module G = Persistent.Digraph.ConcreteLabeled (Dot_vertex) (Dot_edge)
