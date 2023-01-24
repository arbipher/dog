open Core
open Graph
module G = Dograph.G
module B = Builder.P (G)

module DotInput =
  Dot.Parse
    (B)
    (struct
      let node node_id node_attrs : Dograph.Dot_vertex.t =
        let attrs, raw_attrs = Dograph.partition_vertex_attrs node_attrs in

        { node_id; attrs; raw_attrs }

      let edge node_attrs : Dograph.Dot_edge.t =
        let attrs, raw_attrs = Dograph.partition_edge_attrs node_attrs in

        { attrs; raw_attrs }
    end)

module Display = struct
  let graph_attr : (int, string) Caml.Hashtbl.t = Caml.Hashtbl.create 97

  include G

  let vertex_name vid =
    V.label vid |> Dograph.string_of_node_id |> String.escaped

  let vertex_attributes vid =
    let v = V.label vid in
    v.attrs

  let edge_attributes e =
    let _v1, (el : E.label), _v2 = e in
    el.attrs

  let graph_attributes _ = [ `Label foo ]
  let default_vertex_attributes _ = []
  let default_edge_attributes _ = []
  let get_subgraph (_x : vertex) : Graphviz.DotAttributes.subgraph option = None
end

module DotOutput = Graphviz.Dot (Display)

let rec print_stmt : Dot_ast.stmt -> unit = function
  | Attr_graph ag ->
      let aid = Scan_dot_ast.id_of_attrs ag in
      Fmt.pr "\n[Attr_graph]%s\n" aid
  | Subgraph (SubgraphDef (_, stmts)) -> List.iter stmts ~f:print_stmt
  | Subgraph _ -> Fmt.pr "\n[Subgraph]\n"
  | Node_stmt ((nid, _), _) -> Fmt.pr "\n[Node]%s\n" (Scan_dot_ast.scan_id nid)
  | Edge_stmt _ -> Fmt.pr "\n[Edge]\n"
  | Attr_node _ -> Fmt.pr "\n[Attr node]\n"
  | Attr_edge ag ->
      let aid = Scan_dot_ast.id_of_attrs ag in
      Fmt.pr "\n[Attr_edge %d]%s\n" (List.length ag) aid
  | Equal (x, y) ->
      Fmt.pr "\n%s = %s\n" (Scan_dot_ast.scan_id x) (Scan_dot_ast.scan_string y)
(* | _ -> Fmt.pr "\nguess\n" *)

let dot_process path =
  let g = DotInput.parse path in
  let dot = Dot.parse_dot_ast path in
  Fmt.pr "\nStmt counts = %d\n" (List.length dot.stmts) ;
  List.iter dot.stmts ~f:print_stmt ;

  g
(* DotInput.parse path *)
