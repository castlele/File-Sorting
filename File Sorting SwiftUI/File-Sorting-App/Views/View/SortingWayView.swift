//
//  SortingWayView.swift
//  File-Sorting-App
//
//  Created by Nikita Semenov on 17.11.2020.
//

import SwiftUI

struct SortingWayView: View {
	
	@StateObject var viewModel = FileSortingViewModel()
	
	@State private var selectedWay = "" {
		didSet {
			viewModel.sortingBy = self.selectedWay
		}
	}

    var body: some View {
				
		RadioButtonsView(selectedWay: $selectedWay)
		
    }
}

struct RadioButtonsView: View {
	
	@Binding var selectedWay: String
	let waysArray = SortingWay.allCases
	
	var body: some View {
		
		VStack(alignment: .leading) {
			
			Text("Sort by:")
			
			
			HStack {
				
				VStack(alignment: .leading) {
					
					ForEach(waysArray, id: \.self) { wayName in
						
						Text(wayName.rawValue)
							.frame(width: 100, height: 25, alignment: .leading)
					}
				}
				
				Spacer()
				
				VStack(alignment: .trailing) {
					
					ForEach(waysArray, id: \.self) { wayName in
						
						Button {
							
							selectedWay = wayName.rawValue
							
						} label: {

							Circle().fill(self.selectedWay == wayName.rawValue ? Color(.controlAccentColor) : Color.gray)
								.frame(width: 18, height: 18)
							
						}
						.buttonStyle(BorderlessButtonStyle())
					}
				}
			}
		}
	}
}

struct SortingWayView_Previews: PreviewProvider {
    static var previews: some View {
        SortingWayView()
    }
}
