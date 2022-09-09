open Graph
module G = Imperative.Digraph.Abstract (String)
module B = Builder.I (G)

module DotInput =
  Dot.Parse
    (B)
    (struct
      let node (id, _) _ =
        match id with
        | Dot_ast.Ident s | Dot_ast.Number s | Dot_ast.String s | Dot_ast.Html s
          ->
            s

      let edge _ = ()
    end)

module Display = struct
  include G

  let vertex_name v = "\"" ^ String.escaped (V.label v) ^ "\""
  let graph_attributes _ = []
  let default_vertex_attributes _ = []
  let vertex_attributes _ = []
  let default_edge_attributes _ = []
  let edge_attributes _ = [ `HtmlLabel "f&#36;oo" ]
  let get_subgraph _ = None
end

module DotOutput = Graphviz.Dot (Display)

let dot_process path = DotInput.parse path
