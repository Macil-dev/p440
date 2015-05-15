module Data.P440.Domain.ZSO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.8 Запрос НО об остатках

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,запноостат :: ЗАПНООСТАТ
} deriving (Eq, Show)

data ЗАПНООСТАТ = ЗАПНООСТАТ {
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

data СвПл = ПлЮЛ' ПлЮЛ
          | ПлИП' ПлИП
          | ПФЛ'  ПФЛ
          deriving (Eq, Show)

data СвБанкИлиСвУБР = СвБанк Банк
                    | СвУБР УБР
                    deriving (Eq, Show)

data НаДатуИлиВПериод = НаДату Date
                      | ВПериод Date Date
                      deriving (Eq, Show)

data ПоВсем = ПоВсем {
     типЗапр           :: Text
    ,остПоСост         :: Date
    ,наДатуИлиЗаПериод :: НаДатуИлиВПериод
} deriving (Eq, Show)

data ВладСч = УказЛицо' Text
            | ИноеЛицо' ИноеЛицо
            deriving (Eq, Show)

data ИноеЛицо = ИноеЛицоПлЮЛ ПлЮЛ
              | ИноеЛицоПлИП ПлИП
              | ИноеЛицоПФЛ  ПФЛ
              deriving (Eq, Show)

data Счет = Счет {
     номСч  :: Text
    ,владСч :: ВладСч
} deriving (Eq, Show)

data ПоВсемИлиПоУказанным = ПоВсем' ПоВсем
                          | ПоУказанным' [Счет]
                          deriving (Eq, Show)

