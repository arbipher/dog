let () =
  let path = Sys.argv.(1) in
  print_endline path ;
  let dotfile = Lib.dot_read path in
  print_string @@ string_of_bool dotfile.strict