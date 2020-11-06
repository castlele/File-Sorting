#! /usr/bin/swift

import Foundation

let localFileManager = FileManager()
let sortingPath = "/Users/castle/Downloads"
let arrayOfFiles = try? localFileManager.contentsOfDirectory(atPath: sortingPath) //TODO: this also should be a part of future class

// Func checks if directory with given name exists
func dirExistenceCheck(in path: [String]?, withName name: String) -> Bool {
	path!.contains(name) ? true : false
}

/* Func moves a file to a directory
Returns true if no error occured
Returns false if catches an error */
func movingFile(to dirPath: String, file: String, fileManager: FileManager) -> Bool {
	do {
		try fileManager.moveItem(atPath: file, toPath: dirPath)
		return true
	} catch let error {
		dump(error)
		return false
	}
}

/* Func creats a directory in given path
Returns true if no error occured
Returns false if catches an error */
func dirCreate(in path: String, withName name: String, fileManager: FileManager) -> Bool {
	do {
		try fileManager.createDirectory(atPath: path + "/\(name)", withIntermediateDirectories: false, attributes: nil)
		return true
	} catch let error {
		dump(error)
		return false
	}
}

/* Function for sorting files in directory by their extension
	array: [String]? - array of every file in given path
	path: String - given path
	fileManager: FileManager */
func sortingFiles(of array: [String]?, in path: String, with fileManager: FileManager) {
	var errorCounter = 0

	for fileName in array! {
		let file = fileName.split(separator: ".") // Separating files to name and extension
		// Onli files in (name, extension) format should have their directories
		if file.count != 2 {
			continue

		} else if file.count == 2 {
			let dirName: String = file[1] + "_files"
			let dirPath = path + "/\(dirName)"
			let filePath = path + "/\(fileName)"

			if dirExistenceCheck(in: array, withName: dirName) {
				// If dir exists -> move file
				if movingFile(to: dirPath + "/\(fileName)", file: filePath, fileManager: fileManager) {
					continue
				} else {
					errorCounter += 1
					continue
				}
			// if Dir doesn't exist -> creat dir -> move file
			} else {
				if dirCreate(in: path, withName: dirName, fileManager: fileManager) {
					if movingFile(to: dirPath + "/\(fileName)", file: filePath, fileManager: fileManager) {
						continue
					} else {
						errorCounter += 1
						continue
					}
				} else {
					errorCounter += 1
					continue
				}
			}
		} else {
			errorCounter += 1
			continue
		}
	}
	print("Files were sorted, \(errorCounter) errors were occured")
}

sortingFiles(of: arrayOfFiles, in: sortingPath, with: localFileManager)
