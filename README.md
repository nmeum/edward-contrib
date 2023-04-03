# About

This repositories demonstrates the addition of new commands to the [edward][edward github] text editor.
The editor provides a Scheme [library interface][edward doc] through which new commands can be added.
Using this library interface, the following commands have been implemented in this repository:

1. A [ctags][ctags web] command which set the current address to a given tag.
2. An [fzf][fzf github] command for changing the current file.
3. A pipe command for filtering text using shell commands.
4. A scroll command which is provided by many BSD ed(1) implementations.

## Demonstration

![Recording of a terminal session which demonstrates the usage of an enhanced version of the Unix text editor ed(1). The editor is used to display the contents of a Scheme source code file. Within this editor session, a "z" (scroll), "T" (ctags), and "F" (fzf) command is used to navigate the source code.](https://gist.github.com/nmeum/3773eb8fb280d469e67711c5635416f6/raw/dc3afaed32bef4deec90cd18255ba9203c8ac155/edward-contrib.gif)

## Installation

Refer to the [edward installation instructions][edward install].

## License

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see <https://www.gnu.org/licenses/>.

[edward github]: https://github.com/nmeum/edward
[edward doc]: https://files.8pit.net/edward/doc
[fzf github]: https://github.com/junegunn/fzf
[ctags web]: https://ctags.io/
[edward install]: https://github.com/nmeum/edward#installation
