module Data.P440.Domain.PKO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.4 Инкассовое поручение КЭСП

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,понокэспн  :: ПОРНОКЭСПН
} deriving (Eq, Show)

data ПОРНОКЭСПН = ПОРНОКЭСПН {
     номПоруч  :: Text
    ,датаПодп  :: Date
    ,видПлат   :: Maybe Text
    ,сумПлат   :: Text
    ,статус    :: Maybe Text
    ,инннп     :: Text
    ,кппнп     :: Maybe КПП
    ,плательщ  :: Text
    ,идКЭСП    :: Maybe Text
    ,банкПл    :: Text
    ,бикбПл    :: БИК
    ,номСчБПл  :: Maybe Text
    ,номФ      :: Text
    ,банкПол   :: Text
    ,бикбПол   :: БИК
    ,номСчБПол :: Maybe Text
    ,иннПол    :: Text
    ,кппПол    :: Maybe КПП
    ,получ     :: Text
    ,номСчПол  :: Maybe Text
    ,видОп     :: Text
    ,назПлКод  :: Maybe Text
    ,очерПл    :: Text
    ,кодПл     :: Maybe Text
    ,резПоле   :: Maybe Text
    ,назнПл    :: Text
    ,видПор    :: Maybe Text
    ,ункгн     :: Maybe Text
    ,кбк       :: Text
    ,октмо     :: Text
    ,кодОсн    :: Maybe Text
    ,срокУплТр :: Maybe Text
    ,номТреб   :: Maybe Text
    ,датаТреб  :: Maybe Date
    ,типПлат   :: Text
} deriving (Eq, Show)
