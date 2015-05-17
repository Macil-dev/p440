module Data.P440.Domain.BVD where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.15 Выписка по счетам: сведения по операциям на счете (дополнительный файл)

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,выпбндопол :: ВЫПБНДОПОЛ
} deriving (Eq, Show)

data ВЫПБНДОПОЛ = ВЫПБНДОПОЛ {
     порНом     :: Text
    ,порНомДФ   :: Text
    ,номСчВклЭС :: Text
    ,операции   :: [Операции]
} deriving (Eq, Show)


data Операции = Операции {
     идБлок    :: Text
    ,датаОпер  :: Date
    ,назнПл    :: Maybe Text
    ,реквДок   :: РеквДок
    ,реквБанка :: РеквБанка
    ,рекаПлат  :: РеквПлат
    ,суммаОпер :: СуммаОпер
} deriving (Eq, Show)

data РеквДок = РеквДок {
     видДок :: Maybe Text
    ,номДок :: Text
} deriving (Eq, Show)

data РеквБанка = РеквБанка {
     номКорСч :: Maybe Text
    ,наимБП   :: Text
    ,бикБП    :: Maybe БИК
    ,свифт    :: Maybe Text
} deriving (Eq, Show)

data РеквПлат = РеквПлат {
     наимПП  :: Text
    ,иннпп   :: Maybe Text
    ,кпппп   :: Maybe Text
    ,номСчПП :: Maybe Text
} deriving (Eq, Show)

data СуммаОпер = СуммаОпер {
     дебет  :: Text
    ,кредит :: Text
} deriving (Eq, Show)
