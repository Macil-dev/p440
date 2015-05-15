module Data.P440.Domain.ZSV where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes
import Data.P440.Domain.ZSO

import Data.Text (Text)

-- 2.10 Запрос НО выписки

data Файл = Файл {
     идЭС          :: GUID
    ,типИнф        :: Text
    ,версПрог      :: Text
    ,телОтпр       :: Text
    ,должнОтпр     :: Text
    ,фамОтпр       :: Text
    ,версФорм      :: Text
    ,запросновыпис :: ЗАПРОСНОВЫПИС
} deriving (Eq, Show)

data ЗАПРОСНОВЫПИС = ЗАПРОСНОВЫПИС {
     номЗапр      :: Text
    ,идЗапр       :: ИдЗапр
    ,стНКРФ       :: Text
    ,видЗапр      :: Text
    ,основЗапр    :: Text
    ,датаПодп     :: Date
    ,свНО         :: СвНО
    ,банкИлиУБР   :: СвБанкИлиСвУБР
    ,свПл         :: СвПл
    ,поВсемИлиПоУказанным  :: ПоВсемИлиПоУказанным
    ,руководитель :: РукНО
} deriving (Eq, Show)
