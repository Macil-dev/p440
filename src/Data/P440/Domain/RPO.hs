module Data.P440.Domain.RPO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.1 Решение о приостановлении

data Файл = Файл {
     идЭС        :: GUID
    ,типИнф      :: Text
    ,версПрог    :: Text
    ,телОтпр     :: Text
    ,должнОтпр   :: Text
    ,фамОтпр     :: Text
    ,версФорм    :: Text
    ,решноприос :: РЕШНОПРИОС
} deriving (Eq, Show)

data РЕШНОПРИОС = РЕШНОПРИОС {
     номРешПр :: Text
    ,датаПодп :: Date
    ,кодОснов :: Text
    ,обстоят  :: Text
    ,бик      :: БИК
    ,наимБ    :: Text
    ,номФ     :: Text
    ,сумВзыск :: Maybe Text
    ,номРешВзыск  :: Maybe Text
    ,датаРешВзыск :: Maybe Date
    ,свНО         :: СвНО
    ,свПл         :: СвПл
    ,счетИлиКЭСП  :: СчетИлиКЭСП
    ,руководитель :: РукНО
} deriving (Eq, Show)

data СвПл = СвПл {
     плательщик :: ПлЮЛИлиПлИП
    ,адрПлат    :: АдрРФ
} deriving (Eq, Show)

data ПлЮЛИлиПлИП = ПлЮЛ' ПлЮЛ
                 | ПлИП' ПлИП
                 deriving (Eq, Show)

data СчетИлиКЭСП = Счет' [Счет]
                 | КЭСП' [КЭСП]
                 deriving (Eq, Show)

data Счет = Счет {
     номСч :: НомСч
    ,видСч :: Text
} deriving (Eq, Show)

data КЭСП = КЭСП {
     идКЭСП  :: Text
    ,валКЭСП :: Text
} deriving (Eq, Show)
