module Data.P440.Domain.PNO where

import Data.P440.Domain.SimpleTypes
import Data.P440.Domain.ComplexTypes

import Data.Text (Text)

-- 2.3 Инкассовое поручение

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,порносчетн :: ПОРНОСЧЕТН
} deriving (Eq, Show)

data ПОРНОСЧЕТН = ПОРНОСЧЕТН {
     номПоруч  :: Text
    ,датаПодп  :: Date
    ,видПлат   :: Maybe Text
    ,сумПлат   :: Text
    ,статус    :: Maybe Text
    ,инннп     :: Text
    ,кппнп     :: Maybe КПП
    ,плательщ  :: Text
    ,номСчПл   :: Maybe Text
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
    ,порВал    :: Maybe ПорВал
    ,порДеп    :: Maybe ПорДеп
} deriving (Eq, Show)

data ПорВал = ПорВал {
     номПорВал  :: Text
    ,датаПорВал :: Date
    ,номВалСч   :: Text
} deriving (Eq, Show)

data ПорДеп = ПорДеп {
     номПорДеп  :: Text
    ,датаПорДеп :: Date
    ,номДеп     :: Text
    ,номДогДеп  :: Text
    ,датаДогДеп :: Date
    ,номСчНП    :: Text
    ,видСчНП    :: Text
} deriving (Eq, Show)
