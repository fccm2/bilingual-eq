#directory "./sexpr"
#load "SExpr.cma"

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


let load_lines ~filename =
  let ic = open_in filename in
  let lines = input_lines ic in
  close_in ic;
  (lines)


let atoms_to_list se =
  List.map (function
  | SExpr.Atom s -> s
  | SExpr.Expr _ -> invalid_arg "expr should be atom"
  ) se


let rem_dup xs =
  let rec aux acc = function
    | x :: xs ->
        if List.mem x acc then aux acc xs
        else aux (x::acc) xs
    | [] -> (List.rev acc)
  in
  aux [] xs


let () =
  let filename = "./en-to-fr.ss" in
  let lines = load_lines ~filename in

  List.iter (fun line ->
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
          | word :: translations ->
              let translations = rem_dup translations in
              Printf.printf "(";
              print_string (
                String.concat " " (
                  List.map (fun w -> "\"" ^ w ^ "\"") (word :: translations)
                );
              );
              Printf.printf ")\n";
        end
    | _ -> failwith line
  ) lines
