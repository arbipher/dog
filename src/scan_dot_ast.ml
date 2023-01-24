(* In OCamlgraph,
   `Dot_ast` is a pure syntax AST.
   `Graphviz.CommonAttributes` is a sematics AST.
   `Graphviz.DotAttributes` is a sematics AST that awares the dot engine.
   `Graphviz.NeatoAttributes` is a sematics AST that awares the neato engine.
*)

open Core
open Graph

let unmatched_tag s = `_Unmatched s
let raise_tag tag = failwith @@ "tag: " ^ tag

let scan_id (x : Dot_ast.id) =
  match x with Dot_ast.Ident s -> s | _ -> failwith "must be id"

let scan_string (x : Dot_ast.id) =
  match x with Dot_ast.String s -> s | _ -> failwith "must be string"

let scan_id_exn (xe : Dot_ast.id option) =
  let x = Option.value_exn xe in
  match x with Dot_ast.Ident s -> s | _ -> failwith "must be id"

let id_of_attrs (attr : Dot_ast.attr list) =
  let attr = List.hd_exn attr in
  let one_attr = List.hd_exn attr in
  let akey, _aval = one_attr in
  scan_id akey

let scan_shape = function
  | "record" -> `Record
  | "box" -> `Box
  | "ellipse" -> `Ellipse
  | "oval" -> `Oval
  | "circle" -> `Circle
  | "egg" -> `Egg
  | "triangle" -> `Triangle
  | "plaintext" -> `Plaintext
  | "diamond" -> `Diamond
  | "trapezium" -> `Trapezium
  | "parallelogram" -> `Parallelogram
  | "house" -> `House
  | "doublecircle" -> `Doublecircle
  | "doubleoctagon" -> `Doubleoctagon
  | "tripleoctagon" -> `Tripleoctagon
  | "invtriangle" -> `Invtriangle
  | "invtrapezium" -> `Invtrapezium
  | "invhouse" -> `Invhouse
  | "Mdiamond" -> `Mdiamond
  | "Msquare" -> `Msquare
  | "Mcircle" -> `Mcircle
  | "star" -> `Star
  | "underline" -> `Underline
  | "note" -> `Note
  | "tab" -> `Tab
  | "folder" -> `Folder
  | "box3d" -> `Box3d
  | "component" -> `Component
  | "promoter" -> `Promoter
  | "cds" -> `Cds
  | "terminator" -> `Terminator
  | "utr" -> `Utr
  | "primersite" -> `Primersite
  | "restrictionsite" -> `Restrictionsite
  | "fivepoverhang" -> `Fivepoverhang
  | "threepoverhang" -> `Threepoverhang
  | "noverhang" -> `Noverhang
  | "assembly" -> `Assembly
  | "signature" -> `Signature
  | "insulator" -> `Insulator
  | "ribosite" -> `Ribosite
  | "rnastab" -> `Rnastab
  | "proteasesite" -> `Proteasesite
  | "proteinstab" -> `Proteinstab
  | "rpromoter" -> `Rpromoter
  | "rarrow" -> `Rarrow
  | "larrow" -> `Larrow
  | "lpromoter" -> `Lpromoter
  | tag -> raise_tag tag

(*
   | "plain" ->
   | "polygon" ->
     | "pentagon" ->
     | "hexagon" ->
     | "septagon" ->
     | "octagon" ->
     | "rect" ->
   | "rectangle" ->
   | "square" ->
     | "none" ->
       | "cylinder" ->
   | "point" ->
*)

(* Top-level scan  *)

let scan_vertex = function
  | "color" -> `Color
  (* | "" -> `ColorWithTransparency *)
  | "fontcolor" -> `Fontcolor
  | "fontname" -> `Fontname
  | "fontsize" -> `Fontsize
  | "height" -> `Height
  | "label" -> `Label
  (* | "" -> `HtmlLabel *)
  | "orientation" -> `Orientation
  | "penwidth" -> `Penwidth
  | "peripheries" -> `Peripheries
  | "regular" -> `Regular
  | "shape" -> `Shape
  | "style" -> `Style
  | "width" -> `Width
  | tag -> unmatched_tag tag

let scan_arrow_style = function "normal" -> `Normal | tag -> raise_tag tag

let scan_edge = function
  | "arrowhead" -> `Arrowhead
  | "arrowsize" -> `Arrowsize
  | tag -> unmatched_tag tag

let scan_graph = function
  (* CommonAttributes  *)
  | "center" -> `Center
  | "fontcolor" -> `Fontcolor
  | "fontname" -> `Fontname
  | "fontsize" -> `Fontsize
  | "label" -> `Label (* `HtmlLabel *)
  | "orientation" -> `Orientation
  | "page" -> `Page
  | "pagedir" -> `Pagedir
  | "size" -> `Size
  | "ordering" -> `OrderingOut
  | tag -> unmatched_tag tag

(* let graph_tag_of_string = function
    | *)
