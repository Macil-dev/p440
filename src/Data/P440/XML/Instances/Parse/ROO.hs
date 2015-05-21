{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.ROO where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes
import Data.P440.XML.Instances.Parse.RPO

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.ROO as ROO

import Control.Applicative hiding (many)

instance FromXML' ROO.Файл where
    fromXML' =
        complex' "Файл"
            (ROO.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' ROO.РЕШНООТМЕН where
     fromXML' =
         complex' "РЕШНООТМЕН"
             (ROO.РЕШНООТМЕН <$> (attribute "НомРешОт")
                             <*> (S.Date <$> attribute "ДатаПодп")
                             <*> (attribute "КодОснов")
                             <*> (attribute "ВидРеш")
                             <*> (attributeMaybe "НомРешВО")
                             <*> ((S.Date <$>) <$>attributeMaybe "ДатаРешВО")
                             <*> (attribute "НомРешПр")
                             <*> (S.Date <$> attribute "ДатаРешПр")
                             <*> (S.БИК <$> attribute "БИК")
                             <*> (attribute "НаимБ")
                             <*> (attribute "НомФ"))
             (\решноотмен -> решноотмен <$> свНО' "СвНО"
                                        <*> fromXML'
                                        <*> fromXML'
                                        <*> рукНО' "Руководитель")
