let print_head () =
  print_endline {|
<html>
<head>
<style type="text/css">
body { color:#BBC; background:#EEE; padding:1em 1em 3em 2em; margin:0; }
td { border:1px solid #ABC; padding:0; margin:1px; }
p { padding:0; text-indent:1.2em; }
td.en { color:#420; }
td.fr { color:#024; }

table { width:82%; margin:0.4em 5% 1.4em 1%; }
td { width:50%; vertical-align:top; }
</style>
</head>
<body>
|};;


let hi w =
  ("<b> " ^ w ^ " </b>")

let sp w =
  (" " ^ w ^ " ")

let push r v =
  r := v :: !r;
;;

let print_para = (fun (word, trans_word, p1, p2) ->
    print_endline "<table>";
    Printf.printf "<tr><td class='fr'><b>%s</b></td><td class='en'><b>%s</b></td></tr>\n" trans_word word;
    Printf.printf "<tr><td class='fr'>%s</td>\n<td class='en'>%s</td></tr>\n\n" p2 p1;
    print_endline "</table>";
    print_newline ()
  )

let () =
  let dh = Dict.load () in
  let paras = Paras.load ~filename:"./The_Lost_World.html" in
  print_head ();

  Hashtbl.iter (fun word translations ->
    List.iter (fun (p1, p2) ->
      let p1, p2 = (p2, p1) in
      match Strings.replace p1 [(sp word, hi word)] with
      | None -> ()
      | Some p1 ->
          List.iter (fun trans_word ->
            match Strings.replace p2 [(sp trans_word, hi trans_word)] with
            | None -> ()
            | Some p2 ->
                print_para (word, trans_word, p1, p2)

          ) translations;
    ) paras;
  ) dh;

  (*
  List.iter print_para !r;
  *)

  ()
