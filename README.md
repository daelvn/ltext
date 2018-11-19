# ltext
ltext is a text utils library for Lua, including various functions from [lua-users](http://lua-users.org) and some others.
## Usage
### `slow_write text, rate`
Writes each character of `text` at `1/rate`.
### `slow_print text, rate`
Similar to `slow_write` but appends a newline at the end
### `starts_with text, start`
Checks if `text` starts with `start`
### `ends_with text, ends`
Checks if `text` ends with `ends`
### `first_upper text`
Makes the first character uppercase
### `first_word_upper text`
Makes the first alphabetic character uppercase
### `first_lower text`
Makes the first character lowercase
### `first_word_lower text`
Makes the first alphabetic character lowercase
### `title_case text`
Makes the first character of all words uppercase
### `all_lower text`
Makes all characters lowercase
### `all_upper text`
Makes all characters uppercase
### `url_encode text`
URL-encodes a string
### `url_decode text`
URL-decodes a string
### `trimr text`
Removes whitespace at the end of the string
### `triml text`
Removes whitespace at the beginning of the string
### `trim text`
Removes whitespace at the beginning and end of the string
### `split text, sep=" ", max, plain`
Splits a string using separator `sep` a maximum of `max` times. If `plain` is true, then the separator will be escaped.
### `arrow text, full=true, color="blue"`
Prints `=> #{text}` in color `color` (of ansicolors), if ansicolors is not detected then it will print plainly. If `full` is set to false, only the `=>` will be colored.
### `dart text, full=true, color="cyan"` -> `->`
### `pin text, full=true, color="green"` -> `--`
### `bullet text, full=true, color="green"` -> ` *`
### `quote text, full=true, color="magenta"` -> ` >`
### `title text, full=true, color="magenta"` -> `==`
### `error text, full=true, color="red"` -> `!!`
Similar to `arrow`, but with different prefixes.
### `printf text, ...`
Equivalent to `print string.format text, ...`
### Exclusive to ansicolors
#### `set_foreground color`
Sets foreground to `color`
#### `set_background color`
Sets background to `color`
#### `printc text`
Equivalent to `print ansicolors text`
#### `printcf text, ...`
Equivalent to `print ansicolors string.format text, ...`
### Exclusive to inspect.lua
#### `printi any`
Equivalent to `print inspect any`
