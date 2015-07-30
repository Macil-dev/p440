{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.ZSN where

import qualified Data.P440.Domain.ZSN as ZSN
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import Data.P440.XML.Instances.Render.ZSO
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C

instance ToNode ZSN.Файл where
    toNode (ZSN.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     запноналич) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм
                ]
                [Sequence [запноналич]]

instance ToNode ZSN.ЗАПНОНАЛИЧ where
    toNode (ZSN.ЗАПНОНАЛИЧ номЗапр идЗапр стНКРФ видЗапр основЗапр
                           типЗапр датаПодп свНО свБанкИлиСвУБР свПл
                           наДатуИлиВПериод руководитель) =
        complex "ЗАПНОНАЛИЧ"
                 ["НомЗапр"   =: номЗапр
                 ,"ИдЗапр"    =: идЗапр
                 ,"СтНКРФ"    =: стНКРФ
                 ,"ВидЗапр"   =: видЗапр
                 ,"ОсновЗапр" =: основЗапр
                 ,"ТипЗапр"   =: типЗапр
                 ,"ДатаПодп"  =: датаПодп]
                 [Sequence [C.свНО "СвНО" свНО]
                 ,Sequence [свБанкИлиСвУБР]
                 ,Sequence [свПл]
                 ,Sequence [наДатуИлиВПериод]
                 ,Sequence [C.рукНО "Руководитель" руководитель]]
