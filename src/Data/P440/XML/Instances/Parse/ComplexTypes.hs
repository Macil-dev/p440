{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Parse.ComplexTypes where

import qualified Data.P440.Domain.SimpleTypes as S
import qualified Data.P440.Domain.ComplexTypes as C

import Control.Applicative

import Data.P440.XML.Parse

-- Сложные типы из раздела 2.18

-- Сведения о банке (филиале) БанкТип
банк name =
    complex_ name
        (C.Банк <$> (attribute "РегНом")
                <*> (attribute "НомФил")
                <*> (S.БИК <$> attribute "БИК")
                <*> (attribute "НаимБанк")
                <*> (S.ИННЮЛ <$> attribute "ИННБанк")
                <*> (S.КПП <$> attribute "КППБанк"))

-- Сведения об учреждении Банка России УБРТип
убр name =
    complex_ name
        (C.УБР <$> (S.БИК <$> attribute "БИК")
               <*> (attribute "НаимУБР")
               <*> (attribute "ИННБР")
               <*> (S.КПП <$> attribute "КППУБР"))

-- Сведения о налоговом органе СвНОТип
свНО' name =
    complex'_ name
        (C.СвНО <$> (S.ИФНС <$> attribute "КодНО")
                <*> (attribute "НаимНО"))
-- Руководитель (заместитель) НО РукНОТип
рукНО' name =
    complex' name
        (C.РукНО <$> attributeMaybe "КласЧин")
        (\рукно -> рукно <$> фио' "ФИО")

-- Представитель КО/УБР ПредБТип
предБ' name =
    complex' name
        (C.ПредБ <$> attribute "Должность")
        (\предб -> предб <$> фио' "ФИО")

-- Плательщик - организация ПлЮЛТип
плЮЛ name =
    complex_ name
        (C.ПлЮЛ <$> (S.ИННЮЛ <$> attribute "ИННЮЛ")
                <*> (S.КПП <$> attribute "КПП")
                <*> (attribute "НаимЮЛ"))

-- Плательщик - ИП/Нотариус/Адвокат ПлИПТип
плИП name =
    complex name
        (C.ПлИП <$> (S.ИННФЛ <$> attribute "ИННИП"))
        (\плип -> плип <$> фио' "ФИО")

-- Плательщик - Физ. лицо ПлФЛТип
плФЛ name =
    complex name
        (C.ПлФЛ <$> ((S.ИННФЛ <$>) <$> attributeMaybe "ИННФЛ"))
        (\плфл -> плфл <$> фио' "ФИО")

-- Плательщик - Физ. лицо (полные данные)
пфл name =
    complex name
        (C.ПФЛ <$> ((S.ИННФЛ <$>) <$> attributeMaybe "ИННФЛ")
               <*> (S.Date <$> attribute "ДатаРожд")
               <*> (attribute "МестоРожд")
               <*> (attribute "КодДУЛ")
               <*> (attribute "СерНомДок")
               <*> ((S.Date <$>) <$> attributeMaybe "ДатаДок"))
        (\пфл' -> пфл' <$> фио' "ФИО"
                       <*> адрРФ "АдрПлат")

-- ФИО ФИОТип
фио' name =
    complex'_ name
        (C.ФИО <$> attribute "Фамилия"
               <*> attribute "Имя"
               <*> attributeMaybe "Отчество")

-- Адрес в Российской Федерации АдрРФТип
адрРФ name =
    complex_ name
        (C.АдрРФ <$> attribute "Индекс"
                 <*> attribute "КодРегион"
                 <*> attributeMaybe "Район"
                 <*> attributeMaybe "Город"
                 <*> attributeMaybe "НаселПункт"
                 <*> attributeMaybe "Улица"
                 <*> attributeMaybe "Дом"
                 <*> attributeMaybe "Корпус"
                 <*> attributeMaybe "Кварт")

адрРФ' name =
    complex'_ name
        (C.АдрРФ <$> attribute "Индекс"
                 <*> attribute "КодРегион"
                 <*> attributeMaybe "Район"
                 <*> attributeMaybe "Город"
                 <*> attributeMaybe "НаселПункт"
                 <*> attributeMaybe "Улица"
                 <*> attributeMaybe "Дом"
                 <*> attributeMaybe "Корпус"
                 <*> attributeMaybe "Кварт")


