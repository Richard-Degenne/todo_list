open Core.Std

type t = {
  filename: string;
  mutable items: Item.t list
}

let last_char s =
  String.get s (String.length s - 1)

let init ?(filename=".todo_list") () =
  let realpath = match Sys.getenv("HOME") with
    | Some str -> str ^ (if (last_char str)='/' then "" else "/" ) ^ filename
    | None -> printf "$HOME is not set. Falling back on current directory.\n"; filename
  in
  try
    In_channel.with_file realpath ~f:(fun in_c ->
      let items = In_channel.fold_lines in_c ~init:[] ~f:(fun acc str -> 
      match String.split str ~on:':' with
      | [title; contents] -> (Item.create ~title ~contents)::acc
      | _ -> printf "Warning: Malformed line \"%s\"\n" str; acc (* Ignore malformed lines *)
      )
      in
      {filename=realpath; items}
    )
  with Sys_error e -> begin
    (* If the file doesn't exist, create it *)
    printf "'%s' doesn't exist. Touching it right now.\n" realpath;
    Out_channel.(close (create realpath));
    {filename = realpath; items=[]}
  end

let save t =
  Out_channel.with_file t.filename ~f:(fun out_c ->
      Out_channel.output_lines out_c (List.map t.items ~f:(Item.to_string))
    )

let list_items t = t.items

let add_item t ~item =
  t.items <- item::t.items;
  t

let delete_item t ~item =
  t.items <- List.filter t.items ~f:((<>) item);
  t

let find_item t ~title =
  List.find t.items ~f:(fun item -> (Item.title item) = title)
