module Data.P440.Domain.IZV where

import Data.P440.Domain.SimpleTypes

import Data.Text (Text)

-- 3.1 Извещение

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,извцбконтр :: ИЗВЦБКОНТР
} deriving (Eq, Show)

data ИЗВЦБКОНТР = ИЗВЦБКОНТР {
     имяФайла          :: Text
    ,кодРезПроверки    :: Text
    ,датаВремяПроверки :: DateTime
    ,пояснение         :: Text
    ,датаВремяПериода  :: Maybe DateTime
} deriving (Eq, Show)
