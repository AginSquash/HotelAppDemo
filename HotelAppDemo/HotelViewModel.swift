//
//  HotelViewModel.swift
//  HotelAppDemo
//
//  Created by Vlad Vrublevsky on 30.08.2023.
//

import Foundation
import SwiftUI

class HotelVM: ObservableObject {
    @Published var hotelPreviewData: HotelPreviewData?
    
    init() {
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { fatalError("invalid url") }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard let data = data else {  return  }
            if let decoded = try? JSONDecoder().decode(HotelPreviewData.self, from: data) {
                DispatchQueue.main.async {
                    self.hotelPreviewData = decoded
                }
            }
        }.resume()
    }
}
