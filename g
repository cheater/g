#!/bin/bash
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#    INSTALLATION
#
#    To install g, just copy it
#    somewhere, e.g. like this:
#    sudo cp g /usr/local/lib/g
#    Next, make sure you source
#    it inside /etc/bash.bashrc
#    or ~/.bashrc (/etc/profile
#    won't work here, however):
#    echo "source /usr/local/"\
#    "lib/g" >>/etc/bash.bashrc
#
#
#    CONFIGURATION
#
#    When you type `g foo', g will search for the directive in ~/.g or
#    in /etc/g. It will stop looking on the first occurence. The files
#    contain the directive definitions, one per line. Each line begins
#    with the directive name, then there is a space, and then the bash
#    command to be executed with arguments. It's fairly simple really.
#
#
#    EXAMPLE
#
#    Put the following in ~/.g:
#    hello echo "Hello, world!"
#    Type `g hello' to test it.
#
#
#    NAME
#
#    The name `g' is short for `go' -- the optimization reduces typing of
#    the command name by one half, increasing productivity exponentially!
#
#
#    AUTHOR
#
#    g has been created by cheater00 at gmail in 2011. It always annoyed
#    me having to type in long paths and complicated commands again, and
#    again, and again -- so here's a solution. I hope you will enjoy it!


function _g {
    if ! [ -f "$1" ]; then
        return 1
        fi
    while IFS=" " read -a line; do
        if [ "${line[0]}" = "$2" ]; then
            "${line[@]:1}"
            return 0
            fi
        done < $1
        return 1
    }

function _g_unknown {
    err="g: Unknown directive"
    if [ "$1" ]; then
        echo $err": \`$1'" >& 2
        return
        fi
    echo $err"." >& 2
    }

function g {
    if [ "$1" ]; then
        _g ~/.g "$1" || _g /etc/g "$1"
        if [ 0 -lt "$?" ]; then
            _g_unknown "$1"
            return 1
            fi
        fi
    }
