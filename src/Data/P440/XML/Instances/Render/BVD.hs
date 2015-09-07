{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.BVD where

import qualified Data.P440.Domain.BVD as BVD
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C

instance ToNode BVD.Файл where
    toNode (BVD.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     выпбндопол) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм
                ]
                [Sequence [выпбндопол]]

instance ToNode BVD.ВЫПБНДОПОЛ where
    toNode (BVD.ВЫПБНДОПОЛ порНом порНомДФ номСчВклЭС операции) =
        complex "ВЫПБНДОПОЛ"
                ["ПорНом"     =: порНом
                ,"ПорНомДФ"   =: порНомДФ
                ,"НомСчВклЭС" =: номСчВклЭС]
                [Sequence операции]

instance ToNode BVD.Операции where
    toNode (BVD.Операции идБлок датаОпер назнПл реквДок
                         реквБанка реквПлат суммаОпер) =
        complex "Операции"
                 ["ИдБлок"   =: идБлок
                 ,"ДатаОпер" =: датаОпер
                 ,"НазнПл"   =: назнПл]
                 [Sequence [реквДок]
                 ,Sequence [реквБанка]
                 ,Sequence [реквПлат]
                 ,Sequence [суммаОпер]]

instance ToNode BVD.РеквДок where
    toNode (BVD.РеквДок видДок номДок датаДок) =
       complex_ "РеквДок"
                ["ВидДок"  =: видДок
                ,"НомДок"  =: номДок
                ,"ДатаДок" =: датаДок]

instance ToNode BVD.РеквБанка where
    toNode (BVD.РеквБанка номКорСч наимБП бикБП свифт) =
        complex_ "РеквБанка"
                 ["НомКорСч" =: номКорСч
                 ,"НаимБП"   =: наимБП
                 ,"БИКБП"    =: бикБП
                 ,"СВИФТ"    =: свифт]

instance ToNode BVD.РеквПлат where
    toNode (BVD.РеквПлат наимПП иннпп кпппп номСчПП) =
        complex_ "РеквПлат"
                 ["НаимПП"  =: наимПП
                 ,"ИННПП"   =: иннпп
                 ,"КПППП"   =: кпппп
                 ,"НомСчПП" =: номСчПП]

instance ToNode BVD.СуммаОпер where
    toNode (BVD.СуммаОпер дебет кредит) =
        complex_ "СуммаОпер"
                 ["Дебет"  =: дебет
                 ,"Кредит" =: кредит]
