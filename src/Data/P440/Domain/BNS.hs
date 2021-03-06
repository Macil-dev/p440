module Data.P440.Domain.BNS where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.14 Справка о наличии счетов

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,спрбнналич :: СПРБННАЛИЧ
} deriving (Eq, Show)

data СПРБННАЛИЧ = СПРБННАЛИЧ {
     номСправ     :: Text
    ,типСправ     :: Text
    ,номЗР        :: Text
    ,идЗапр       :: ИдЗапр
    ,датаПодпЗР   :: Date
    ,датаПол      :: Date
    ,датаПодп     :: Date
    ,свНО         :: СвНО
    ,банкИлиУБР   :: СвБанкИлиСвУБР
    ,плЮлИлиПлИПИлиПФЛ :: ПлЮлИлиПлИПИлиПлФЛ
    ,сведения     :: Maybe Сведения
    ,отсутствуют  :: Maybe Отсутствуют
    ,предБанка    :: ПредБ
} deriving (Eq, Show)

data ПлЮлИлиПлИПИлиПлФЛ = ПлЮЛ' ПлЮЛ
                        | ПлИП' ПлИП
                        | ПлФЛ'  ПлФЛ
                       deriving (Eq, Show)

data СвБанкИлиСвУБР = СвБанк Банк
                    | СвУБР УБР
                    deriving (Eq, Show)

data НаДатуИлиВПериод = НаДату Date
                      | ВПериод Date Date
                      deriving (Eq, Show)

data ПоВсем = ПоВсем {
     типЗапр                 :: Text
    ,остПоСост               :: Date
    ,поВсемНаДатуИлиВПериод  :: НаДатуИлиВПериод
} deriving (Eq, Show)

data ВладСч = ВладСчУказЛицо' Text
            | ВладСчИноеЛицо' ИноеЛицо
            deriving (Eq, Show)

data Бенефициар = БенефициарУказЛицо' Text
                | БенефициарИноеЛицо' ИноеЛицо
                deriving (Eq, Show)

data ИноеЛицо = ИноеЛицоПлЮЛ ПлЮЛ
              | ИноеЛицоПлИП ПлИП
              | ИноеЛицоПФЛ  ПФЛ
              deriving (Eq, Show)

data ИзмСч = ИзмСч {
     номДоИзмСчет :: Text
    ,номПоИзмСчет :: Text
    ,датаИзмСчет  :: Date
} deriving (Eq, Show)

data НалСчет = НалСч {
     номСч        :: Text
    ,видСч        :: Text
    ,датаОткрСчет :: Date
    ,датаЗакрСчет :: Maybe Date
    ,кодВалСчет   :: Text
    ,владСч       :: Maybe ВладСч
    ,бенефициар   :: [Бенефициар]
    ,измСч        :: [ИзмСч]
} deriving (Eq, Show)

data ИзмВкл = ИзмВкл {
     номДоИзмВклад :: Text
    ,номПоИзмВклад :: Text
    ,датаИзмВклад  :: Date
} deriving (Eq, Show)

data НалВклад = НалВклад {
     номВкл        :: Text
    ,видВкл        :: Text
    ,датаОткрВклад :: Date
    ,датаИстВклад  :: Maybe Date
    ,датаЗакрВклад :: Maybe Date
    ,кодВалВклад   :: Text
    ,измВкл        :: [ИзмВкл]
} deriving (Eq, Show)

data НалСчетИлиНалВклад = НалСчет' [НалСчет]
                        | НалВклад' [НалВклад]
                        deriving (Eq, Show)

data Сведения = Сведения {
     наДатуИлиВПериод   :: НаДатуИлиВПериод
    ,налСчетИлиНалВклад :: НалСчетИлиНалВклад
} deriving (Eq, Show)

data Отсутствуют = Отсутствуют {
     остутствуютНаДатуИлиВПериод :: НаДатуИлиВПериод
} deriving (Eq, Show)
