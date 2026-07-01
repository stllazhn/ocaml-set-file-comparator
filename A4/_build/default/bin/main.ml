

(** @author Juanru(Stella) Zhang (jz766), in collabration with Alexandra Allen
    (aa2368) and Daniel Martins Gomes (dm746)*) 
open A4.Sets

module SenSets = struct
  type ele = string

  let compare element_one element_two = String.compare element_one element_two

  let to_string (ele : ele) : string = ele
end

module SensitiveSets = BuildSet(SenSets) 

module InsensitiveSets = BuildSet(InsenSets)
  
let read_file textfile = BatList.of_enum (BatFile.lines_of textfile) 

let () = 
  let argv : string list = Array.to_list Sys.argv in
  if List.length argv = 3 then 
   try
      let list_one = read_file (List.nth argv 1) in
      let list_two = read_file (List.nth argv 2) in
      let empty_set = SensitiveSets.empty in
      let set_one = SensitiveSets.turn_set list_one SensitiveSets.empty in
      let set_two = SensitiveSets.turn_set list_two SensitiveSets.empty in
      let result = SensitiveSets.compare_sets set_one set_two empty_set in
      print_string (SensitiveSets.to_string result)
    with
      |_ -> print_endline "Please ensure you entered the correct command."
  else if List.length argv = 4 &&  List.nth argv 1 = "-i" then
    try
      let list_one = read_file (List.nth argv 2) in
      let list_two = read_file (List.nth argv 3) in
      let empty_insensitive = InsensitiveSets.empty in
      let set_one = InsensitiveSets.turn_set list_one InsensitiveSets.empty in
      let set_two = InsensitiveSets.turn_set list_two InsensitiveSets.empty in
      let result = InsensitiveSets.compare_sets set_one set_two 
      empty_insensitive in
      print_string (InsensitiveSets.to_string result)
    with
      |_ -> print_endline "Please ensure you entered the correct command."
  else Printf.printf "Please enter a valid command."


