//
//  FileSortingViewModel.swift
//  File-Sorting-App
//
//  Created by Nikita Semenov on 17.11.2020.
//

import Foundation

class FileSortingViewModel: ObservableObject {
	
	@Published var pathToSort = ""
	@Published var sortingBy = ""

	fileprivate func determineWayOfSorting() -> SortingWay {
		let sortingWay: SortingWay
		
		switch sortingBy {
			
			case "Name":
				sortingWay = .name
				
			case "Extension":
				sortingWay = .ext
				
			case "Date":
				sortingWay = .date
				
			case "Time":
				sortingWay = .time
				
			case "Date and Time":
				sortingWay = .dateTime
				
			default:
				sortingWay = .ext
		}
		
		return sortingWay
	}
	
	func startSorting() {
		let path = self.pathToSort
		let way = determineWayOfSorting()
		
		SortingManager(for: "/Users/castle/Downloads", sortingBy: way).sortFiles()
	}
}

