
let esc s =
  let s = String.lowercase_ascii s in
  let repl = [
    "é", "e";
    "è", "e";
    "ê", "e";
    "ë", "e";
    "à", "a";
    "â", "a";
    "ä", "a";
    "ù", "u";
    "û", "u";
    "ü", "u";
    "î", "i";
    "ï", "i";
    "î", "i";
    "ô", "o";
    "ö", "o";
    "œ", "oe";
    "æ", "ae";
    "ç", "c";
    " ", "_";
    "ß", "ss";
  ] in
  match Strings.replace s repl with
  | Some r -> r
  | None -> s

