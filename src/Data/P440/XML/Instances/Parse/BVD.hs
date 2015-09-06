{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.BVD where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.BVD as BVD

instance FromXML' BVD.Файл where
    fromXML' =
        complex' "Файл"
            (BVD.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' BVD.ВЫПБНДОПОЛ where
    fromXML' =
        complex' "ВЫПБНДОПОЛ"
                 (BVD.ВЫПБНДОПОЛ <$> attribute "ПорНом"
                                 <*> attribute "ПорНомДФ"
                                 <*> attribute "НомСчВклЭС")
                 (\выпбндопол -> выпбндопол <$> many fromXML)

instance FromXML BVD.Операции where
    fromXML =
        complex "Операции"
                (BVD.Операции <$> attribute "ИдБлок"
                              <*> (S.Date <$> attribute "ДатаОпер")
                              <*> (attributeMaybe "НазнПл"))
                (\операции -> операции <$> fromXML'
                                       <*> fromXML'
                                       <*> fromXML'
                                       <*> fromXML')

instance FromXML' BVD.РеквДок where
    fromXML' =
        complex' "РеквДок"
                 (BVD.РеквДок <$> attributeMaybe "ВидДок"
                              <*> attribute "НомДок"
                              <*> (S.Date <$> attribute "ДатаДок"))
                 (return)

instance FromXML' BVD.РеквБанка where
    fromXML' =
        complex' "РеквБанка"
                 (BVD.РеквБанка <$> attributeMaybe "НомКорСч"
                                <*> attribute "НаимБП"
                                <*> ((S.БИК <$>) <$> attributeMaybe "БИКБП")
                                <*> attributeMaybe "СВИФТ")
                 (return)

instance FromXML' BVD.РеквПлат where
    fromXML' =
        complex' "РеквПлат"
                 (BVD.РеквПлат <$> attribute "НаимПП"
                               <*> attributeMaybe "ИННПП"
                               <*> attributeMaybe "КПППП"
                               <*> attributeMaybe "НомСчПП")
                 (return)

instance FromXML' BVD.СуммаОпер where
    fromXML' =
        complex' "СуммаОпер"
                 (BVD.СуммаОпер <$> (attribute "Дебет")
                                <*> (attribute "Кредит"))
                 (return)

