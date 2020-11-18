//
//  ContentView.swift
//  File-Sorting-App
//
//  Created by Nikita Semenov on 14.11.2020.
//

import SwiftUI

struct FileSortingMainView: View {
	
	@StateObject var viewModel = FileSortingViewModel()
	
    var body: some View {
		
		VStack {
			Text("File Sorting Assistant")
			
			Spacer()
			
			PathPickerView()
			
			Spacer()
			
			SortingWayView()
				.padding()
			
			Spacer()
			
			Button {
				
				viewModel.startSorting()
				
			} label: {
				Text("Sort")
			}
			
		}
		.frame(width: 400, height: 600, alignment: .center)
		.fixedSize(horizontal: false, vertical: false)
		
		
		
	}
}

struct FileSortingMainView_Previews: PreviewProvider {
    static var previews: some View {
        FileSortingMainView()
    }
}
