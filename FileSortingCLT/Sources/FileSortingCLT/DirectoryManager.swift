import Foundation

struct DirectoryManager {
	let mainPath: String
	let fileManager = FileManager()
	
	// All content of the directory
	fileprivate var filesAndFoldersOfDirectory: [String]? {
		do {
			try  fileManager.contentsOfDirectory(atPath: mainPath)
			return try! fileManager.contentsOfDirectory(atPath: mainPath)
			
		} catch {
			return nil
		}
	}
	
	// Array which contains only files with no folders
	fileprivate var filesOfDirectory: [String]? {
		var arrOfFiles = [String]()
		
		if let folder = filesAndFoldersOfDirectory {
			fileManager.createFile(atPath: mainPath + "/TEMP", contents: nil)
			
			for file in folder {
				do {
					// Checking if current file contains another files
					try fileManager.contentsOfDirectory(atPath: mainPath + "/\(file)")
					
					continue
					
				} catch {
					do {
						// Checking if we can move temporary file to current file
						try fileManager.moveItem(atPath: mainPath + "/TEMP", toPath: mainPath + "/\(file)/TEMP")
						try! fileManager.moveItem(atPath: mainPath + "/\(file)/TEMP", toPath: mainPath + "/TEMP")
						
						continue
						
					} catch {
						arrOfFiles.append(file)
					}
				}
			}
			try! fileManager.removeItem(atPath: mainPath + "/TEMP")
			
		} else {
			return nil
		}
		
		return arrOfFiles
	}
	
	// Returning an array of tuples with name and extension of all files of a dir
	func splitFileName() -> [(fullName: String, name: String, ext: String)]? {
		var array: [(String, String, String)] = []
		let filesOfDir = filesOfDirectory
		
		if filesOfDir != nil {
			for fullFileName in filesOfDir! {
				
				// Checking if fullFileName isn't a folder a hidden .DS_Store folder
				if fullFileName.split(separator: ".").count != 0 && fullFileName != ".DS_Store" {
					let separatedFile = fullFileName.split(separator: ".")
					
					// Checking if file' name has dots in it
					if separatedFile.count > 2 {

						// Making full name of a file
						let fileName = separatedFile.joined(separator: ".")

						// Append file' name and extension to the array
						array.append((fullFileName, fileName, String(separatedFile.last!)))
						
					// If file's name starts with . and consist of 1 word, it skips
					} else if fullFileName.split(separator: ".").count == 1 && fullFileName.hasPrefix(".") {
						continue
						
					// If file doesn't have visible extension, it should get txt extension
					} else if fullFileName.split(separator: ".").count == 1 && !fullFileName.hasPrefix(".") {
						array.append((fullFileName, fullFileName, "txt"))
						
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
			try self.fileManager.attributesOfItem(atPath: mainPath + "/\(file)")
			
			let attributesOfFile = try! self.fileManager.attributesOfItem(atPath: mainPath + "/\(file)")
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
		
		if let _ = self.filesAndFoldersOfDirectory {
			isEmpty = false
		} else {
			isEmpty = true
		}
		
		if isEmpty {
			// Returns nil if folder is empty
			return nil
			
		} else {
			if self.filesAndFoldersOfDirectory!.contains(name) {
				// Returns true if folder exists
				return true
				
			} else {
				//  Returns false if folder doesn't exist
				return false
			}
		}
	}
	
	// Method moves file to the directory
	func moveFile(to dirName: String, fileName: String) -> Bool {
		do {
			try self.fileManager.moveItem(atPath: self.mainPath + "/\(fileName)", toPath: self.mainPath + "/\(dirName)/\(fileName)")
			// Returns true if file was moved successfully
			return true
			
		} catch {
			// Returns false if moveItem() method failed
			return false
		}
	}
	
	// Method creates a directory
	func dirCreate(withName name: String) -> Bool {
		do {
			try self.fileManager.createDirectory(atPath: self.mainPath + "/\(name)/", withIntermediateDirectories: false)
			// Returns true if folder was successfully created
			return true
			
		} catch {
			// Returns false if createDirectory() method failed
			return false
		}
	}
}
