let list_combine l1 l2 =
  let rec aux acc l1 l2 =
    match (l1, l2) with
    | x1::xs1, x2::xs2 -> aux ((x1, x2)::acc) xs1 xs2
    | [], x2::xs2 -> aux (("", x2)::acc) [] xs2
    | x1::xs1, [] -> aux ((x1, "")::acc) xs1 []
    | [], [] -> (List.rev acc)
  in
  aux [] l1 l2

let  input_line_opt ic =
  try Some (input_line ic)
  with End_of_file -> close_in ic; None

let load f =
  let ic = open_in f in
  let rec aux acc b =
    match input_line_opt ic with
    | Some "" -> let s = Buffer.contents b in Buffer.clear b; aux (s::acc) b
    | Some line -> Buffer.add_string b line; Buffer.add_char b '\n'; aux acc b
    | None -> let s = Buffer.contents b in (List.rev (s::acc))
  in
  aux [] (Buffer.create 3)

let () =
  let cnt1 = load Sys.argv.(1) in
  let cnt2 = load Sys.argv.(2) in
  let comb = list_combine cnt1 cnt2 in
  List.iter (fun (p1, p2) ->
    Printf.printf {|
<tr>
  <td class="fr">
%s  </td>
  <td class="en">
%s  </td>
</tr>
|} p1 p2;
  ) comb
