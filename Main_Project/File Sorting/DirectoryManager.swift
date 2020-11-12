import Foundation

struct DirectoryManager {
	
	let homePath: String
	let fileManager = FileManager()
	
	var filesOfDirectory: [String]? {
		do {
			
			try  fileManager.contentsOfDirectory(atPath: homePath)
			return try! fileManager.contentsOfDirectory(atPath: homePath)
			
		} catch {
			
			return nil
		}
	}
	
	// var namedTupleOfFiles: [(fullName: String, name: String, ext: String)]? = splitFileName()
	
	// Returning an array of tuples with name and extension of all files of a dir
	func splitFileName() -> [(fullName: String, name: String, ext: String)]? {
		var array: [(String, String, String)] = []
		
		if self.filesOfDirectory != nil {
			
			for fullFileName in self.filesOfDirectory! {
				
				// Checking if fullFileName isn't a folder
				if fullFileName.split(separator: ".").count != 0 {
					
					let separatedFile = fullFileName.split(separator: ".")
					
					// Checking if file' name has dots in it
					if separatedFile.count > 2 {
						
						// Making full name of a file
						let fileName = separatedFile.joined(separator: ".")

						// Append file' name and extension to the array
						array.append((fullFileName, fileName, String(separatedFile.last!)))
						
						// If file's name starts with . and consist of 1 word, it skips
					} else if fullFileName.split(separator: ".").count == 1 {
					
						continue
						
						// If files' name has only one dot, immediately append name and extension
					} else {
						
						array.append((fullFileName, String(separatedFile[0]), String(separatedFile[1])))
						
					}
					
					// If fullFileName is a folder, continue iteration
				} else {
					
					continue
				}
			}
			return array
			
			// Method returns nil, if directory is empty
		} else {
			
			return nil
		}
	}
	
	// Method gets date and time of creation of a file
	func getDateTime(of file: String) -> (date: String, time: String)?  {
		do {
			
			try self.fileManager.attributesOfItem(atPath: homePath + "/\(file)")
			
			let attributesOfFile = try! self.fileManager.attributesOfItem(atPath: homePath + "/\(file)")
			let date = "\(attributesOfFile[FileAttributeKey.creationDate]!)"
			let dateTime = date.split(separator: " ")
			
			return (String(dateTime[0]), String(dateTime[1]))
			
		}  catch {
			
			return nil
		}
	}
	
	// Method checks if there is a file in the folder
	func folderExistenceCheck(forName name: String) -> Bool? {
		var isEmpty: Bool
		
		if let _ = self.filesOfDirectory {
			isEmpty = false
		} else {
			isEmpty = true
		}
		
		if isEmpty {
			return nil
			
		} else {
			
			if self.filesOfDirectory!.contains(name) {
				return true
				
			} else {
				
				return false
			}
		}
	}
	
	// Method moves file to the directory
	func moveFile(to dirName: String, fileName: String) {
		do {
			
			try self.fileManager.moveItem(atPath: self.homePath + "/\(fileName)", toPath: self.homePath + "/\(dirName)/\(fileName)")
			
		} catch {
			
			// Error catch realisation SOON
			// Should return false and corresponding message
			
		}
	}
	
	// Method creates a directory
	func dirCreate(withName name: String)  {
		do {
			
			try self.fileManager.createDirectory(atPath: self.homePath + "/\(name)", withIntermediateDirectories: false, attributes: nil)
			
		} catch {
			
			// Error catch realisation SOON
			// Should return false and corresponding message
			
		}
	}
}
