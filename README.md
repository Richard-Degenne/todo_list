TodoList
========

A simple todo-list manager written in OCaml.

About
-----

TodoList is a software that lets you manage a simple task list : add, list and delete items.

Need help?
----------

`todo_list` accepts different subcommands.

### `add`

#### Usage

```
$ ./Main.native add TITLE CONTENTS
```

#### Synopsis

Adds a new element to your todo list. Give your memo a title and contents. For instance:

```
$ ./Main.native add "OCaml" "Learn more about this awesome language"
```

### `list`

#### Usage

```
$ ./Main.native list
```

#### Synopsis

List all items from you todo list.

### `delete`

#### Usage

```
$ ./Main.native delete TITLE
```

#### Synopsis

Delete an item from your todo list when you're done with it by using its title. For instance,

```
$ ./Main.native delete "OCaml"
```

An error message will show up if no items match your command.

*Warning*: If several items have the same title, they will all be deleted, so be careful when using this subcommand.

License
-------

TodoList is licensed under the terms of the GNU Public License. See `license` for further information.

Contact
-------

For any question, remark or information, feel free to contact Richard Degenne
<richdeg2 AT gmail DOT com>. And make sure to fork and submit any pull
request you consider relevant.

