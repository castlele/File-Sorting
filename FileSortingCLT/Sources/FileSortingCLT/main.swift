#! /usr/bin/

import Foundation

let arg1 = CommandLine.arguments[1]
let arg2 = CommandLine.arguments[2]
let CLM = CommandLineManager(way: arg1, path: arg2)

CLM.startSoring()
