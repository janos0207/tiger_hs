{
module Tokens (Token(..), AlexPosn(..), alexScanTokens, token_posn) where
}

%wrapper "posn"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-
    $white+                       ;
    "--".*                        ;
    var                           { tok (\p s -> Var p)}
    let                           { tok (\p s -> Let p) }
    in                            { tok (\p s -> In p) }
    $digit+                       { tok (\p s -> Int p (read s)) }
    :=                            { tok (\p s -> Declare p)}
    ==                            { tok (\p s -> Eq p) }
    :                             { tok (\p s -> Colon p)}
    \/                            { tok (\p s -> Divide p) }
    \*                            { tok (\p s -> Times p) }
    \-                            { tok (\p s -> Minus p) }
    \+                            { tok (\p s -> Plus p) }
    \(                            { tok (\p s -> LParen p) }
    \)                            { tok (\p s -> RParen p) }
    $alpha [$alpha $digit \_ \']* { tok (\p s -> Id p s) }

{
tok f p s = f p s

data Token =
    Var AlexPosn        |
    Let AlexPosn        |
    In  AlexPosn        |
    Assign AlexPosn     |
    Declare AlexPosn    |
    Eq AlexPosn         |
    Colon AlexPosn      |
    Divide AlexPosn     |
    Times AlexPosn      |
    Minus AlexPosn      |
    Plus AlexPosn       |
    LParen AlexPosn     |
    RParen AlexPosn     |
    Int AlexPosn Int    |
    Id AlexPosn String  |
    Err
    deriving (Eq, Show)

token_posn (Let p) = p
token_posn (In p) = p
token_posn (Assign p) = p
token_posn (Divide p) = p
token_posn (Times p) = p
token_posn (Minus p) = p
token_posn (Plus p) = p
token_posn (Id p _) = p
token_posn (Int p _) = p

}