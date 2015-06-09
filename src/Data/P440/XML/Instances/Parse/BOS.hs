{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.BOS where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.BOS as BOS

import Control.Applicative hiding (some, many)

instance FromXML' BOS.Файл where
    fromXML' =
        complex' "Файл"
            (BOS.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' BOS.СПРБНООСТАТ where
     fromXML' =
         complex' "СПРБНОСТАТ"
             (BOS.СПРБНООСТАТ <$> (attribute "НомСправ")
                              <*> (attribute "ТипСправ")
                              <*> (attribute "НомЗР")
                              <*> ((S.ИдЗапр <$>) <$> attributeMaybe "ИдЗапр")
                              <*> (S.Date <$> attribute "ДатаПодпЗР")
                              <*> (S.Date <$> attribute "ДатаПол")
                              <*> (S.Date <$> attribute "ДатаПодп"))
             (\спрбностат -> спрбностат <$> свНО' "СвНО"
                                        <*> fromXML'
                                        <*> fromXML'
                                        <*> fromXML
                                        <*> fromXML
                                        <*> предБ' "ПредБанка")

instance FromXML' BOS.ПлЮлИлиПлИПИлиПФЛ where
    fromXML' = choice' "ПлЮЛ | ПлИП | ПФЛ required"
                   [(BOS.ПлЮЛ' <$>) <$> плЮЛ "ПлЮЛ"
                   ,(BOS.ПлИП' <$>) <$> плИП "ПлИП"
                   ,(BOS.ПФЛ'  <$>) <$> пфл  "ПФЛ"]

instance FromXML' BOS.СвБанкИлиСвУБР where
    fromXML' =
        choice' "СвБанк | СвУБР required"
                [(BOS.СвБанк <$>) <$> банк "СвБанк"
                ,(BOS.СвУБР  <$>) <$> убр "ПлИП"]

instance FromXML' BOS.НаДатуИлиВПериод where
    fromXML' =
        choice' "НаДату | ВПериод required"
                 [complex_ "НаДату"
                           (BOS.НаДату <$> (S.Date <$> attribute "ДейстПоСост"))
                 ,complex_ "ВПериод"
                           (BOS.ВПериод <$> (S.Date <$> attribute "ДатаНач")
                                        <*> (S.Date <$> attribute "ДатаКон"))]

instance FromXML BOS.ВладСч where
    fromXML =
        complex "ВладСч"
                (return ())
                (\_ ->choice' "ВладСч/УказЛицо | ВладСч/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BOS.ВладСчУказЛицо' <$> attribute "СчЛица")
                              ,(BOS.ВладСчИноеЛицо' <$>) <$> fromXML])

instance FromXML BOS.Бенефициар where
    fromXML =
        complex "Бенефициар"
                (return ())
                (\_ ->choice' "Бенефициар/УказЛицо | Бенефициар/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BOS.БенефициарУказЛицо' <$> attribute "СчЛица")
                              ,(BOS.БенефициарИноеЛицо' <$>) <$> fromXML])

instance FromXML BOS.ИноеЛицо where
    fromXML =
        complex "ИноеЛицо"
                (return ())
                (\_ ->  choice' "ИноеЛицо/ПлЮЛ | ИноеЛицо/ПлИП | ИноеЛицо/ПФЛ required"
                                [(BOS.ИноеЛицоПлЮЛ <$>) <$> плЮЛ "ПлЮЛ"
                                ,(BOS.ИноеЛицоПлИП <$>) <$> плИП "ПлИП"
                                ,(BOS.ИноеЛицоПФЛ  <$>) <$> пфл  "ПФЛ"])

изм name t =
    complex_ name
             (t <$> (attribute "НомДоИзм")
                <*> (attribute "НомПоИзм")
                <*> (S.Date <$> attribute "ДатаИзм"))

instance FromXML BOS.ИзмСч where
    fromXML =
        изм "ИзмСч" BOS.ИзмСч

instance FromXML BOS.ОстСчет where
    fromXML =
        complex "ОстСчет"
                (BOS.ОстСчет <$> (attribute "НомСч")
                             <*> (attribute "ВидСч")
                             <*> (S.Date <$> attribute "ДатаОткр")
                             <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                             <*> (attribute "КодВал")
                             <*> (attribute "Остаток")
                             <*> (S.Date <$> attribute "ДатаОст"))
                (\остсчет -> остсчет <$> (fromXML)
                                     <*> (many fromXML)
                                     <*> (many fromXML))

instance FromXML BOS.ИзмВкл where
    fromXML =
        изм "ИзмВкл" BOS.ИзмВкл

instance FromXML BOS.ОстВклад where
    fromXML =
        complex "ОстВклад"
                (BOS.ОстВклад <$> (attribute "НомВкл")
                              <*> (attribute "ВидВкл")
                              <*> (S.Date <$> attribute "ДатаОткр")
                              <*> ((S.Date <$>) <$> attributeMaybe "ДатаИст")
                              <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                              <*> (attribute "КодВал")
                              <*> (attribute "Остаток")
                              <*> (S.Date <$> attribute "ДатаОст"))
                (\оствклад -> оствклад <$> (many fromXML))

instance FromXML BOS.ИзмЭДС where
    fromXML =
        изм "ИзмЭДС" BOS.ИзмЭДС

instance FromXML BOS.ОстЭДС where
    fromXML =
        complex "ОстЭДС"
                (BOS.ОстЭДС <$> (attribute "ИдЭСП")
                            <*> (S.Date <$> attribute "ДатаОткр")
                            <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                            <*> (attribute "КодВал")
                            <*> (attribute "Остаток")
                            <*> (S.Date <$> attribute "ДатаОст"))
                (\остэдс -> остэдс <$> (many fromXML))

instance FromXML' BOS.ОстСчетИлиОстВкладИлиОстЭДС where
    fromXML' =
        choice' "ОстСчет | ОстВклад | ОстЭДС required"
                [(BOS.ОстСчет'  <$>) <$> some fromXML
                ,(BOS.ОстВклад' <$>) <$> some fromXML
                ,(BOS.ОстЭДС'   <$>) <$> some fromXML]

instance FromXML BOS.Сведения where
    fromXML =
        complex "Сведения"
                (return ())
                (\_ ->  BOS.Сведения <$> fromXML'
                                     <*> fromXML')

instance FromXML BOS.СледСчета where
    fromXML =
        complex "СледСчета"
                (BOS.СледСчета <$> attribute "НомСч")
                (\следсчета -> следсчета <$> fromXML)

instance FromXML' BOS.ВсеСчетаИлиСледСчета where
    fromXML' =
        choice' "ВсеСчета | СледСчета required"
                [complex_ "ВсеСчета"
                          (BOS.ВсеСчета' <$> attribute "ПризнОтс")
                ,(BOS.СледСчета' <$>) <$> some fromXML]

instance FromXML BOS.Отсутствуют where
    fromXML =
        complex "Отсутствуют"
                (return ())
                (\_ -> BOS.Отсутствуют <$> fromXML'
                                       <*> fromXML')
