module type SetType = sig
  type ele 
  
  val compare : ele -> ele -> int
  
  val to_string : ele -> string
end
  
module type FuncType = sig 
  type ele

  type sets

  val empty : sets

  val in_set : ele -> sets -> bool

  val add : ele -> sets -> sets

  val to_string : sets -> string

  val turn_set : ele list -> sets -> sets

  val compare_sets : sets -> sets -> sets -> sets

end

(** Abstraction function: [ele] represent the element inside a set. 
    Representation invariant: type [ele] is of type string *)
module SenSets = struct
  type ele = string

  let compare element_one element_two = String.compare element_one element_two

  let to_string (ele : ele) : string = ele
end

(** Abstraction function: [ele] represent the element inside a set. 
    Representation invariant: type [ele] is of type string *)
module InsenSets : SetType with type ele = string  = struct
  type ele = string

  let compare element_one element_two = String.compare 
  (String.lowercase_ascii element_one) (String.lowercase_ascii element_two) 

  let to_string (ele : ele) : string = ele
end 

(** Abstraction function: The list [[a1; ...; an]] represents the
      set [{b1, ..., bm}], where [[b1; ...; bm]] is the same list as
      [[a1; ...; an]] but with any duplicates removed and is sorted.
      The empty list [[]] represents the empty set [{}]. 
      Representation invariant: the list contains no duplicates. the list 
      should be sorted according to the [compare] function in M. *)
module BuildSet (M : SetType) : FuncType with type ele = M.ele = struct
  type ele = M.ele

  type sets = ele list

  let (empty : sets) = []

  let rec in_set element (set : sets) = 
    match set with
    |[] -> false
    |h :: t -> if (M.compare h element = 0) then true else in_set element t

  let add element (set : sets) : sets = 
    if (in_set element set) then set else List.sort M.compare (element::set)

  let rec string_helper (set : sets) =
    match set with 
    |h :: t -> (M.to_string h ^ ",") ^ string_helper t 
    |[] -> ""

  let to_string (set : sets) =  "{" ^ string_helper set ^ "}"

  let rec turn_set (list_one : 'a list) (empty_set)= 
    match list_one with
    |[] -> empty_set
    |h :: t -> turn_set t (add h empty_set)

  let rec compare_sets (set_one : sets) set_two empty_set =
    match set_one with 
    |[] -> empty_set
    |h :: t -> if in_set h set_two then (compare_sets t 
      set_two (add h empty_set)) else
      compare_sets t set_two empty_set
end

module Mod = BuildSet(SenSets)

