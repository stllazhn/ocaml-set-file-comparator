
(** Module type to represent the element type of a set. *)
module type SetType = sig
    (** [ele] is an element. *)
    type ele 
    
    (** [compare element_one element_two] is an integer -1, 1, or 0. [compare] 
    compares type [ele] inputs [element_one] and [element_two]. *)
    val compare : ele -> ele -> int
    
    (** [to_string ele] is a string. [to_string] takes in a type [ele] input
        [ele] and outputs it as a string. *)
    val to_string : ele -> string
end
    
(** A set is an ordered collection of elements of type [ele] 
    in which multiplicity is ignored. *)
module type FuncType = sig 
    (** [ele] is an element. *)
    type ele 

    (** [sets] represents a set whose elements are of type [ele] *)
    type sets

    (** [empty] is the set containing no elements *)
    val empty : sets

    (** [in_set element set] is whether [element] is an element of set [set] *)
    val in_set : ele -> sets -> bool

    (** [add element set] is the set containing all the elements of [set]
      as well as [element]. *)
    val add : ele -> sets -> sets

    (** [to_string set] is the set [set] made into a string. *)
    val to_string : sets -> string

    (** [turn_set] is the list [list_one] containing elements of type [ele] 
    turned into a set. Requires: [empty_set] is an empty set. *)
    val turn_set : ele list -> sets -> sets

    (** [compare_sets set_one set_two] [empty_set] is the set containing
    all the elements that are in both [set_one] and [set_two], accumulated
    via [empty_set]. Requires: [empty_set] is an empty set. *)
    val compare_sets : sets -> sets -> sets -> sets

end

(** Functor for building a set with elements of type [ele]*)
module BuildSet (M : SetType) : FuncType with type ele = M.ele

(** Module for implementation of case sensitive set with elements of 
    type string. *)
module SenSets : SetType

(** Module for implementation of case insensitive set with elements of 
    type string. *)
module InsenSets : SetType with type ele = string
