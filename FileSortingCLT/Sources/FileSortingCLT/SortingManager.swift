import Foundation

struct SortingManager {
	
	let sorter: DirectoryManager
	var sortingPath: String
	var sortingMethod: CommandLineArgument
	var namedTupleOfFiles: [(fullName: String, name: String, ext: String)]?
	
	init(for path: String, sortingBy: CommandLineArgument) {
		self.sorter = DirectoryManager(mainPath: path)
		self.sortingPath = sorter.mainPath
		self.sortingMethod = sortingBy
		self.namedTupleOfFiles = sorter.splitFileName()
	}
	
	// Method creates names for directories depending on sortingMethod
	fileprivate func createNameOfDir(withIndex: Int) -> String {
		switch self.sortingMethod {
			case .name:
				return namedTupleOfFiles?[withIndex].name ?? "UNKNOWN"
				
			case .ext:
				return "\(namedTupleOfFiles?[withIndex].ext ?? "UNKNOWN")_files"
		
			case .date:
				if let dateTimeTuple = sorter.getDateTime(of:
															namedTupleOfFiles![withIndex].fullName) {
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
				return "UNKNOWN"
		}
	}
	
	// Method sorts files in sortingPath by sortingMethod
	func sortFiles() -> Bool {
		if let filesOfDir = namedTupleOfFiles {
			if !filesOfDir.isEmpty {
				
				for fileIndex in 0...filesOfDir.count - 1 {
					let folderName = createNameOfDir(withIndex: fileIndex)
					let fileName = filesOfDir[fileIndex].fullName
					
					// Checking if folders with required name is existing
					if sorter.folderExistenceCheck(forName: folderName) != nil && sorter.folderExistenceCheck(forName: folderName) == true {
						
						// Moving file to the folder
						if sorter.moveFile(to: folderName, fileName: fileName) {
							print("LOG: Successfully moved the file \(fileName) to \(folderName)")
							continue
							
						} else {
							print("LOG: Fail of moving the file \(fileName) to \(folderName)")
						}
						
					} else if sorter.folderExistenceCheck(forName: folderName) != nil && sorter.folderExistenceCheck(forName: folderName) == false {
						
						// Creating folder
						if sorter.dirCreate(withName: folderName) {
							print("LOG: Successfully created the directory with name: \(folderName)")
							
						} else {
							print("LOG: Fail of creating the directory with name: \(folderName)")
						}
						
						// Moving file to the folder
						if sorter.moveFile(to: folderName, fileName: fileName) {
							print("LOG: Successfully moved the file \(fileName) to \(folderName)")
							continue
							
						} else {
							print("LOG: Fail of moving the file \(fileName) to \(folderName)")
						}
					}
				}
				// Returns true if sorting was successfully done
				return true
				
			} else {
				// Returns false if folder of sorting is empty
				return false
			}
			
		} else {
			// Returns false if folder of sorting is empty
			return false
		}
	}
}
