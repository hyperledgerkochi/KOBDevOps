#!/usr/bin/env bash

#
#   Copyright 2017 Marco Vermeulen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

function __kob_help {
	__kobman_echo_no_colour ""
	__kobman_echo_no_colour "Usage: kob <command> [candidate] [version]"
	__kobman_echo_no_colour "       kob offline <enable|disable>"
	__kobman_echo_no_colour ""
	__kobman_echo_no_colour "   commands:"
	__kobman_echo_no_colour "       install   or i    <candidate> [version] [local-path]"
	__kobman_echo_no_colour "       uninstall or rm   <candidate> <version>"
	__kobman_echo_no_colour "       list      or ls   [candidate]"
	__kobman_echo_no_colour "       use       or u    <candidate> <version>"
	__kobman_echo_no_colour "       default   or d    <candidate> [version]"
	__kobman_echo_no_colour "       current   or c    [candidate]"
	__kobman_echo_no_colour "       upgrade   or ug   [candidate]"
	__kobman_echo_no_colour "       version   or v"
	__kobman_echo_no_colour "       broadcast or b"
	__kobman_echo_no_colour "       help      or h"
	__kobman_echo_no_colour "       offline           [enable|disable]"
	__kobman_echo_no_colour "       selfupdate        [force]"
	__kobman_echo_no_colour "       update"
	__kobman_echo_no_colour "       flush             <broadcast|archives|temp>"
	__kobman_echo_no_colour ""
	__kobman_echo_no_colour "   candidate  :  the KOB to install: groovy, scala, grails, gradle, kotlin, etc."
	__kobman_echo_no_colour "                 use list command for comprehensive list of candidates"
	__kobman_echo_no_colour "                 eg: \$ kob list"
	__kobman_echo_no_colour "   version    :  where optional, defaults to latest stable if not provided"
	__kobman_echo_no_colour "                 eg: \$ kob install groovy"
	__kobman_echo_no_colour "   local-path :  optional path to an existing local installation"
	__kobman_echo_no_colour "                 eg: \$ kob install groovy 2.4.13-local /opt/groovy-2.4.13"
	__kobman_echo_no_colour ""
}
