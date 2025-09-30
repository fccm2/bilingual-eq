let print_head () =
  print_endline {|
<html>
<head>
<title>BilingLit</title>
<style type="text/css">
body { color:#BBC; background:#EEE; padding:1em 1em 3em 2em; margin:0; }
td { border:1px solid #ABC; padding:0; margin:1px; }
p { padding:0 1px; text-indent:1.2em; }
td.en { color:#420; }
td.fr { color:#024; }

table { width:82%; margin:0.4em 5% 1.4em 1%; }
td { width:50%; vertical-align:top; }
</style>
</head>
<body>
|};;


let pat w = [
  (" " ^ w ^ " "), (" <b>" ^ w ^ "</b> ");
  (" " ^ w ^ ","), (" <b>" ^ w ^ "</b>,");
  (" " ^ w ^ "."), (" <b>" ^ w ^ "</b>.");
  (" " ^ w ^ "\n"), (" <b>" ^ w ^ "</b>\n");
]


let print_para = (fun (word, trans_word, p1, p2) ->
    print_endline "<table>";
    Printf.printf "<tr><td class='fr'><b>%s</b></td><td class='en'><b>%s</b></td></tr>\n" trans_word word;
    Printf.printf "<tr><td class='fr'>\n%s\n</td><td class='en'>\n%s</td></tr>\n" p2 p1;
    print_endline "</table>";
    print_newline ()
  )


let () =
  let dh = Dict.load () in

  let paras = [] in
  let paras = Paras.load paras ~filename:"./The_Lost_World.html" in
  let paras = Paras.load paras ~filename:"./The_Hound_of_the_Baskervilles.html" in
  let paras = Paras.load paras ~filename:"./The_Confessions_of_Arsene_Lupin.html" in
  let paras = Paras.load paras ~filename:"./Arsene_Lupin_Gentleman_Burglar.html" in
  let paras = Paras.load paras ~filename:"./Alice_s_Adventures_in_Wonderland.html" in
  let paras = Paras.load paras ~filename:"./The_Three_Musketeers.html" in
  let paras = Paras.load paras ~filename:"./Treasure_Island.html" in
  let paras = Paras.load paras ~filename:"./Camille.html" in

  print_head ();

  Hashtbl.iter (fun word translations ->
    List.iter (fun (p1, p2) ->
      let p1, p2 = (p2, p1) in
      match Strings.replace p1 (pat word) with
      | None -> ()
      | Some p1 ->
          List.iter (fun trans_word ->
            match Strings.replace p2 (pat trans_word) with
            | None -> ()
            | Some p2 ->
                print_para (word, trans_word, p1, p2)

          ) translations;
    ) paras;
  ) dh;

  ()
