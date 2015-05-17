module Data.P440.Domain.KWT where

import Data.P440.Domain.SimpleTypes

import Data.Text (Text)

-- 3.3 Квитанция

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,квтнопринт :: КВТНОПРИНТ
} deriving (Eq, Show)

data КВТНОПРИНТ = КВТНОПРИНТ {
     имяФайла          :: Text
    ,датаВремяПроверки :: DateTime
    ,результат         :: [Результат]
} deriving (Eq, Show)

data Результат = Результат {
     кодРезПроверки :: Text
    ,пояснение      :: Maybe Text
    ,кодРекв        :: Maybe Text
    ,значРекв       :: Maybe Text
} deriving (Eq, Show)
