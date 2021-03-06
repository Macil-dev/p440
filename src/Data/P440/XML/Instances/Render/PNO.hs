{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.PNO where

import qualified Data.P440.Domain.PNO as PNO
import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Render
import qualified Data.P440.XML.Instances.Render.ComplexTypes as C

instance ToNode PNO.Файл where
    toNode (PNO.Файл идЭС типИнф версПрог телОтпр
                     должнОтпр фамОтпр версФорм
                     порносчетн) =
        complex "Файл"
                ["ИдЭС"      =: идЭС
                ,"ТипИнф"    =: типИнф
                ,"ВерсПрог"  =: версПрог
                ,"ТелОтпр"   =: телОтпр
                ,"ДолжнОтпр" =: должнОтпр
                ,"ФамОтпр"   =: фамОтпр
                ,"ВерсФорм"  =: версФорм]
                [Sequence [порносчетн]]

instance ToNode PNO.ПОРНОСЧЕТН where
    toNode (PNO.ПОРНОСЧЕТН номПоруч датаПодп видПлат сумПлат статус
                           инннп кппнп плательщ номСчПл банкПл
                           бикбпл номСчБПл номФ банкПол бикбпол
                           номСчБПол иннпол кпппол получ номСчПол
                           видОп назПлКод очерПл кодПл резПоле
                           назнПл видПор ункгн кбк октмо кодОсн
                           срокУплТр номТреб датаТреб порВал) =
           complex "ПОРНОСЧЕТН" 
                   ["НомПоруч"  =: номПоруч
                   ,"ДатаПодп"  =: датаПодп
                   ,"ВидПлат"   =: видПлат
                   ,"СумПлат"   =: сумПлат
                   ,"Статус"    =: статус
                   ,"ИНННП"     =: инннп 
                   ,"КППНП"     =: кппнп
                   ,"Плательщ"  =: плательщ
                   ,"НомСчПл"   =: номСчПл
                   ,"БанкПл"    =: банкПл
                   ,"БИКБПл"    =: бикбпл
                   ,"НомСчБПл"  =: номСчБПл
                   ,"НомФ"      =: номФ
                   ,"БанкПол"   =: банкПол
                   ,"БИКБПол"   =: бикбпол
                   ,"НомСчБПол" =: номСчБПол
                   ,"ИННПол"    =: иннпол
                   ,"КПППол"    =: кпппол
                   ,"Получ"     =: получ
                   ,"НомСчПол"  =: номСчПол
                   ,"ВидОп"     =: видОп
                   ,"НазПлКод"  =: назПлКод
                   ,"ОчерПл"    =: очерПл
                   ,"КодПл"     =: кодПл
                   ,"РезПоле"   =: резПоле
                   ,"НазнПл"    =: назнПл
                   ,"ВидПор"    =: видПор
                   ,"УНКГН"     =: ункгн
                   ,"КБК"       =: кбк
                   ,"ОКТМО"     =: октмо
                   ,"КодОсн"    =: кодОсн
                   ,"СрокУплТр" =: срокУплТр
                   ,"НомТреб"   =: номТреб
                   ,"ДатаТреб"  =: датаТреб]
                   [Sequence порВал]

instance ToNode PNO.ПорВал where
    toNode (PNO.ПорВал номПорВал
                       датаПорВал
                       номВалСч) =
        complex_ "ПорВал"
                 ["НомПорВал"  =: номПорВал
                 ,"ДатаПорВал" =: датаПорВал
                 ,"НомВалСч"   =: номВалСч]
