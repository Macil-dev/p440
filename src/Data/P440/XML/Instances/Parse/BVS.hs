{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.BVS where

import Data.P440.XML.Parse
import Data.P440.XML.Instances.Parse.ComplexTypes

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.BVS as BVS

instance FromXML' BVS.Файл where
    fromXML' =
        complex' "Файл"
            (BVS.Файл <$> (S.GUID <$> attribute "ИдЭС")
                      <*> (attribute "ТипИнф")
                      <*> (attribute "ВерсПрог")
                      <*> (attribute "ТелОтпр")
                      <*> (attribute "ДолжнОтпр")
                      <*> (attribute "ФамОтпр")
                      <*> (attribute "ВерсФорм"))
            (\файл -> файл <$> fromXML')

instance FromXML' BVS.ВЫПБНОСНОВ where
     fromXML' =
         complex' "ВЫПБНОСНОВ"
             (BVS.ВЫПБНОСНОВ <$> (attribute "НомВыпис")
                             <*> (attribute "ТипВыпис")
                             <*> (attribute "НомЗапр")
                             <*> (S.Date <$> attribute "ДатаПодпЗапр")
                             <*> (S.Date <$> attribute "ДатаПол")
                             <*> (attribute "КолДопФ")
                             <*> (S.Date <$> attribute "ДатаПодп"))
             (\выпбноснов -> выпбноснов <$> свНО' "СвНО"
                                        <*> fromXML'
                                        <*> fromXML'
                                        <*> fromXML
                                        <*> fromXML
                                        <*> предБ' "ПредБанка")

instance FromXML' BVS.ПлЮЛИлиПлИПИлиПлФЛ where
    fromXML' = choice' "ПлЮЛ | ПлИП | ПлФЛ required"
                   [(BVS.ПлЮЛ' <$>) <$> плЮЛ "ПлЮЛ"
                   ,(BVS.ПлИП' <$>) <$> плИП "ПлИП"
                   ,(BVS.ПлФЛ' <$>) <$> плФЛ "ПлФЛ"]

instance FromXML' BVS.СвБанкИлиСвУБР where
    fromXML' =
        choice' "СвБанк | СвУБР required"
                [(BVS.СвБанк <$>) <$> банк "СвБанк"
                ,(BVS.СвУБР  <$>) <$> убр "ПлИП"]

instance FromXML' BVS.НаДатуИлиВПериод where
    fromXML' =
        choice' "НаДату | ВПериод required"
                 [complex_ "НаДату"
                           (BVS.НаДату <$> (S.Date <$> attribute "ДейстПоСост"))
                 ,complex_ "ВПериод"
                           (BVS.ВПериод <$> (S.Date <$> attribute "ДатаНач")
                                        <*> (S.Date <$> attribute "ДатаКон"))]

instance FromXML BVS.ВладСч where
    fromXML =
        complex "ВладСч"
                (return ())
                (\_ ->choice' "ВладСч/УказЛицо | ВладСч/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BVS.ВладСчУказЛицо' <$> attribute "СчЛица")
                              ,(BVS.ВладСчИноеЛицо' <$>) <$> fromXML])

instance FromXML BVS.Бенефициар where
    fromXML =
        complex "Бенефициар"
                (return ())
                (\_ ->choice' "Бенефициар/УказЛицо | Бенефициар/ИноеЛицо required"
                              [complex_ "УказЛицо"
                                   (BVS.БенефициарУказЛицо' <$> attribute "СчЛица")
                              ,(BVS.БенефициарИноеЛицо' <$>) <$> fromXML])

instance FromXML BVS.ИноеЛицо where
    fromXML =
        complex "ИноеЛицо"
                (return ())
                (\_ ->  choice' "ИноеЛицо/ПлЮЛ | ИноеЛицо/ПлИП | ИноеЛицо/ПФЛ required"
                                [(BVS.ИноеЛицоПлЮЛ <$>) <$> плЮЛ "ПлЮЛ"
                                ,(BVS.ИноеЛицоПлИП <$>) <$> плИП "ПлИП"
                                ,(BVS.ИноеЛицоПФЛ  <$>) <$> пфл  "ПФЛ"])

изм name t =
    complex_ name
             (t <$> (attribute "НомДоИзм")
                <*> (attribute "НомПоИзм")
                <*> (S.Date <$> attribute "ДатаИзм"))

instance FromXML BVS.ИзмСч where
    fromXML =
        изм "ИзмСч" BVS.ИзмСч

instance FromXML BVS.СвСчет where
    fromXML =
        complex "СвСчет"
                (BVS.СвСчет <$> (attribute "ПорНом")
                            <*> (attribute "НомСч")
                            <*> (attribute "ВидСч")
                            <*> (S.Date <$> attribute "ДатаОткр")
                            <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                            <*> (attribute "КодВал")
                            <*> (S.Date <$> attribute "ДатаНач")
                            <*> (S.Date <$> attribute "ДатаКон")
                            <*> (attribute "ОстатНач")
                            <*> (attribute "СуммаДеб")
                            <*> (attribute "СуммаКред")
                            <*> (attribute "ОстатКон"))
                (\свсчет -> свсчет <$> (fromXML)
                                   <*> (many fromXML)
                                   <*> (many fromXML))
instance FromXML BVS.ИзмВкл where
    fromXML =
        изм "ИзмВкл" BVS.ИзмВкл

instance FromXML BVS.СвВклад where
    fromXML =
        complex "СвВклад"
                (BVS.СвВклад <$> (attribute "ПорНом")
                             <*> (attribute "НомВкл")
                             <*> (attribute "ВидВкл")
                             <*> (S.Date <$> attribute "ДатаОткр")
                             <*> ((S.Date <$>) <$> attributeMaybe "ДатаИст")
                             <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                             <*> (attribute "КодВал")
                             <*> (S.Date <$> attribute "ДатаНач")
                             <*> (S.Date <$> attribute "ДатаКон")
                             <*> (attribute "ОстатНач")
                             <*> (attribute "СуммаДеб")
                             <*> (attribute "СуммаКред")
                             <*> (attribute "ОстатКон"))
                (\сввклад -> сввклад <$> (many fromXML))

instance FromXML BVS.ИзмЭДС where
    fromXML =
        изм "ИзмЭДС" BVS.ИзмЭДС

instance FromXML BVS.СвЭДС where
    fromXML =
        complex "СвЭДС"
                (BVS.СвЭДС <$> (attribute "ПорНом")
                           <*> (attribute "ИдЭСП")
                           <*> (S.Date <$> attribute "ДатаОткр")
                           <*> ((S.Date <$>) <$> attributeMaybe "ДатаЗакр")
                           <*> (attribute "КодВал")
                           <*> (S.Date <$> attribute "ДатаНач")
                           <*> (S.Date <$> attribute "ДатаКон")
                           <*> (attribute "ОстатНач")
                           <*> (attribute "СуммаДеб")
                           <*> (attribute "СуммаКред")
                           <*> (attribute "ОстатКон"))
                (\свэдс -> свэдс <$> (many fromXML))

instance FromXML' BVS.СвСчетИлиСвВкладИлиСвЭДС where
    fromXML' =
        choice' "СвСчет | СвВклад | СвЭДС required"
                [(BVS.СвСчет'  <$>) <$> some fromXML
                ,(BVS.СвВклад' <$>) <$> some fromXML
                ,(BVS.СвЭДС'   <$>) <$> some fromXML]

instance FromXML BVS.Сведения where
    fromXML =
        complex "Сведения"
                (return ())
                (\_ ->  BVS.Сведения <$> fromXML'
                                     <*> fromXML')

instance FromXML BVS.СледСчета where
    fromXML =
        complex "СледСчета"
                (BVS.СледСчета <$> attribute "НомСч")
                (\следсчета -> следсчета <$> many fromXML)

instance FromXML' BVS.ВсеСчетаИлиСледСчета where
    fromXML' =
        choice' "ВсеСчета | СледСчета required"
                [complex_ "ВсеСчета"
                          (BVS.ВсеСчета' <$> attribute "ПризнОтс")
                ,(BVS.СледСчета' <$>) <$> some fromXML]

instance FromXML BVS.Отсутствуют where
    fromXML =
        complex "Отсутствуют"
                (return ())
                (\_ -> BVS.Отсутствуют <$> fromXML'
                                       <*> fromXML')
