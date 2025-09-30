
let write_file ~filename s =
  let oc = open_out filename in
  output_string oc s;
  close_out oc;
;;

let append_to_file ~filename s =
  let perm = 0o644 in
  let mode = [Open_creat; Open_append] in
  let oc = open_out_gen mode perm filename in
  output_string oc s;
  close_out oc;
;;

let read_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  (Bytes.to_string s)

