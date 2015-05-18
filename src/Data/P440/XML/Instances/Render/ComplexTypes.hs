{-#LANGUAGE OverloadedStrings#-}
module Data.P440.XML.Instances.Render.ComplexTypes where

import Data.P440.XML.Render

import Data.P440.Domain.ComplexTypes

import Data.P440.XML.Instances.Render.SimpleTypes

-- Сложные типы из раздела 2.17

-- Сведения о банке (филиале) БанкТип

банк name (Банк регНом номФил бикБанк наимБанк иннБанк кппБанк) =
    complex_ name
             ["РегНом"   =: регНом
             ,"НомФил"   =: номФил
             ,"БИК"      =: бикБанк
             ,"НаимБанк" =: наимБанк
             ,"ИННБанк"  =: иннБанк
             ,"КППБанк"  =: кппБанк]

-- Сведения об учреждении Банка России УБРТип

убр name (УБР бикУБР наимУБР иннбр кппубр) =
    complex_ name
             ["БИК"     =: бикУБР
             ,"НаимУБР" =: наимУБР
             ,"ИННБР"   =: иннбр
             ,"КППУБР"  =: кппубр]

-- Сведения о налоговом органе СвНОТип

свНО name (СвНО кодНО наимНО) =
    complex_ name
             ["КодНО"  =: кодНО
             ,"НаимНО" =: наимНО]

-- Руководитель (заместитель) НО РукНОТип

рукНО name (РукНО классЧин фиоРукНО) =
    complex name
            ["КлассЧин" =: классЧин]
            [Sequence [фио "ФИО" фиоРукНО]]

-- Представитель КО/УБР

предБ name (ПредБ должностьПредБ фиоПредБ) =
    complex "ПредБ"
            ["Должность" =: должностьПредБ]
            [Sequence [фио "ФИО" фиоПредБ]]

-- Плательщик - организация ПлЮЛТип

плЮЛ name (ПлЮЛ иннЮЛ кппЮЛ наимЮЛ) =
    complex_ name
             ["ИННЮЛ"  =: иннЮЛ
             ,"КПП"    =: кппЮЛ
             ,"НаимЮЛ" =: наимЮЛ]

-- Плательщик - ИП/Нотариус/Адвокат ПлИПТип

плИП name (ПлИП иннИП фиоИП) =
    complex name
            ["ИННИП" =: иннИП]
            [(Sequence [фио "ФИО" фиоИП])]

-- Плательщик - Плательщик - физ. лицо ПлФЛТип

плФЛ name (ПлФЛ иннФЛ фиоФЛ) =
    complex name
            ["ИННИП" =: иннФЛ]
            [(Sequence [фио "ФИО" фиоФЛ])]

-- Плательщик - Плательщик - физ. лицо (полные данные) ПФЛТип

пфл name (ПФЛ иннФЛ датаРожд местоРожд кодДУЛ серНомДок датаДок фиоФЛ адрПлат) =
    complex name
            ["ИННФЛ"     =: иннФЛ
            ,"ДатаРожд"  =: датаРожд
            ,"МестоРожд" =: местоРожд
            ,"КодДУЛ"    =: кодДУЛ
            ,"СерНомДок" =: серНомДок
            ,"ДатаДок"   =: датаДок]
            [(Sequence [фио "ФИО" фиоФЛ])
            ,(Sequence $ maybe Nothing
                               (\адр -> Just $ адрРФ "АдрПлат" адр)
                               адрПлат)]

-- ФИО ФИОТип

фио name (ФИО фамилия имя отчество) =
    complex_ name
             ["Фамилия"  =: фамилия
             ,"Имя"      =: имя
             ,"Отчество" =: отчество]

-- Адрес в Российской Федерации АдрРФТип

адрРФ name (АдрРФ индекс кодРегион район город
                         населПункт улица дом корпус
                         кварт) =
        complex_ name
                 ["Индекс"     =: индекс
                 ,"КодРегион"  =: кодРегион
                 ,"Район"      =: район
                 ,"Город"      =: город
                 ,"НаселПункт" =: населПункт
                 ,"Улица"      =: улица
                 ,"Дом"        =: дом
                 ,"Корпус"     =: корпус
                 ,"Кварт"      =: кварт]
