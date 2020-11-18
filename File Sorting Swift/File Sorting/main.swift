import Foundation

let path = "/Users/castle/Desktop"
let sortingManager = SortingManager(for: path, sortingBy: .date)
sortingManager.sortFiles()
