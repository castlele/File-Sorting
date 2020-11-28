//
//  File.swift
//  
//
//  Created by Nikita Semenov on 21.11.2020.
//

import Foundation

enum CommandLineMessage: String {
	case invalidAmoungOfArgs = """
	\u{001B}[0;31mERROR:
	\u{001B}[0;37mYou've written less than 3 arguments

	Usage pattern:
		$ sorting <option> <path>

	For information about usage, use:
		$ sorting --help
	"""
	
	case invalidSortingMethod = """
	\u{001B}[0;31mERROR:
	\u{001B}[0;37mYou've used invalid sorting method
	
	For information about available methods, use:
		$ sorting --help
	"""
	
	case unknownError = """
	\u{001B}[0;31mERROR:
	\u{001B}[0;37mUnknown error was occured!
	
	Check if you write everything right.
	If so, write about your problem to:
		castlelecs@gmail.com
	"""
	
	case helpMessage = """
	\u{001B}[0;37mOVERVIEW: A Swift Command-Line tool to sort files into folders
	
	USAGE: 	sorting <option> <path>
	OR:		sorting <option> <path1> <path2> ... etc
	
	OPTIONS:
		-n, --name		Sorting files by name
		-e			Sorting files by extension
		-d, --date		Sorting files by date
		-t, --time		Sorting files by time
		-D			Sorting files by date and time
		--help			Displays user manual
	"""
}
