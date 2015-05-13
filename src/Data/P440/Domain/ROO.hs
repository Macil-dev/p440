module Data.P440.Domain.ROO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.P440.Domain.RPO

import Data.Text (Text)

-- 2.2 Решение об отмене приостановления

data Файл = Файл {
     идЭС        :: GUID
    ,типИнф      :: Text
    ,версПрог    :: Text
    ,телОтпр     :: Text
    ,должнОтпр   :: Text
    ,фамОтпр     :: Text
    ,версФорм    :: Text
    ,решноотмен  :: РЕШНООТМЕН
} deriving (Eq, Show)

data РЕШНООТМЕН = РЕШНООТМЕН {
     номРешОт   :: Text
    ,датаПодп   :: Date
    ,кодОснов   :: Text
    ,видРеш     :: Text
    ,номРешВО   :: Maybe Text
    ,датаРешВО  :: Maybe Date
    ,номРешПр   :: Text
    ,датаРешПр  :: Date
    ,бик        :: БИК
    ,наимБ      :: Text
    ,номФ       :: Text
    ,свНО       :: СвНО
    ,свПл       :: СвПл
    ,счетИлиКЭСП :: СчетИлиКЭСП
    ,руководитель :: РукНО
} deriving (Eq, Show)
