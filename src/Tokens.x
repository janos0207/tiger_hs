{
module Tokens where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-
    $white+                       { \s -> White }
    "--".*                        { \s -> Comment }
    let                           { \s -> Let }
    in                            { \s -> In }
    $digit+                       { \s -> Int (read s) }
    [\=\+\-\*\/\(\)]              { \s -> Sym(head s) }
    $alpha [$alpha $digit \_ \']* { \s -> Var s }

{
data Token =
    White      |
    Comment    |
    Let        |
    In         |
    Sym Char   |
    Var String |
    Int Int    |
    Err
    deriving (Eq, Show)
}