-- ltext | 14.11.2018
-- By daelvn
-- Text management utils
local ansicolors, inspect
if not pcall ->
    ansicolors = require "ansicolors"
  ansicolors   = false
if not pcall ->
    inspect    = require "inspect"
  inspect      = false

slow_write = (text, rate) ->
  text = text and (tostring text)   or ""
  rate = rate and 1/(tonumber rate) or 1/20
  for n=1, text\len!
    os.sleep rate
    io.write text\sub n,n

slow_print = (text, rate) ->
  slow_write text, rate
  print!

starts_with = (text, start) -> (text\sub 1, start\len!) == start
ends_with   = (text, ends)  -> (text\sub -(ends\len!))  == ends

first_upper      = (text) -> text\gsub "^%l", string.upper if text
first_word_upper = (text) -> text\gsub "%a",  string.upper, 1 if text
first_lower      = (text) -> text\gsub "^%u", string.lower if text
first_word_lower = (text) -> text\gsub "%a",  string.lower, 1 if text
title_case       = (text) -> text\gsub "(%a)([%w_']*)", (first, rest) -> first\upper! .. rest\lower! if text
all_lower        = (text) -> text\gsub "%f[%a]%u+%f[%A]", string.lower if text
all_upper        = (text) -> text\gsub "%f[%a]%l+%f[%A]", string.upper if text

url_encode = (text) -> if text
  text = text\gsub "\n", "\r\n"
  text = text\gsub "([^%w %-%_%.%~])", (c) ->
    ("%%%02X")\format string.byte c
  text = text\gsub " ", "+"

url_decode = (text) -> if text
  text = text\gsub "+", " "
  text = text\gsub "%%(%x%x)", (h) ->
     return string.char tonumber h, 16
  text = text\gsub "\r\n", "\n"

trimr = (text) -> text\match "(.-)%s*$" if text
triml = (text) -> text\match "^%s*(.*)" if text
trim  = (text) -> trimr triml text if text

split = (text, sep=" ", max, plain) ->
  sep = " " if sep == ""

  parts = {}
  if text\len! > 0
    max = max or -1
    nf, ns = 1, 1
    nf, nl = text\find sep, ns, plain
    while nf and (max != 0)
      parts[nf] = text\sub ns, nf-1
      nf    += 1
      ns     = nl + 1
      nf, nl = text\find sep, ns, plain
      nm    -= 1
    parts[nf] = text\sub ns
  parts

_arrow  = (text, full=true) -> "=> #{if not full then "%{reset}" else ""}#{text}"
_dart   = (text, full=true) -> "-> #{if not full then "%{reset}" else ""}#{text}"
_pin    = (text, full=true) -> "-- #{if not full then "%{reset}" else ""}#{text}"
_bullet = (text, full=true) -> " * #{if not full then "%{reset}" else ""}#{text}"
_quote  = (text, full=true) -> " > #{if not full then "%{reset}" else ""}#{text}"
_title  = (text, full=true) -> "== #{if not full then "%{reset}" else ""}#{text}"

arrow  = (text, full=true, color="blue")    ->
  if ansicolors
    ansicolors "%{#{color}}#{_arrow text, full}"
  else
    _arrow text
dart   = (text, full=true, color="cyan")    ->
  if ansicolors
    ansicolors "%{#{color}}#{_dart text, full}"
  else
    _dart text
pin    = (text, full=true, color="green")   ->
  if ansicolors
    ansicolors "%{#{color}}#{_pin text, full}"
  else
    _pin text
bullet = (text, full=true, color="green")   ->
  if ansicolors
    ansicolors "%{#{color}}#{_bullet text, full}"
  else
    _bullet text
quote  = (text, full=true, color="magenta") ->
  if ansicolors
    ansicolors "%{#{color}}#{_quote text, full}"
  else
    _quote text
title  = (text, full=true, color="magenta") ->
  if ansicolors
    ansicolors "%{#{color}}#{_title text, full}"
  else
    _title text

printf = (text, ...) -> print string.format text, ...

local set_foreground, set_background, printc, printcf
if ansicolors
  set_foreground = (color) -> ansicolors.noReset "%{#{color}}"
  set_background = (color) -> ansicolors.noReset "%{#{color}bg}"

  printc  = (text)      -> print ansicolors text
  printcf = (text, ...) -> print ansicolors string.format text, ...

local printi
if inspect
  printi  = (any) -> print inspect any

{
  :slow_write, :slow_print
  :starts_with, :ends_with
  :first_upper, :first_word_upper, :first_lower, :first_word_lower
  :all_upper, :all_lower, :title_case
  :url_encode, :url_decode
  :trimr, :triml, :trim
  :split
  :arrow, :dart, :pin, :bullet, :quote, :title
  :printf

  :set_foreground, :set_background
  :printc, :printcf

  :printi
}
