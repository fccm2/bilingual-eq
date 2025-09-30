open Xmlerr

let rem_p x =
  let rec aux acc = function
    | Tag ("p", _) :: x | ETag "p" :: x
    | Tag ("i", _) :: x | ETag "i" :: x
    | Tag ("b", _) :: x | ETag "b" :: x
    | Tag ("br", _) :: x | ETag "br" :: x
    | Tag ("em", _) :: x | ETag "em" :: x
    | Tag ("div", _) :: x | ETag "div" :: x
    | Tag ("span", _) :: x | ETag "span" :: x -> aux acc x

    | (Data s) :: x -> aux ((Data s)::acc) x

    | Comm _ :: x -> aux acc x

    | [] -> (List.rev acc)

    | elem :: x -> aux (elem::acc) x
  in
  aux [] x


let join_s x =
  let rec aux acc = function
    | (Data s1) :: (Data s2) :: x ->
        let s = s1 ^ "\n" ^ s2 in
        aux acc ((Data s)::x)

    | [] -> (List.rev acc)

    | elem :: x -> aux (elem::acc) x
  in
  aux [] x


let titles_eq = [
  "The_Lost_World.html",
    ("Le Monde perdu, de Arthur Conan Doyle",
     "The Lost World, by Arthur Conan Doyle");

  "The_Hound_of_the_Baskervilles.html",
    ("Le Chien des Baskerville, de Arthur Conan Doyle",
     "The Hound of the Baskervilles, by Arthur Conan Doyle");

  "The_Adventures_of_Sherlock_Holmes.html",
    ("Les Aventures de Sherlock Holmes, de Arthur Conan Doyle",
     "The Adventures of Sherlock Holmes, by Arthur Conan Doyle");

  "The_Confessions_of_Arsene_Lupin.html",
    ("Les Confidences d’Arsène Lupin, de Maurice Leblanc",
     "The Confessions of Arsene Lupin, by Maurice Leblanc");

  "Arsene_Lupin_Gentleman_Burglar.html",
    ("Arsène Lupin gentleman-cambrioleur, de Maurice Leblanc",
     "The Extraordinary Adventures of Arsene Lupin, Gentleman Burglar, by Maurice Leblanc");

  "Alice_s_Adventures_in_Wonderland.html",
    ("Aventures d’Alice au Pays des Merveilles, par Lewis Carroll",
     "Alice’s Adventures in Wonderland, by Lewis Carroll");

  "The_Three_Musketeers.html",
    ("Les Trois Mousquetaires, de Alexandre Dumas",
     "The Three Musketeers, by Alexandre Dumas");

  "Treasure_Island.html",
    ("L’Île au trésor, de Robert Louis Stevenson",
     "Treasure Island, by Robert Louis Stevenson");

  "Camille.html",
    ("La Dame aux Camélias, de Alexandre Dumas fils",
     "The Lady with the Camellias, by Alexandre Dumas son");
]


let get_titles file =
  List.assoc (Filename.basename file) titles_eq


let get_attr a attrs =
  try List.assoc a attrs
  with Not_found -> ""


let load _acc ~filename =
  let x = Xmlerr.parse_file ~filename in
  let x = Xmlerr.strip_white x in
  let x = rem_p x in
  let x = join_s x in
  let title1, title2 = get_titles filename in
  let rec aux acc = function
    | Tag ("tr", attrs) ::
      Tag ("td", _) :: Data s1 :: ETag "td" ::
      Tag ("td", _) :: Data s2 :: ETag "td" ::
      ETag "tr" :: x ->
        let id = get_attr "id" attrs in
        aux ((s1, s2, filename, title1, title2, id)::acc) x

    | Data _ :: x -> aux acc x
    | Comm _ :: x -> aux acc x
    | _ :: x -> aux acc x
    | [] -> (List.rev_append acc _acc)
  in
  let paras = aux [] x in
  (paras)

