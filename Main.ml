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

let add_item =
  Command.basic
    ~summary:("Add a new element to the list")
    Command.Spec.(
      empty
      +> anon ("title" %: string)
      +> anon ("contents" %: string)
    )
    (fun title contents () ->
       Todo.init ()
       |> Todo.add_item ~item:(Item.create ~title ~contents)
       |> Todo.save
    )

let delete_item =
  Command.basic
    ~summary:("Delete an element from the list")
    Command.Spec.(
      empty
      +> anon ("title" %: string)
    )
    (fun title () ->
       let t = Todo.init () in
       match Todo.find_item t ~title with
       | Some item -> Todo.delete_item t ~item |> Todo.save
       | None -> printf "No item has title '%s'\n" title
    )

let command =
  Command.group
    ~summary:("A simple todo-list manager written in OCaml.")
    ~readme:(fun () -> "\
      TodoList is a software that lets you manage a simple task list : add, list and delete items.\
    ")
    ["list", list_items;
     "add", add_item;
     "delete", delete_item]

let () =
  Command.run command ~version:"0.1" ~build_info:"ocamlbuild 4.04.0"

