module Data.P440.Domain.ZSN where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes
import Data.P440.Domain.ZSO

import Data.Text (Text)

-- 2.9 Запрос НО о наличии счетов

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,запноналич :: ЗАПНОНАЛИЧ
} deriving (Eq, Show)

data ЗАПНОНАЛИЧ = ЗАПНОНАЛИЧ {
     номЗапр      :: Text
    ,идЗапр       :: ИдЗапр
    ,стНКРФ       :: Text
    ,видЗапр      :: Text
    ,основЗапр    :: Text
    ,типЗапр      :: Text
    ,датаПодп     :: Date
    ,свНО         :: СвНО
    ,банкИлиУБР   :: СвБанкИлиСвУБР
    ,свПл         :: СвПл
    ,наДатуИлиВПериод  :: НаДатуИлиВПериод
    ,руководитель :: РукНО
} deriving (Eq, Show)
