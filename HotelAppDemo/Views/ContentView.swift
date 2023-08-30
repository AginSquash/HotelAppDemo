//
//  ContentView.swift
//  HotelAppDemo
//
//  Created by Vlad Vrublevsky on 30.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var hotelVM = HotelVM()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Load", action: {
                print(hotelVM.hotelPreviewData)
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
