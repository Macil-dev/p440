module Data.P440.Domain.BVS where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.15 Выписка по счетам: сведения о счетах (основной файл)

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,выпбноснов :: ВЫПБНОСНОВ
} deriving (Eq, Show)

data ВЫПБНОСНОВ = ВЫПБНОСНОВ {
     номВыпис     :: Text
    ,типВыпис     :: Text
    ,номЗапр      :: Text
    ,датаПодпЗР   :: Date
    ,датаПол      :: Date
    ,колДопФ      :: Text
    ,датаПодп     :: Date
    ,свНО         :: СвНО
    ,банкИлиУБР   :: СвБанкИлиСвУБР
    ,плЮЛИлиПлИПИлиПФЛ :: ПлЮЛИлиПлИПИлиПлФЛ
    ,сведения     :: Maybe Сведения
    ,отсутствуют  :: Maybe Отсутствуют
    ,предБанка    :: ПредБ
} deriving (Eq, Show)

data ПлЮЛИлиПлИПИлиПлФЛ = ПлЮЛ' ПлЮЛ
                        | ПлИП' ПлИП
                        | ПлФЛ' ПлФЛ
                       deriving (Eq, Show)

data СвБанкИлиСвУБР = СвБанк Банк
                    | СвУБР УБР
                    deriving (Eq, Show)

data НаДатуИлиВПериод = НаДату Date
                      | ВПериод Date Date
                      deriving (Eq, Show)

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

data СвСчет = СвСчет {
     порНомСчет    :: Text
    ,номСч         :: Text
    ,видСч         :: Text
    ,датаОткрСчет  :: Date
    ,датаЗакрСчет  :: Maybe Date
    ,кодВалСчет    :: Text
    ,датаНачСчет   :: Date
    ,датаКонСчет   :: Date
    ,остатНачСчет  :: Text
    ,суммаДебСчет  :: Text
    ,суммаКредСчет :: Text
    ,остатКонСчет  :: Text
    ,владСч        :: Maybe ВладСч
    ,бенефициар    :: [Бенефициар]
    ,измСч         :: [ИзмСч]
} deriving (Eq, Show)

data ИзмВкл = ИзмВкл {
     номДоИзмВклад :: Text
    ,номПоИзмВклад :: Text
    ,датаИзмВклад  :: Date
} deriving (Eq, Show)

data СвВклад = СвВклад {
     порНомВклад    :: Text
    ,номВкл         :: Text
    ,видВкл         :: Text
    ,датаОткрВклад  :: Date
    ,датаИстВклад   :: Maybe Date
    ,датаЗакрВклад  :: Maybe Date
    ,кодВалВклад    :: Text
    ,датаНачВклад   :: Date
    ,датаКонВклад   :: Date
    ,остатНачВклад  :: Text
    ,суммаДебВклад  :: Text
    ,суммаКредВклад :: Text
    ,остатКонВклад  :: Text
    ,измВкл         :: [ИзмВкл]
} deriving (Eq, Show)

data ИзмЭДС = ИзмЭДС {
     номДоИзмЭДС :: Text
    ,номПоИзмЭДС :: Text
    ,датаИзмЭДС  :: Date
} deriving (Eq, Show)

data СвЭДС = СвЭДС {
     порНомЭДС    :: Text
    ,идЭСП        :: Text
    ,датаОткрЭДС  :: Date
    ,датаЗакрЭДС  :: Maybe Date
    ,кодВалЭДС    :: Text
    ,датаНачЭДС   :: Date
    ,датаКонЭДС   :: Date
    ,остатНачЭДС  :: Text
    ,суммаДебЭДС  :: Text
    ,суммаКредЭДС :: Text
    ,остатКонЭДС  :: Text
    ,измЭДС       :: [ИзмЭДС]
} deriving (Eq, Show)

data СвСчетИлиСвВкладИлиСвЭДС = СвСчет'  [СвСчет]
                              | СвВклад' [СвВклад]
                              | СвЭДС'   [СвЭДС]
                                 deriving (Eq, Show)

data Сведения = Сведения {
     наДатуИлиВПериод :: НаДатуИлиВПериод
    ,остСчИлиОстВкладИлиОстЭДС :: СвСчетИлиСвВкладИлиСвЭДС
} deriving (Eq, Show)

data СледСчета = СледСчета {
     номСчСледСчета  :: Text
    ,владСчСледСчета :: [ВладСч]
} deriving (Eq, Show)

data ВсеСчетаИлиСледСчета = ВсеСчета' Text
                          | СледСчета' [СледСчета]
                          deriving (Eq, Show)

data Отсутствуют = Отсутствуют {
     остутствуютНаДатуИлиВПериод     :: НаДатуИлиВПериод
    ,отсутствуютВсеСчетаИлиСледСчета :: ВсеСчетаИлиСледСчета
} deriving (Eq, Show)
