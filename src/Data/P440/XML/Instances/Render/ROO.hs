{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.ROO where

import qualified Data.P440.Domain.ROO as ROO
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C
import qualified Data.P440.XML.Instances.Render.RPO

instance ToNode ROO.Файл where
    toNode (ROO.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     решноотмен) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм
                ]
                [Sequence [решноотмен]]

instance ToNode ROO.РЕШНООТМЕН where
    toNode (ROO.РЕШНООТМЕН номРешОт датаПодп кодОснов видРеш номРешВО
                           датаРешВО номРешПр датаРешПр бик
                           наимБ номФ свНО свПл
                           счетИлиКЭСП руководитель) =
        complex "РЕШНООТМЕН"
                ["НомРешОт"  =: номРешОт
                ,"ДатаПодп"  =: датаПодп
                ,"КодОснов"  =: кодОснов
                ,"ВидРеш"    =: видРеш
                ,"НомРешВО"  =: номРешВО
                ,"ДатаРешВО" =: датаРешВО
                ,"НомРешПр"  =: номРешПр
                ,"ДатаРешПр" =: датаРешПр
                ,"БИК"       =: бик
                ,"НаимБ"     =: наимБ
                ,"НомФ"      =: номФ]
                [Sequence [C.свНО "СвНО" свНО]
                ,Sequence [свПл]
                ,Sequence счетИлиКЭСП
                ,Sequence [C.рукНО "Руководитель" руководитель]]
