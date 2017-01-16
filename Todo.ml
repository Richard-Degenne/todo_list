open Core.Std

type t = {
  filename: string;
  mutable items: Item.t list
}

let init ?(filename=".todo_list") () =
  try
    In_channel.with_file filename ~f:(fun in_c ->
      let items = In_channel.fold_lines in_c ~init:[] ~f:(fun acc str -> 
      match String.split str ~on:':' with
      | [title; contents] -> (Item.create ~title ~contents)::acc
      | _ -> acc (* Ignore malformed lines *)
      )
      in
      {filename; items}
    )
  with Sys_error e -> begin
    (* If the file doesn't exist, create it *)
    Out_channel.(close (create filename));
    {filename; items=[]}
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
