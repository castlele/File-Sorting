#! /usr/bin/

import Foundation

func main() {
	let args = CommandLine.arguments

	if args.count < 3 && args[1] != "--help" {
		print("") // ERROR
		
	} else if args[1] == "--help" {
		print("") // SHOWING HELP MESSAGE
	
	} else if args.count == 3 {
		CommandLineManager(way: args[1], path: args[2])
			.startSoring()

	} else if args.count > 3 {
		let cmdLineArg = args[1]
		let pathWays = args.suffix(from: 2)
		
		for pathWay in pathWays {
			CommandLineManager(way: cmdLineArg, path: pathWay)
				.startSoring()
		}
		
	} else {
		print() // ERROR
	}
}

main()
