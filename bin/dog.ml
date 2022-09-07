let () =
  let path = Sys.argv.(1) in
  (* let dotfile = Lib.dot_read path in
     print_string @@ string_of_bool dotfile.strict ; *)
  let g = Lib.dot_process path in
  Graph.Pack.Digraph.print_gml Format.std_formatter g
