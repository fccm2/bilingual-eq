
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


let atoms_to_list se =
  List.map (function
  | SExpr.Atom s -> s
  | SExpr.Expr _ -> invalid_arg "expr should be atom"
  ) se


let load filename =
  let ic = open_in filename in
  let lines = input_lines ic in
  close_in ic;

  List.map (fun line ->
    let se =
      try SExpr.parse_string line
      with Failure err ->
        prerr_endline line;
        raise Exit
    in
    match se with
    | [SExpr.Expr se] ->
        begin
          match atoms_to_list se with
          | [] | _ :: [] -> failwith "translation empty"
          | word :: translations -> (word, translations)
        end
    | _ -> failwith line
  ) lines
