open! Core
open! Graph

let magic = 42

let%test _ = magic = 42

let%expect_test _ =
  print_endline "Hello, world!" ;
  [%expect {| Hello, world! |}]

(* let dot_read path = Dot.parse_dot_ast path *)

let dot_process path = Pack.Digraph.parse_dot_file path

(* module DotGraph = Dot.Parse (Builder.I) *)

(* let dot_parse path = DotGraph.parse path *)
(* let dot_write () = () *)

(* let remove_node _node (_g : Sig.G.t) = () *)

let remove_vertex v g = Pack.Digraph.remove_vertex g v