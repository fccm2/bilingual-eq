#load "strings.cmo"
#load "io.cmo"

let () =
  let tmpl = Io.read_file "./template.i.html" in

  let tables = Sys.readdir "/tmp/en" in

  Array.sort (fun a b ->
    String.compare
      (String.lowercase_ascii a)
      (String.lowercase_ascii b)
  ) tables;

  let b = Buffer.create 100 in

  Buffer.add_string b "<div style='columns:120px 8;'>\n";

  Array.iter (fun word ->
    let s = "<a href='" ^ word ^ ".html'>" ^ word ^ "</a><br />\n" in
    Buffer.add_string b s;

  ) tables;

  Buffer.add_string b "</div>\n";

  let index = Buffer.contents b in

  let repl = [
    "@INDEX@", index;
  ] in

  match Strings.replace tmpl repl with
  | None -> ()
  | Some res ->
      Io.write_file ~filename:("/tmp/en-html/index.html") res;
      ()

