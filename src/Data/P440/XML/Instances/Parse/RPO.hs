{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.RPO where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.RPO as RPO

import Control.Applicative hiding (many)

instance FromXML' RPO.Файл where
    fromXML' =
        complex' "Файл"
            (RPO.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' RPO.РЕШНОПРИОС where
     fromXML' =
         complex' "РЕШНОПРИОС"
             (RPO.РЕШНОПРИОС <$> (attribute "НомРешПр")
                             <*> (S.Date <$> attribute "ДатаПодп")
                             <*> (attribute "КодОснов")
                             <*> (attribute "Обстоят")
                             <*> (S.БИК <$> attribute "БИК")
                             <*> (attribute "НаимБ")
                             <*> (attribute "НомФ")
                             <*> (attributeMaybe "СумВзыск")
                             <*> (attributeMaybe "НомРешВзыск")
                             <*> ((S.Date <$>) <$> attributeMaybe "ДатаРешВзыск"))
             (\решеноприос -> решеноприос <$> свНО' "СвНО"
                                          <*> fromXML'
                                          <*> fromXML'
                                          <*> рукНО' "Руководитель")

instance FromXML' RPO.СвПл where
    fromXML' =
        complex' "СвПл"
            (return ())
            (\_ -> RPO.СвПл <$> fromXML'
                            <*> адрРФ' "АдрПлат")

instance FromXML' RPO.ПлЮЛИлиПлИП where
    fromXML' = choice' "ПлЮЛ | ПлИП required"
                   [(RPO.ПлЮЛ' <$>) <$> плЮЛ "ПлЮЛ"
                   ,(RPO.ПлИП' <$>) <$> плИП "ПлИП"]

instance FromXML' RPO.СчетИлиКЭСП where
    fromXML' = choice' "Счет | КЭСП required"
                   [Just . RPO.Счет' <$> many fromXML
                   ,Just . RPO.КЭСП' <$> many fromXML]

instance FromXML RPO.Счет where
    fromXML =
        complex_ "Счет"
            (RPO.Счет <$> (S.НомСч <$> attribute "НомСч")
                      <*> (attribute "ВидСч"))

instance FromXML RPO.КЭСП where
    fromXML =
        complex_ "КЭСП"
             (RPO.КЭСП <$> (attribute "ИдКЭСП")
                       <*> (attribute "ВалКЭСП"))
