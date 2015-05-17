module Data.P440.Domain.PB where

import Data.P440.Domain.SimpleTypes

import Data.Text (Text)

-- 3.2 Подтверждение

data Файл = Файл {
     идЭС       :: GUID
    ,типИнф     :: Text
    ,версПрог   :: Text
    ,телОтпр    :: Text
    ,должнОтпр  :: Text
    ,фамОтпр    :: Text
    ,версФорм   :: Text
    ,подбнпринт :: ПОДБНПРИНТ
} deriving (Eq, Show)

data ПОДБНПРИНТ = ПОДБНПРИНТ {
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
