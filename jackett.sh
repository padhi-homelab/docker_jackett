#!/bin/sh

set -e

mono --debug /jackett/JackettConsole.exe --NoUpdates --DataFolder=/config
