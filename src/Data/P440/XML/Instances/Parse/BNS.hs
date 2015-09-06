{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.BNS where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.BNS as BNS

instance FromXML' BNS.Файл where
    fromXML' =
        complex' "Файл"
            (BNS.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' BNS.СПРБННАЛИЧ where
     fromXML' =
         complex' "СПРБННАЛИЧ"
             (BNS.СПРБННАЛИЧ <$> (attribute "НомСправ")
                             <*> (attribute "ТипСправ")
                             <*> (attribute "НомЗапр")
                             <*> (S.ИдЗапр <$> attribute "ИдЗапр")
                             <*> (S.Date <$> attribute "ДатаПодпЗапр")
                             <*> (S.Date <$> attribute "ДатаПол")
                             <*> (S.Date <$> attribute "ДатаПодп"))
             (\спрбностат -> спрбностат <$> свНО' "СвНО"
                                        <*> fromXML'
                                        <*> fromXML'
                                        <*> fromXML
                                        <*> fromXML
                                        <*> предБ' "ПредБанка")

instance FromXML' BNS.ПлЮлИлиПлИПИлиПлФЛ where
    fromXML' = choice' "ПлЮЛ | ПлИП | ПлФЛ required"
                   [(BNS.ПлЮЛ' <$>) <$> плЮЛ "ПлЮЛ"
                   ,(BNS.ПлИП' <$>) <$> плИП "ПлИП"
                   ,(BNS.ПлФЛ' <$>) <$> плФЛ "ПлФЛ"]

instance FromXML' BNS.СвБанкИлиСвУБР where
    fromXML' =
        choice' "СвБанк | СвУБР required"
                [(BNS.СвБанк <$>) <$> банк "СвБанк"
                ,(BNS.СвУБР  <$>) <$> убр "ПлИП"]

instance FromXML' BNS.НаДатуИлиВПериод where
    fromXML' =
        choice' "НаДату | ВПериод required"
                 [complex_ "НаДату"
                           (BNS.НаДату <$> (S.Date <$> attribute "ДейстПоСост"))
                 ,complex_ "ВПериод"
                           (BNS.ВПериод <$> (S.Date <$> attribute "ДатаНач")
                                        <*> (S.Date <$> attribute "ДатаКон"))]
instance FromXML BNS.ВладСч where
    fromXML =
        complex "ВладСч"
                (return ())
                (\_ ->choice' "ВладСч/УказЛицо | ВладСч/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BNS.ВладСчУказЛицо' <$> attribute "СчЛица")
                              ,(BNS.ВладСчИноеЛицо' <$>) <$> fromXML])

instance FromXML BNS.Бенефициар where
    fromXML =
        complex "Бенефициар"
                (return ())
                (\_ ->choice' "Бенефициар/УказЛицо | Бенефициар/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BNS.БенефициарУказЛицо' <$> attribute "СчЛица")
                              ,(BNS.БенефициарИноеЛицо' <$>) <$> fromXML])

instance FromXML BNS.ИноеЛицо where
    fromXML =
        complex "ИноеЛицо"
                (return ())
                (\_ ->  choice' "ИноеЛицо/ПлЮЛ | ИноеЛицо/ПлИП | ИноеЛицо/ПФЛ required"
                                [(BNS.ИноеЛицоПлЮЛ <$>) <$> плЮЛ "ПлЮЛ"
                                ,(BNS.ИноеЛицоПлИП <$>) <$> плИП "ПлИП"
                                ,(BNS.ИноеЛицоПФЛ  <$>) <$> пфл  "ПФЛ"])

изм name t =
    complex_ name
             (t <$> (attribute "НомДоИзм")
                <*> (attribute "НомПоИзм")
                <*> (S.Date <$> attribute "ДатаИзм"))

instance FromXML BNS.ИзмСч where
    fromXML =
        изм "ИзмСч" BNS.ИзмСч

instance FromXML BNS.НалСчет where
    fromXML =
        complex "НалСч"
                (BNS.НалСч <$> (attribute "НомСч")
                           <*> (attribute "ВидСч")
                           <*> (S.Date <$> attribute "ДатаОткр")
                           <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                           <*> (attribute "КодВал"))
                (\налсч -> налсч <$> (fromXML)
                                 <*> (many fromXML)
                                 <*> (many fromXML))
instance FromXML BNS.ИзмВкл where
    fromXML =
        изм "ИзмВкл" BNS.ИзмВкл

instance FromXML BNS.НалВклад where
    fromXML =
        complex "НалВклад"
                (BNS.НалВклад <$> (attribute "НомВкл")
                              <*> (attribute "ВидВкл")
                              <*> (S.Date <$> attribute "ДатаОткр")
                              <*> ((S.Date <$>) <$> attributeMaybe "ДатаИст")
                              <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                              <*> (attribute "КодВал"))
                (\налвклад -> налвклад <$> (many fromXML))

instance FromXML' BNS.НалСчетИлиНалВклад where
    fromXML' =
        choice' "НалСчет | НалВклад required"
                [(BNS.НалСчет'  <$>) <$> some fromXML
                ,(BNS.НалВклад' <$>) <$> some fromXML]

instance FromXML BNS.Сведения where
    fromXML =
        complex "Сведения"
                (return ())
                (\_ ->  BNS.Сведения <$> fromXML'
                                     <*> fromXML')
instance FromXML BNS.Отсутствуют where
    fromXML =
        complex "Отсутствуют"
                (return ())
                (\_ -> BNS.Отсутствуют <$> fromXML')
