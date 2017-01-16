open Core.Std

type t

val create : title:string -> contents:string -> t

val title : t -> string

val contents : t -> string

val to_string : t -> string
