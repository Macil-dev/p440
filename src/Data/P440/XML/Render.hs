{-#LANGUAGE GADTs#-}
module Data.P440.XML.Render where

import Prelude hiding (sequence)

import Data.Text (Text)

import qualified Data.Map.Lazy as M

import Text.XML

class ToNode a where
    toNode :: a -> Node

instance ToNode Node where
    toNode = id

class ToSequence a where
    toSequence :: a -> [Node]

data Children where
    Sequence :: ToSequence s => s -> Children
    Single :: ToNode n => n -> Children

instance ToSequence Children where
    toSequence (Sequence s) = toSequence s
    toSequence (Single n) = [toNode n]

instance (ToNode a) => ToSequence [a] where
    toSequence = map toNode

instance (ToNode a) => ToSequence (Maybe a) where
    toSequence (Just a) = [toNode a]
    toSequence Nothing  = []

class Attribute a where
    toAttribute :: a -> Maybe Text

instance Attribute Text where
    toAttribute = Just

instance (Attribute a) => Attribute (Maybe a) where
    toAttribute (Just a) = toAttribute a
    toAttribute Nothing = Nothing

(=:) :: (Attribute a) => Name -> a -> (Name, Maybe Text)
name =: value = (name, toAttribute value)

attributes :: [(Name, Maybe Text)] -> M.Map Name Text
attributes =
    M.fromList . catMaybes'
    where
        catMaybes' ls = [(n, x) | (n, Just x) <- ls]

simple :: Name -> Text -> Node
simple name content =
    NodeElement $
        Element name M.empty [NodeContent content]

complex_ name attributes' =
    NodeElement $
        Element name (attributes attributes') []

complex :: (ToSequence c) => Name -> [(Name, Maybe Text)] -> [c] -> Node
complex name attributes' content =
    NodeElement $
        Element name (attributes attributes') (concatMap toSequence content)
