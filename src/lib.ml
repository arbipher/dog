open! Core
open! Graph

let magic = 42

let%test _ = magic = 42

let%expect_test _ =
  print_endline "Hello, world!" ;
  [%expect {| Hello, world! |}]

(* let dot_read path = Dot.parse_dot_ast path *)

let dot_process path = Pack.Digraph.parse_dot_file path
(* let dot_write () = () *)