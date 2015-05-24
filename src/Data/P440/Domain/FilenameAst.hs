{-#LANGUAGE DeriveDataTypeable#-}
module Data.P440.Domain.FilenameAst where

import Data.Typeable (Typeable)

import Data.Text

data Message =
    Message {messagePrefix   :: Text
            ,messageResend   :: Text
            ,messageBIC      :: Text
            ,messageTaxcode  :: Text
            ,messageFiledate :: (Text, Text, Text)
            ,messageNumber   :: Text
            } deriving (Eq, Show, Typeable)

data Reply =
    Reply {replyPrefix   :: Text
          ,replyResend   :: Text
          ,replyMessage  :: Message
          ,replyDivision :: Text
          } deriving (Eq, Show, Typeable)

data AuxReply =
    AuxReply {areplyReply :: Reply
             ,areplyAccountNum :: Text
             ,areplyFilenum    :: Text
             } deriving (Eq, Show, Typeable)

data Transport =
    Transport {transportPrefix   :: Text
              ,transportSender   :: Text
              ,transportReceiver :: Text
              ,transportFiledate :: (Text, Text, Text)
              ,transportFilenum  :: Text
              } deriving (Eq, Show, Typeable)

data TransportAck =
    TransportAck {tackPrefix       :: Text
                 ,tackReceiver     :: Text
                 ,tackAckTransport :: Transport
                 } deriving (Eq, Show, Typeable)

data FNSAck =
    FNSAck {fackPrefix   :: Text
           ,fackReceiver :: Text
           ,fackReply    :: FNSAckName
           } deriving (Eq, Show, Typeable)

data FNSAckName = Reply'  Reply
                | AuxReply' AuxReply
                | KOAck1' KOAck1
                | KOAck2' KOAck2
                deriving (Eq, Show, Typeable)

data KOAck1 =
    KOAck1 {kack1Prefix  :: Text
           ,kack1Message :: Message
           } deriving (Eq, Show, Typeable)

data KOAck2 =
    KOAck2 {kack2Prefix   :: Text
           ,kack2Message  :: Message
           ,kack2Division :: Text
           } deriving (Eq, Show, Typeable)
