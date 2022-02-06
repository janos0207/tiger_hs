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