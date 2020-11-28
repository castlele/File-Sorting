//
//  CommandLineManager.swift
//  File Sorting
//
//  Created by Nikita Semenov on 20.11.2020.
//

import Foundation

struct CommandLineManager {
	let sortingWayArg: CommandLineArgument?
	let sortingPathArg: String
	
	init(way arg1: String, path arg2: String) {
		self.sortingWayArg = CommandLineArgument(argument: arg1)
		self.sortingPathArg = arg2
	}
	
	// Method chooses method of sorting by analyzing argument with index 1
	fileprivate func determineWayOfSorting() -> CommandLineArgument? {
		if let wayOfSorting = self.sortingWayArg {
			return wayOfSorting

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
