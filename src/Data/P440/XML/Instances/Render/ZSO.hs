{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.ZSO where

import qualified Data.P440.Domain.ZSO as ZSO
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C

instance ToNode ZSO.Файл where
    toNode (ZSO.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     запноостат) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм
                ]
                [Sequence [запноостат]]

instance ToNode ZSO.ЗАПНООСТАТ where
    toNode (ZSO.ЗАПНООСТАТ номЗапр идЗапр стНКРФ видЗапр основЗапр
                           датаПодп свНО свБанкИлиСвУБР свПл
                           поВсемИлиПоУказанным руководитель) =
        complex "ЗАПНООСТАТ"
                 ["НомЗапр"   =: номЗапр
                 ,"ИдЗапр"    =: идЗапр
                 ,"СтНКРФ"    =: стНКРФ
                 ,"ВидЗапр"   =: видЗапр
                 ,"ОсновЗапр" =: основЗапр
                 ,"ДатаПодп"  =: датаПодп]
                 [Sequence [C.свНО "СвНО" свНО]
                 ,Sequence [свБанкИлиСвУБР]
                 ,Sequence [свПл]
                 ,Sequence [поВсемИлиПоУказанным]
                 ,Sequence [C.рукНО "Руководитель" руководитель]]

instance ToNode ZSO.СвПл where
    toNode свПл =
        complex "СвПл"
                []
                [Sequence [child свПл]]
        where
            child (ZSO.ПлЮЛ' плЮЛ) = C.плЮЛ "ПлЮЛ" плЮЛ
            child (ZSO.ПлИП' плИП) = C.плИП "ПлИП" плИП
            child (ZSO.ПФЛ'  пфл)  = C.пфл  "ПФЛ"  пфл

instance ToNode ZSO.СвБанкИлиСвУБР where
    toNode (ZSO.СвБанк банк) = C.банк "СвБанк" банк
    toNode (ZSO.СвУБР  убр)  = C.убр  "СвУБР"  убр

instance ToNode ZSO.НаДатуИлиВПериод where
    toNode (ZSO.НаДату дата) =
        complex_ "НаДату"
            ["ДействПоСост" =: дата]
    toNode (ZSO.ВПериод датаНач датаКон) =
        complex_ "НаДату"
            ["ДатаНач"  =: датаНач
            ,"ДатаКон"  =: датаКон]

instance ToNode ZSO.ПоВсем where
    toNode (ZSO.ПоВсем типЗапр остПоСост наДатуИлиЗаПериод) =
        complex "ПоВсем"
                ["ТипЗапр"   =: типЗапр
                ,"ОстПоСост" =: остПоСост]
                [Sequence [toNode наДатуИлиЗаПериод]]

instance ToNode ZSO.ИноеЛицо where
    toNode (ZSO.ИноеЛицоПлЮЛ плЮЛ) = C.плЮЛ "ПлЮЛ" плЮЛ
    toNode (ZSO.ИноеЛицоПлИП плИП) = C.плИП "ПлИП" плИП
    toNode (ZSO.ИноеЛицоПФЛ  пфл)  = C.пфл  "ПФЛ"  пфл

instance ToNode ZSO.ВладСч where
    toNode (ZSO.УказЛицо' счЛица) =
        complex_ "УказЛицо"
                 ["СчЛица" =: счЛица]
    toNode (ZSO.ИноеЛицо' пл) =
        complex "ИноеЛицо"
                []
                [Sequence [пл]]

instance ToNode ZSO.Счет where
    toNode (ZSO.Счет номСч владСч) =
        complex "Счет"
                ["НомСч" =: номСч]
                [Sequence [владСч]]

instance ToNode ZSO.ПоВсемИлиПоУказанным where
    toNode (ZSO.ПоВсем' поВсем) = toNode поВсем
    toNode (ZSO.ПоУказанным' счет) =
        complex "ПоУказанным"
                []
                [Sequence счет]
