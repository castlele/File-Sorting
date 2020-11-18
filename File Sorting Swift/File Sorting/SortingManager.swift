import Foundation

struct SortingManager {
	
	let sorter: DirectoryManager
	var sortingPath: String // Should become array of strings
	var sortingBy: SortingWay
	var namedTupleOfFiles: [(fullName: String, name: String, ext: String)]?
	
	// Initialization with one directory
	init(for path: String, sortingBy: SortingWay) {
		self.sorter = DirectoryManager(homePath: path)
		self.sortingPath = sorter.homePath
		self.sortingBy = sortingBy
		self.namedTupleOfFiles = sorter.splitFileName()
	}
	
	func createNameOfDir(withIndex: Int) -> String {
		
		switch self.sortingBy {
			case .name:
				return namedTupleOfFiles?[withIndex].name ?? "UNKNOWN"
				
			case .ext:
				return "\(namedTupleOfFiles?[withIndex].ext ?? "UNKNOWN")_files"
		
			case .date:
				if let dateTimeTuple = sorter.getDateTime(of: namedTupleOfFiles![withIndex].fullName) {
					return dateTimeTuple.date
				} else {
					return "UNKNOWN_DATE"
				}
			
			case .time:
				if let dateTimeTuple = sorter.getDateTime(of: namedTupleOfFiles![withIndex].fullName) {
					return dateTimeTuple.time
				} else {
					return "UNKNOWN_TIME"
				}
				
			case .dateTime:
			if let dateTimeTuple = sorter.getDateTime(of: namedTupleOfFiles![withIndex].fullName) {
				return dateTimeTuple.date + " " + dateTimeTuple.time
			} else {
				return "UNKNOWN_DATETIME"
			}
			
			default:
				return "NOTHING" // TODO: count size of files
		}
	}
	
	func sortFiles() {
		
		if let filesOfDir = namedTupleOfFiles {
			
			for fileIndex in 0...filesOfDir.count - 1 {
				
				let folderName = createNameOfDir(withIndex: fileIndex)
				let fileName = filesOfDir[fileIndex].fullName
				
				if sorter.folderExistenceCheck(forName: folderName) != nil && sorter.folderExistenceCheck(forName: folderName) == true {
					
					// Moving file to the folder
					sorter.moveFile(to: folderName, fileName: fileName)
					
				} else if sorter.folderExistenceCheck(forName: folderName) != nil && sorter.folderExistenceCheck(forName: folderName) == false {
					
					// Creating folder
					sorter.dirCreate(withName: folderName)
					
					// Moving file to the folder
					sorter.moveFile(to: folderName, fileName: fileName)
					
				}
			}
			print("EVERYTHING IS ALLRIGHT")
			
		} else {
			print("DIRECTORY IS EMPTY")
		}
	}
}
