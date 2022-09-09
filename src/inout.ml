open Core
open Graph
module G = Dograph.G
module B = Builder.P (G)

module DotInput =
  Dot.Parse
    (B)
    (struct
      let node node_id (attrs : Dot_ast.attr list) : Dograph.Dot_vertex.t =
        { node_id; attrs = List.map ~f:Dograph.node_attr_of_attr attrs }

      (*  *)
      (* Dograph.node_attr_of_attr *)
      let edge _ = "a"
    end)

module Display = struct
  include G

  (* let vertex_name v = "\"" ^ String.escaped (V.label v) ^ "\"" *)
  let vertex_name vid =
    String.escaped @@ Dograph.string_of_node_id (V.label vid)

  let vertex_attributes vid =
    let v = V.label vid in
    v.attrs

  let graph_attributes _ = []
  let default_vertex_attributes _ = []
  let default_edge_attributes _ = []
  let edge_attributes _ = [ `HtmlLabel "ff&#36;oo" ]
  let get_subgraph _ = None
end

module DotOutput = Graphviz.Dot (Display)

let dot_process path = DotInput.parse path
