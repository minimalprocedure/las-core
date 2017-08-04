open Core.Std

let mk_list v l = List.init l ~f:(fun x -> v);;

let genlas n l =
  let rec las = function
    | [], t -> List.rev t
    | h :: hs, [] -> las (hs, [h; 1])
    | h :: hs, a :: b :: t when h = a -> las (hs, a :: 1+b :: t)
    | h :: hs, t -> las (hs, h :: 1 :: t)
  in
  let ls = mk_list n l in
  List.fold ls
    ~init: (mk_list [n] 1)
    ~f: (fun acc e ->
        let last = List.last_exn acc in
        acc @ [las(last, [])]
      )
;;

let print ls =
  let str = String.concat ~sep:"" (List.map ~f:(string_of_int) ls) in
  printf "%s\n" str
;;

let command =
  Command.basic
    ~summary:"las sequence calculator"
    Command.Spec.(
      empty
      +> flag "-l" (required int)
        ~doc:" Recursion limit"
    )

    (fun limit () ->
       let base = 1 in
       let result = genlas base limit in
       List.iter ~f:(print) result;
    )
;;

let main () = Command.run command
    ~version:"0.1"
    ~build_info: "beta build";;

let () =
  if not !Sys.interactive then main ()
;;
