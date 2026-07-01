
open A4.Sets
open OUnit2

module SenSets = struct
  type ele = string

  let compare element_one element_two = String.compare element_one element_two

  let to_string (ele : ele) : string = ele
end

module TestSen = BuildSet(SenSets)

module TestInsen = BuildSet(InsenSets)

let sen_one = TestSen.empty

let a_set = TestSen.add "a" sen_one

let insen_one = TestInsen.empty

let insena_set = TestInsen.add "a" insen_one

let list_three = ["INFO"; "CS"; "INFo"; "AeP";"cs";]

let compare_three = TestInsen.turn_set list_three TestInsen.empty
let compare_III = TestSen.turn_set list_three TestSen.empty

let sen_three = "{AeP,CS,INFO,INFo,cs,}"
let insen_three = "{AeP,CS,INFO,}"

let list_four = ["DEsign";"cs"; "AEP"; "Math";"cs";]

let compare_four = TestInsen.turn_set list_four TestInsen.empty
let compare_IIII = TestSen.turn_set list_four TestSen.empty

let sen_in_test test_name expected_output element set = 
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestSen.in_set element set))

let insen_in_test test_name expected_output element set = 
  test_name >:: (fun _ -> assert_equal expected_output (TestInsen.in_set 
  element set))

let sen_add_test test_name expected_output element set = 
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestSen.to_string (TestSen.add element set)))

let insen_add_test test_name expected_output element set = 
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestInsen.to_string (TestInsen.add element set)))

let sen_compare_test test_name expected_output set_one set_two empty =
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestSen.to_string (TestSen.compare_sets set_one set_two empty)))

let insen_compare_test test_name expected_output set_one set_two empty =
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestInsen.to_string (TestInsen.compare_sets set_one set_two empty)))

let sen_turn_test test_name expected_output set_one empty =
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestSen.to_string (TestSen.turn_set set_one empty)))

let insen_turn_test test_name expected_output set_one empty =
  test_name >:: (fun _ -> assert_equal expected_output 
  (TestInsen.to_string (TestInsen.turn_set set_one empty)))


let tests_one = [
  sen_in_test "sensitive, element in set" true "a" a_set;
  sen_in_test "sensitive, element not in set" false "A" a_set;
  sen_in_test "sensitive, empty set" false "a" sen_one;
  insen_in_test "insensitive, element in set" true "A" insena_set;
  insen_in_test "insensitive, element not in set" false "b" insena_set;
  insen_in_test "insensitive, empty set" false "a" insen_one;
  sen_add_test "sensitive, element in set" "{a,}" "a" a_set;
  sen_add_test "sensitive, element not in set" "{A,a,}" "A" a_set;
  sen_add_test "sensitive, empty set" "{A,}" "A" sen_one;
  insen_add_test "insensitive, element in set" "{a,}" "A" insena_set;
  insen_add_test "insensitive, element not in set" "{a,b,}" "b" insena_set;
  insen_add_test "insensitive, empty set" "{A,}" "A" insen_one;
  sen_turn_test "sensitive, non-empty list" sen_three list_three sen_one;
  sen_turn_test "sensitive, empty list" "{}" [] sen_one;
  insen_turn_test "insensitive, non-empty list" insen_three list_three
  insen_one;
  insen_turn_test "insensitive, empty list" "{}" [] insen_one;
  "a trivial test" >:: (fun _ -> assert_equal 0 0);
]

let tests_two = [
  sen_compare_test "compare sets, sensitive" "{cs,}" compare_III 
  compare_IIII sen_one;
  insen_compare_test "compare sets, insensitive" "{AeP,CS,}" compare_three 
  compare_four insen_one;
]

let suite_one = "interval test suite" >::: tests_one
let suite_two = "interval test suite" >::: tests_two

let _ = run_test_tt_main ("All_tests" >::: [suite_one; suite_two])
