#load "strings.cmo"
#load "io.cmo"

let () =
  let tmpl = Io.read_file "./template.html" in

  let tables = Sys.readdir "/tmp/en" in


  Array.iter (fun word ->
    let filename = "/tmp/en/" ^ word in
    let paras = Io.read_file filename in

    let repl = [
      "@WORD@", word;
      "@PARAS@", paras;
    ] in

    match Strings.replace tmpl repl with
    | None -> ()
    | Some res ->
        Io.write_file ~filename:("/tmp/en-html/" ^ word ^ ".html") res;
        ()

  ) tables;

  ()
