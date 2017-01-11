open Core.Std

type t = {
  title: string;
  contents: string
}

let create ~title ~contents =
  {title; contents}

let title t = t.title

let contents t = t.contents

let to_string t = t.title ^":"^ t.contents
