//
//  CommandLineManager.swift
//  File Sorting
//
//  Created by Nikita Semenov on 20.11.2020.
//

import Foundation

struct CommandLineManager {
	
	let sortingWayArg: String
	let sortingPathArg: String
	
	var arrOfRawArgs: [String] {
		var arr = [String]()
		
		for way in CommandLineArgument.allCases {
			arr.append(way.rawValue)
		}
		return arr
	}
	
	init(way arg1: String, path arg2: String) {
		self.sortingWayArg = arg1
		self.sortingPathArg = arg2
	}
	
	fileprivate func determineWayOfSorting() -> CommandLineArgument? {
		
		if arrOfRawArgs.contains(sortingWayArg) {
			
			switch sortingWayArg {
				case "-n":
					return .name
					
				case "-e":
					return .ext
					
				case "-d":
					return .date
					
				case "-t":
					return .time
				
				case "-D":
					return .dateTime
					
				default:
					return .ext
					
			}
			
		} else {
			
			return nil
		}
	}
	
	func startSoring() {
		
		let wayOfSorting = determineWayOfSorting()
		
		if let way = wayOfSorting {
			let sortingManager = SortingManager(for: sortingPathArg, sortingBy: way)
			sortingManager.sortFiles()
			
		} else {
			
			print("""
INVALID WAY OF SORTING
ARG[1] WAS INCORRECT
""")
		}
	}
}
