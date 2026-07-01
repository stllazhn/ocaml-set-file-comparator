
# OCaml Set File Comparator

This is an OCaml command-line project that compares two text files as sets of strings and returns the lines that appear in both files.

The project supports both case-sensitive and case-insensitive comparison.

## Features

- Reads two text files from the command line
- Converts each file into a set of strings
- Removes duplicate lines
- Sorts set elements
- Finds the intersection between two sets
- Supports case-sensitive comparison
- Supports case-insensitive comparison with the `-i` flag
- Includes OUnit tests for set operations

## Tech Stack

- OCaml
- Dune
- OUnit2
- Batteries

## Project Structure

```text
bin/
  main.ml        Command-line interface

lib/
  sets.ml        Set implementation
  sets.mli       Set interface
```
## How to Run

Make sure you have OCaml and Dune installed.

First, build the project:

```bash
dune build
```

To compare two files with case-sensitive matching, run:

```bash
dune exec bin/main.exe file1.txt file2.txt
```

Example:

```bash
dune exec bin/main.exe testone1.txt testone2.txt
```

To compare two files while ignoring capitalization, use the `-i` flag:

```bash
dune exec bin/main.exe -- -i file1.txt file2.txt
```

Example:

```bash
dune exec bin/main.exe -- -i testone1.txt testone2.txt
```

The program will print the lines that appear in both files.

## How to Run Tests

To run the test suite:

```bash
dune runtest
```

## Notes

The `--` in this command matters:

```bash
dune exec bin/main.exe -- -i testone1.txt testone2.txt
```

It tells Dune that the `-i` flag belongs to this program, not to Dune.

