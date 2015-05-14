module Data.P440.Domain.APO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.6 Отмена решения о инкассовом

data Файл = Файл {
     идЭС        :: GUID
    ,типИнф      :: Text
    ,версПрог    :: Text
    ,телОтпр     :: Text
    ,должнОтпр   :: Text
    ,фамОтпр     :: Text
    ,версФорм    :: Text
    ,решеноотпор :: РЕШЕНООТПОР
} deriving (Eq, Show)

data РЕШЕНООТПОР = РЕШЕНООТПОР {
     номРеш       :: Text
    ,датаПодп     :: Date
    ,банкПл       :: Text
    ,бикбПл       :: БИК
    ,инннп        :: Text
    ,кппнп        :: Maybe КПП
    ,номОтмРеш    :: Text
    ,датаОтмРеш   :: Date
    ,возобнПоруч  :: [ВозобнПоруч]
    ,счета        :: [Счет]
    ,свНО         :: СвНО
    ,руководитель :: РукНО
} deriving (Eq, Show)

data ВозобнПоруч = ВозобнПоруч {
     номПоруч  :: Text
    ,датаПоруч :: Date
    ,видПоруч  :: Text
} deriving (Eq, Show)

data Счет = Счет {
     номСчПл :: Text
    ,видСч   :: Text
} deriving (Eq, Show)
