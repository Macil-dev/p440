module Data.P440.Domain.PPD where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.3 Поручение на перечисление средств с
-- депозитного счета

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,порнопердс :: ПОРНОПРЕДС
} deriving (Eq, Show)

data ПОРНОПРЕДС = ПОРНОПРЕДС {
     номПорДеп  :: Text
    ,датаПорДеп :: Date
    ,банкПл     :: Text
    ,бикБПл     :: БИК
    ,номФ       :: Text
    ,инннп      :: Text
    ,кппнп      :: Maybe КПП
    ,плательщ   :: Text
    ,номСчДеп   :: Text
    ,номДогДеп  :: Text
    ,датаДогДеп :: Date
    ,банкПол    :: Text
    ,бикБПол    :: БИК
    ,иннПол     :: Text
    ,кппПол     :: Maybe КПП
    ,получ      :: Text
    ,номСчПол   :: Text
    ,видСчПол   :: Text
    ,номПоруч   :: Text
    ,датаПодп   :: Text
} deriving (Eq, Show)
