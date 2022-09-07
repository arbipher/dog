open! Core
open! Graph

let magic = 42

let%test _ = magic = 42

let%expect_test _ =
  print_endline "Hello, world!" ;
  [%expect {| Hello, world! |}]

let dot_read path =
  let content = In_channel.read_all path in
  Dot.parse_dot_ast content

(* let dot_process () = () *)
(* let dot_write () = () *)