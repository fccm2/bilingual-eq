
let input_line ic =
  try Some (input_line ic)
  with End_of_file -> None


let input_lines ic =
  let rec aux acc =
    match input_line ic with
    | Some line -> aux (line::acc)
    | None -> (List.rev acc)
  in
  aux []


let load_lines filename =
  let ic = open_in filename in
  let lines = input_lines ic in
  close_in ic;
  (lines)


let () =
  let lines = load_lines Sys.argv.(1) in
  let i = ref 1 in
  List.iter (fun line ->
    match line with
    | "<tr>" -> Printf.printf "<tr id=\"p%d\">\n" !i; incr i
    | _ -> print_endline line
  ) lines
