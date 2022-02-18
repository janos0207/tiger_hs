import Control.Exception (evaluate)
import Test.Hspec
import Test.Hspec.QuickCheck
import Tokens

main :: IO ()
main = hspec $ do
  describe "Tokenizer" $ do
    it "returns tokens for elementary arithmetics" $ do
      alexScanTokens "2 + 2 == 5"
        `shouldBe` [ Int (AlexPn 0 1 1) 2,
                     Plus (AlexPn 2 1 3),
                     Int (AlexPn 4 1 5) 2,
                     Eq (AlexPn 6 1 7),
                     Int (AlexPn 9 1 10) 5
                   ]
      alexScanTokens "1 * 2 / (3 - 4)"
        `shouldBe` [ Int (AlexPn 0 1 1) 1,
                     Times (AlexPn 2 1 3),
                     Int (AlexPn 4 1 5) 2,
                     Divide (AlexPn 6 1 7),
                     LParen (AlexPn 8 1 9),
                     Int
                       (AlexPn 9 1 10)
                       3,
                     Minus (AlexPn 11 1 12),
                     Int
                       (AlexPn 13 1 14)
                       4,
                     RParen (AlexPn 14 1 15)
                   ]

    it "returns tokens for variable declaration" $
      do
        alexScanTokens "var x: int := 1"
        `shouldBe` [ Var (AlexPn 0 1 1),
                     Id (AlexPn 4 1 5) "x",
                     Colon (AlexPn 5 1 6),
                     Id (AlexPn 7 1 8) "int",
                     Declare (AlexPn 11 1 12),
                     Int (AlexPn 14 1 15) 1
                   ]

    it "returns tokens for function declaration" $
      do
        alexScanTokens "function f(x: int): string = {}"
        `shouldBe` [ Function (AlexPn 0 1 1),
                     Id (AlexPn 9 1 10) "f",
                     LParen (AlexPn 10 1 11),
                     Id (AlexPn 11 1 12) "x",
                     Colon (AlexPn 12 1 13),
                     Id (AlexPn 14 1 15) "int",
                     RParen (AlexPn 17 1 18),
                     Colon (AlexPn 18 1 19),
                     Id (AlexPn 20 1 21) "string",
                     Assign (AlexPn 27 1 28),
                     LBrace (AlexPn 29 1 30),
                     RBrace (AlexPn 30 1 31)
                   ]