module Data.P440.Domain.SimpleTypes where

import Data.Text (Text)

-- Простые типы из раздела 2.17

newtype ИФНС = ИФНС Text deriving (Eq, Show)

newtype БИК = БИК Text deriving (Eq, Show)

newtype ИННЮЛ = ИННЮЛ Text deriving (Eq, Show)

newtype КПП = КПП Text deriving (Eq, Show)

newtype ИННФЛ = ИННФЛ Text deriving (Eq, Show)

newtype ИдЗапр = ИдЗапр Text deriving (Eq, Show)

newtype НомСч = НомСч Text deriving (Eq, Show)

-- Дополнительные типы
-- TODO: Переопределить на более подходящие

newtype Date = Date Text deriving (Eq, Show)

newtype Time = Time Text deriving (Eq, Show)

newtype DateTime = DateTime Text deriving (Eq, Show)

newtype GUID = GUID Text deriving (Eq, Show)
