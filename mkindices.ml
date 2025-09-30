#load "strings.cmo"
#load "io.cmo"

let alpha = "abcdefghijklmnopqrstuvwxyz"

let nav_letters () =
  let b = Buffer.create 100 in
  Buffer.add_string b "<div class='nav-letters'>\n";
  String.iter (fun c ->
    Buffer.add_string b (
      Printf.sprintf "<a class='nav-letter' href='./index-%c.html'>%c</a> / \n" c
        (Char.uppercase_ascii c)
    )
  ) alpha;
  Buffer.add_string b "</div>\n\n";
  (Buffer.contents b)



let () =
  let tmpl = Io.read_file "./template.i.html" in

  let tables = Sys.readdir "/tmp/en" in

  Array.sort (fun a b ->
    String.compare
      (String.lowercase_ascii a)
      (String.lowercase_ascii b)
  ) tables;

  String.iter (fun c ->

    let b = Buffer.create 100 in
    Buffer.add_string b (nav_letters ());
    Buffer.add_string b "<div class='wordlist'>\n";

    Array.iter (fun word ->
      if (String.lowercase_ascii word).[0] = c then
      begin
        let s = "<a href=\"" ^ word ^ ".html\">" ^ word ^ "</a><br />\n" in
        Buffer.add_string b s;
      end
    ) tables;

    Buffer.add_string b "</div>\n";

    let index = Buffer.contents b in

    let repl = [
      "@INDEX@", index;
    ] in

    match Strings.replace tmpl repl with
    | None -> ()
    | Some res ->
        let filename = Printf.sprintf "/tmp/en-html/index-%c.html" c in
        Io.write_file ~filename res;
        ()

  ) alpha;


  (* index letters *)

  let b = Buffer.create 100 in

  Buffer.add_string b "<div class='letters'>\n";

  String.iteri (fun i c ->
    Buffer.add_string b (
      Printf.sprintf "<a class='letter' href='./index-%c.html'>%c</a> / \n" c
        (Char.uppercase_ascii c));

    if (i mod 6) = 5 then
      Buffer.add_string b "<br />\n";
  ) alpha;

  Buffer.add_string b "</div>\n";

  let repl = [
    "@INDEX@", (Buffer.contents b);
  ] in

  match Strings.replace tmpl repl with
  | None -> ()
  | Some res ->
      let filename = "/tmp/en-html/index.html" in
      Io.write_file ~filename res;
      ()

