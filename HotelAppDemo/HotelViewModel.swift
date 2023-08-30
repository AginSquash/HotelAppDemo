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
    @Published var images: [Image] = []
    
    init() {
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { fatalError("invalid url") }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard let data = data else {  return  }
            if let decoded = try? JSONDecoder().decode(HotelPreviewData.self, from: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.hotelPreviewData = decoded
                    self?.loadImages()
                }
            }
        }.resume()
    }
    
    func loadImages() {
        guard let imageUrls = hotelPreviewData?.image_urls else { return }
        
        for imageUrl in imageUrls {
            URLSession.shared.dataTask(with: URLRequest(url: imageUrl)) { data, responce, error in
                guard let data = data else {  return  }
                guard let uiimage = UIImage(data: data) else { return }
                let image = Image(uiImage: uiimage)
                DispatchQueue.main.async { [weak self] in
                    self?.images.append(image)
                    print("loaded: \(imageUrl)")
                }
            }.resume()
        }
    }
}
