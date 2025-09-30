
let cap = String.capitalize_ascii

let pat w = [
  (" " ^ w ^ " "), (" <b>" ^ w ^ "</b> ");
  (" " ^ w ^ ","), (" <b>" ^ w ^ "</b>,");
  (" " ^ w ^ "."), (" <b>" ^ w ^ "</b>.");
  ("'" ^ w ^ " "), ("'<b>" ^ w ^ "</b> ");
  ("’" ^ w ^ " "), ("’<b>" ^ w ^ "</b> ");
  (" " ^ w ^ "’"), (" <b>" ^ w ^ "</b>’");
  (" " ^ w ^ "s "), (" <b>" ^ w ^ "s</b> ");
  (" " ^ w ^ "\n"), (" <b>" ^ w ^ "</b>\n");
  ("\n" ^ w ^ " "), ("\n<b>" ^ w ^ "</b> ");
  ((cap w) ^ " "), ("<b>" ^ (cap w) ^ "</b> ");
]

let string_para1 (word, trans_word, p1, p2, file, title1, title2, id) =
  String.concat "" [
    Printf.sprintf "<table>\n";
    Printf.sprintf "<!-- %s / %s -->\n" trans_word word;
    Printf.sprintf "<tr><td class='fr'>\n%s\n</td><td class='en'>\n%s\n</td></tr>\n" p1 p2;
    Printf.sprintf "<tr><td class='from en'>\n<a class='from' href='%s#%s'>%s</a>\n</td><td class='from fr'>\n" file id title1;
    Printf.sprintf "<a class='from' href='%s#%s'>%s</a>\n</td></tr>\n" file id title2;
    Printf.sprintf "</table>\n\n";
  ]
;;

let string_para2 (word, trans_word, p1, p2, file, title1, title2, id) =
  String.concat "" [
    Printf.sprintf "<table>\n";
    Printf.sprintf "<!-- %s / %s -->\n" word trans_word;
    Printf.sprintf "<tr><td class='en'>\n%s\n</td><td class='fr'>\n%s\n</td></tr>\n" p2 p1;
    Printf.sprintf "<tr><td class='from en'>\n<a class='from' href='%s#%s'>%s</a>\n</td><td class='from fr'>\n" file id title2;
    Printf.sprintf "<a class='from' href='%s#%s'>%s</a>\n</td></tr>\n" file id title1;
    Printf.sprintf "</table>\n\n";
  ]
;;


let file_names (word, trans_word, p1, p2, _, _, _, _) =
  (Printf.sprintf "/tmp/fr/%s" trans_word,
   Printf.sprintf "/tmp/en/%s" word)
;;


let print_para weq =
  let p1 = string_para1 weq in
  let p2 = string_para2 weq in
  let f1, f2 = file_names weq in
  try
    Io.append_to_file ~filename:f1 p1;
    Io.append_to_file ~filename:f2 p2;
  with _ -> ()
;;


let books = [
  "./html/The_Lost_World.html";
  "./html/The_Hound_of_the_Baskervilles.html";
  "./html/The_Adventures_of_Sherlock_Holmes.html";
  "./html/The_Confessions_of_Arsene_Lupin.html";
  "./html/Arsene_Lupin_Gentleman_Burglar.html";
  "./html/Alice_s_Adventures_in_Wonderland.html";
  "./html/The_Three_Musketeers.html";
  "./html/Treasure_Island.html";
  "./html/Camille.html";
]


let h1 = Hashtbl.create 100
let h2 = Hashtbl.create 100
let num h w =
  match Hashtbl.find_opt h w with
  | None -> 0
  | Some n -> n

let increm h w =
  match Hashtbl.find_opt h w with
  | None -> Hashtbl.add h w 1
  | Some n -> Hashtbl.replace h w (n + 1)



let () =
  let ds = Dict.load "./en-to-fr.ss" in

  let paras =
    List.fold_left (fun paras filename ->
      Paras.load paras ~filename
    ) [] books
  in

  Random.self_init ();
  let ds = List.sort (fun _ _ -> (Random.int 3) - 1) ds in
  let paras = List.sort (fun _ _ -> (Random.int 3) - 1) paras in

  let n1 = List.length ds in
  let n2 = List.length paras in
  let n = n1 * n2 in
  let i = ref 0 in

  Printf.printf "%d words\n" n1;
  Printf.printf "%d paras\n" n2;

  List.iter (fun (word, translations) ->
    List.iter (fun (p1, p2, file, title1, title2, id) ->
      incr i;
      Printf.printf " > %2.3f %%\r%!" (((float !i) /. (float n)) *. 100.0);
      if num h1 word > 22 then () else
      match Strings.replace p2 (pat word) with
      | None -> ()
      | Some p2 ->
          List.iter (fun trans_word ->
            if num h2 trans_word > 22 then () else
            match Strings.replace p1 (pat trans_word) with
            | None -> ()
            | Some p1 ->
                increm h1 word;
                increm h2 trans_word;
                Printf.printf "\n > match found for: %s / %s\n%!" word trans_word;
                print_para (word, trans_word, p1, p2, file, title1, title2, id)

          ) translations;
    ) paras;
  ) ds;

  print_newline ()
