//
//  PathPickerView.swift
//  File-Sorting-App
//
//  Created by Nikita Semenov on 17.11.2020.
//

import SwiftUI

struct PathPickerView: View {
	
	@StateObject var viewModel = FileSortingViewModel()
	
	@State private var pathToSort = "" {
		didSet {
			viewModel.pathToSort = self.pathToSort
		}
	}
	
    var body: some View {
        
		MenuView(pathToSort: $pathToSort)
    }
}

struct MenuView: View {
	@Binding var pathToSort: String
	
	var body: some View {
		
		VStack {
			
			TextField("Enter path manually", text: $pathToSort)
			
			Menu("Choose path") {
				
				Button("Downloads folder", action: { pathToSort = "/Users/castle/Downloads" } )
				Button("Documents folder", action: { pathToSort = "/Users/castle/Documents" } )
				Button("Desktop folder", action: { pathToSort = "/Users/castle/Desktop" } )
				
			}
		}
	}
}

struct PathPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PathPickerView()
    }
}
