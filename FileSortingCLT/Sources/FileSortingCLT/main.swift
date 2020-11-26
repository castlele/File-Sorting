#! /usr/bin/

import Foundation

func main() {
	let args = CommandLine.arguments

	// Check of amount of arguments
	if args.count < 3 && args[1] != "--help" {
		print(CommandLineMessage.invalidAmoungOfArgs.rawValue)
		
	} else if args[1] == "--help" {
		print(CommandLineMessage.helpMessage.rawValue)
	
	// Single path case
	} else if args.count == 3 {
		CommandLineManager(way: args[1], path: args[2])
			.startSoring()

	// Multiple paths case
	} else if args.count > 3 {
		let cmdLineArg = args[1]
		let pathWays = args.suffix(from: 2)
		
		for pathWay in pathWays {
			CommandLineManager(way: cmdLineArg, path: pathWay)
				.startSoring()
		}
		
	} else {
		print(CommandLineMessage.unknownError.rawValue)
	}
}

main()
