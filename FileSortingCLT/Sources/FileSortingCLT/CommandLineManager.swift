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
	
	// Array with every value, provided by CommandLineArgument
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
	
	// Method chooses method of sorting by analazing argument with index 1
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
	
	// Main method, that starts sorting
	func startSoring() {
		let wayOfSorting = determineWayOfSorting()
		
		if let way = wayOfSorting {
			let sortingManager = SortingManager(for: sortingPathArg, sortingBy: way)
			
			if sortingManager.sortFiles() {
				print("\n\u{001B}[0;32m!!!        Sorting was successfully done in \(sortingPathArg)        !!!")
			} else {
				print("\n\u{001B}[0;31m!!!        Sorting was faild in \(sortingPathArg)        !!!")
			}
			
		} else {
			print(CommandLineMessage.invalidSortingMethod.rawValue)
		}
	}
}
