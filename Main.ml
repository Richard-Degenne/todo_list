open Core.Std

let list_items =
  Command.basic
    ~summary:("List all items from the list")
    Command.Spec.(
      empty
    )
    (fun () ->
      Todo.init ()
      |> Todo.list_items
      |> List.iter ~f:(fun item -> printf "%s\t%s\n" (Item.title item) (Item.contents item))
    )

let command =
  Command.group
    ~summary:("A simple todo-list manager written in OCaml.")
    ~readme:(fun () -> "\
      TodoList is a software that lets you manage a simple task list : add, list and delete items.\
    ")
    ["list", list_items]

let () =
  Command.run command ~version:"0.1" ~build_info:"ocamlbuild 4.04.0"

