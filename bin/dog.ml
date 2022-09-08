let () =
  let open Graph in
  let path = Sys.argv.(1) in
  (* let dotfile = Lib.dot_read path in
     print_string @@ string_of_bool dotfile.strict ; *)
  let g = Lib.dot_process path in
  (let v_id = 1 in
   let v = Pack.Digraph.find_vertex g v_id in
   Lib.remove_vertex v g) ;
  Pack.Digraph.print_gml Format.std_formatter g
