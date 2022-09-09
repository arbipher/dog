open Core

let argv = Sys.get_argv ()

(* let () =
   let open Graph in
   let path = argv.(1) in
   (* let dotfile = Lib.dot_read path in
      print_string @@ string_of_bool dotfile.strict ; *)
   let g = Custom.dot_process path in
   (let v_id = 1 in
    let v = Pack.Digraph.find_vertex g v_id in
    Custom.remove_vertex v g) ;
   Pack.Digraph.print_gml Format.std_formatter g *)

let () =
  let path = argv.(1) in
  (* let g = From_test.dot_process path in *)
  let g = Inout.dot_process path in
  let dog_file = Out_channel.create "a.dog" in
  Inout.DotOutput.output_graph dog_file g ;
  Out_channel.close dog_file ;
  Inout.DotOutput.output_graph Out_channel.stdout g
(* From_test.DotOutput.output_graph stdout g *)
