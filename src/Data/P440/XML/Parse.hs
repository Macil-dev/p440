{-#LANGUAGE RankNTypes#-}
{-#LANGUAGE ImpredicativeTypes#-}
module Data.P440.XML.Parse where

import Text.XML.Stream.Parse

import Control.Monad.Catch
import Control.Applicative

import Data.Text (Text)
import qualified Data.Text as T

import Data.Conduit

import Data.XML.Types (Name(..), Event(..))

type Parser a = (MonadThrow m) => Consumer Event m (Maybe a)
type Parser' a = (MonadThrow m) => Consumer Event m a

class FromXML a where
    fromXML :: Parser a

class FromXML' a where
    fromXML' :: Parser' a

--runParser :: (MonadThrow m) => Parser a -> Text -> m a
runParser p t =
    yield t $$ parseText' def =$= p

many :: (MonadThrow m)
     => Consumer Event m (Maybe a)
     -> Consumer Event m [a]
many = Text.XML.Stream.Parse.many

some :: (MonadThrow m)
     => Consumer Event m (Maybe a)
     -> Consumer Event m (Maybe [a])
some p = f <$> p
           <*> Data.P440.XML.Parse.many p
    where
        f Nothing _   = Nothing
        f (Just s) ss = Just (s:ss)
--some p = do
--    res <- p
--    case res of
--         Nothing -> return Nothing
--         Just s  -> do ss <- Data.P440.XML.Parse.many p
--                       return $ Just (s:ss)

choice :: (MonadThrow m)
       => [Consumer Event m (Maybe a)]
       -> Consumer Event m (Maybe a)
choice = choose       

choice' :: (MonadThrow m)
       => String
       -> [Consumer Event m (Maybe a)]
       -> Consumer Event m a
choice' msg ps = force msg $ choose ps

simple :: Name -> Parser Text
simple name =
    tagNoAttr name content

simple' :: Name -> Parser' Text
simple' name =
    force ((T.unpack $ nameLocalName name) ++ " expected") $
        tagNoAttr name content

complex_ :: Name -> AttrParser a -> Parser a
complex_ name p = tagName name p return

complex'_ :: Name -> AttrParser a -> Parser' a
complex'_ name p =
    force ((T.unpack $ nameLocalName name) ++ " expected") $
        tagName name p return

complex :: (MonadThrow m) => Name -> AttrParser a -> (a -> ConduitM Event o m b) -> ConduitM Event o m (Maybe b)
complex = tagName

complex' :: (MonadThrow m) => Name -> AttrParser a ->
                (a -> ConduitM Event o m b) -> ConduitM Event o m b
complex' name attrParser f =
    force ((T.unpack $ nameLocalName name) ++ " expected") $
        tagName name attrParser f

attribute :: Name -> AttrParser Text
attribute = requireAttr

attributeMaybe :: Name -> AttrParser (Maybe Text)
attributeMaybe = optionalAttr
