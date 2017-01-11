open Core.Std

type t

val init : ?filename:string -> unit -> t

val save : t -> unit

val list_items : t -> Item.t list

val add_item : t -> Item.t -> unit

val delete_item : t -> Item.t -> unit