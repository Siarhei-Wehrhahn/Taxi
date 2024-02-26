//
//  SwiftUIView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

struct PickerView: View {
    @Binding var selectedNumber: Int
    
    var body: some View {
        Picker("Select a number", selection: $selectedNumber) {
            ForEach(1..<5) { number in
                Text("\(number)").tag(number)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
