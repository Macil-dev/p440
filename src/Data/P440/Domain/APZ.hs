module Data.P440.Domain.APZ where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.7 Отзыв инкассового поручения

data Файл = Файл {
     идЭС        :: GUID
    ,типИнф      :: Text
    ,версПрог    :: Text
    ,телОтпр     :: Text
    ,должнОтпр   :: Text
    ,фамОтпр     :: Text
    ,версФорм    :: Text
    ,решенотзпор :: РЕШЕНОТЗПОР
} deriving (Eq, Show)

data РЕШЕНОТЗПОР = РЕШЕНОТЗПОР {
     номРеш       :: Text
    ,датаПодп     :: Date
    ,банкПл       :: Text
    ,бикбПл       :: БИК
    ,инннп        :: Text
    ,кппнп        :: Maybe КПП
    ,сумма        :: Maybe Text
    ,отозвПоруч   :: [ОтозвПоруч]
    ,свНО         :: СвНО
    ,руководитель :: РукНО
} deriving (Eq, Show)

data ОтозвПоруч = ОтозвПоруч {
     номПоруч  :: Text
    ,датаПоруч :: Date
    ,видПоруч  :: Text
    ,номСчПл   :: Text
    ,видСч     :: Text
} deriving (Eq, Show)
