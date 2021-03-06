{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE CPP                        #-}
#if __GLASGOW_HASKELL__ >= 800
{-# OPTIONS_GHC -fno-warn-redundant-constraints #-}
#endif
{-# OPTIONS_GHC -fno-warn-dodgy-exports #-}

module Text.RE.PCRE
  (
  -- * Tutorial
  -- $tutorial

  -- * The Overloaded Match Operators
    (*=~)
  , (?=~)
  , (=~)
  , (=~~)
  -- * The Toolkit
  -- $toolkit
  , module Text.RE
  -- * The 'RE' Type
  -- $re
  , module Text.RE.PCRE.RE
  -- * The Operator Instances
  -- $instances
  , module Text.RE.PCRE.ByteString
  , module Text.RE.PCRE.ByteString.Lazy
  , module Text.RE.PCRE.Sequence
  , module Text.RE.PCRE.String

  ) where


import qualified Text.Regex.Base                          as B
import           Text.RE
import           Text.RE.Internal.AddCaptureNames
import           Text.RE.PCRE.RE
import qualified Text.Regex.PCRE                          as PCRE
import           Text.RE.PCRE.ByteString()
import           Text.RE.PCRE.ByteString.Lazy()
import           Text.RE.PCRE.Sequence()
import           Text.RE.PCRE.String()


-- | find all matches in text
(*=~) :: IsRegex RE s
      => s
      -> RE
      -> Matches s
(*=~) bs rex = addCaptureNamesToMatches (reCaptureNames rex) $ matchMany rex bs

-- | find first match in text
(?=~) :: IsRegex RE s
      => s
      -> RE
      -> Match s
(?=~) bs rex = addCaptureNamesToMatch (reCaptureNames rex) $ matchOnce rex bs

-- | the regex-base polymorphic match operator
(=~) :: ( B.RegexContext PCRE.Regex s a
        , B.RegexMaker   PCRE.Regex PCRE.CompOption PCRE.ExecOption s
        )
     => s
     -> RE
     -> a
(=~) bs rex = B.match (reRegex rex) bs

-- | the regex-base monadic, polymorphic match operator
(=~~) :: ( Monad m
         , B.RegexContext PCRE.Regex s a
         , B.RegexMaker   PCRE.Regex PCRE.CompOption PCRE.ExecOption s
         )
      => s
      -> RE
      -> m a
(=~~) bs rex = B.matchM (reRegex rex) bs

-- $tutorial
-- We have a regex tutorial at <http://tutorial.regex.uk>. These API
-- docs are mainly for reference.

-- $toolkit
--
-- Beyond the above match operators and the regular expression type
-- below, "Text.RE" contains the toolkit for replacing captures,
-- specifying options, etc.

-- $re
--
-- "Text.RE.TDFA.RE" contains the toolkit specific to the 'RE' type,
-- the type generated by the gegex compiler.

-- $instances
--
-- These modules merely provide the instances for the above regex
-- match operators at the various text types.
