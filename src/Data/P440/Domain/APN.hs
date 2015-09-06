module Data.P440.Domain.APN where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.5 Решение НО о икасоовом

data Файл = Файл {
     идЭС        :: GUID
    ,типИнф      :: Text
    ,версПрог    :: Text
    ,телОтпр     :: Text
    ,должнОтпр   :: Text
    ,фамОтпр     :: Text
    ,версФорм    :: Text
    ,решенопдпор :: РЕШЕНОПДПОР
} deriving (Eq, Show)

data РЕШЕНОПДПОР = РЕШЕНОПДПОР {
     номРеш       :: Text
    ,датаПодп     :: Date
    ,банкПл       :: Text
    ,бикбПл       :: БИК
    ,инннп        :: Text
    ,кппнп        :: Maybe КПП
    ,приостПоруч  :: [ПриостПоруч]
    ,свНО         :: СвНО
    ,руководитель :: РукНО
} deriving (Eq, Show)

data ПриостПоруч = ПриостПоруч {
     номПоруч  :: Text
    ,датаПоруч :: Date
    ,видПоруч  :: Text
    ,номСчПл   :: Text
    ,видСч     :: Text
} deriving (Eq, Show)
