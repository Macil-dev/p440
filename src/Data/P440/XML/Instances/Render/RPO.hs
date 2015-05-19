{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.RPO where

import qualified Data.P440.Domain.RPO as RPO
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C

instance ToNode RPO.Файл where
    toNode (RPO.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     решенприос) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм
                ]
                [Sequence [решенприос]]

instance ToNode RPO.РЕШНОПРИОСТ where
    toNode (RPO.РЕШНОПРИОСТ номРешПр датаПодп кодОснов обстоят
                            бик наимБ    номФ     сумВзыск
                            номРешВзыск датаРешВзыск свНО
                            свПл счетИлиКЭСП руководитель) =
        complex "РЕШНОПРИОСТ"
                ["НомРешПр"     =: номРешПр
                ,"ДатаПодп"     =: датаПодп
                ,"КодОснов"     =: кодОснов
                ,"Обстоят"      =: обстоят
                ,"БИК"          =: бик
                ,"НаимБ"        =: наимБ
                ,"НомФ"         =: номФ
                ,"СумВзыск"     =: сумВзыск
                ,"НомРешВзыск"  =: номРешВзыск
                ,"ДатаРешВзыск" =: датаРешВзыск]
                [Sequence [C.свНО "СвНО" свНО]
                ,Sequence [свПл]
                ,Sequence счетИлиКЭСП
                ,Sequence [C.рукНО "Руководитель" руководитель]]

instance ToNode RPO.СвПл where
    toNode (RPO.СвПл плательщик адрПлат) =
        complex "СвПл"
                []
                [Sequence [плательщик]
                ,Sequence [C.адрРФ "АдрПлат" адрПлат]]

instance ToNode RPO.ПлЮЛИлиПлИП where
    toNode (RPO.ПлЮЛ' плюл) = C.плЮЛ "ПлЮЛ" плюл
    toNode (RPO.ПлИП' плип) = C.плИП "ПлИП" плип

instance ToSequence RPO.СчетИлиКЭСП where
    toSequence (RPO.Счет' счет) = toSequence счет
    toSequence (RPO.КЭСП' кэсп) = toSequence кэсп

instance ToNode RPO.Счет where
    toNode (RPO.Счет номСч видСч) =
        complex_ "Счет"
                 [ "НомСч" =: номСч
                 , "ВидСч" =: видСч]

instance ToNode RPO.КЭСП where
    toNode (RPO.КЭСП идКЭСП валКЭСП) =
        complex_ "КЭСП"
                 [ "ИдКЭСП"  =: идКЭСП
                 , "ВалКЭСП" =: валКЭСП]
