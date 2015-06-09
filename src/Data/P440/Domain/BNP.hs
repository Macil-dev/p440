module Data.P440.Domain.BNP where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.16 Исполнение о неисполнении/частичном испонении PNO

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,сбщбннеисп :: СБЩБННЕИСП
} deriving (Eq, Show)

data СБЩБННЕИСП = СБЩБННЕИСП {
     номСообщ  :: Text
    ,номПоруч  :: Text
    ,датаПоруч :: Date
    ,кодНОБ    :: ИФНС
    ,сумПлат   :: Text
    ,инннп     :: Maybe Text
    ,кппнп     :: Maybe КПП
    ,плательщ  :: Text
    ,кодИспол  :: Text
    ,сумЧаст   :: Maybe Text
    ,допСвед   :: Maybe Text
    ,датаПодп  :: Date
    ,номСч     :: Text
    ,свБанкИлиСвУБР   :: СвБанкИлиСвУБР
    ,предБанка :: ПредБ
} deriving (Eq, Show )

data СвБанкИлиСвУБР = СвБанк Банк
                    | СвУБР УБР
                    deriving (Eq, Show)
