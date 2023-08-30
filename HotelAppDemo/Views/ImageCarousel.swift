//
//  ImageCarousel.swift
//  HotelAppDemo
//
//  Created by Vlad Vrublevsky on 30.08.2023.
//

import SwiftUI

struct ImageCarousel: View {
    var images: [Image]
    @State private var currentImageIndex = 0
    @State private var slideGesture = CGSize.zero
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        //GeometryReader { geo in
            ZStack {
                GeometryReader { geo in
                HStack(spacing: 0) {
                        ForEach(0..<images.count, id: \.self) { index in
                            images[index]
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        }
                        .offset(x: CGFloat(currentImageIndex) * -geo.size.width + dragOffset)
                        //.offset(x: slideGesture.width)
                        
                    }
                } /*
                   images[currentImageIndex]
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .offset(x: slideGesture.width) */
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .frame(width: 75, height: 17)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 5)
                        HStack {
                            ForEach(0..<images.count, id: \.self) {index in
                                Circle()
                                    .frame(width: 7)
                                    .foregroundColor(index == currentImageIndex ? .black : .gray)
                            }
                        }
                    }
                }
            }
        //}
        .frame(width: 343, height: 257)
        .cornerRadius(12)
        .gesture(
            DragGesture(minimumDistance: 50)
                .onChanged() { value in
                    slideGesture = value.translation
                    dragOffset = value.translation.width
                }
                .onEnded() { value in
                    dragOffset = 0
                    
                    if slideGesture.width < -50 {
                        withAnimation {
                            if currentImageIndex + 1 < images.count {
                                currentImageIndex += 1
                            } else {
                                currentImageIndex = 0
                            }
                        }
                        slideGesture = CGSize.zero
                        return
                    }
                    
                    if slideGesture.width > 50 {
                        withAnimation {
                            if currentImageIndex > 0 {
                                currentImageIndex -= 1
                            } else {
                                currentImageIndex = images.count - 1
                            }
                        }
                        slideGesture = CGSize.zero
                        return
                    }
                    
                    withAnimation {
                        slideGesture = CGSize.zero
                    }
                }
        )
    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        let images = [
            Image(uiImage: UIImage(named: "preview1")!),
            Image(uiImage: UIImage(named: "preview2")!),
            Image(uiImage: UIImage(named: "preview2")!) ]
        return ImageCarousel(images: images)
                    .previewLayout(PreviewLayout.fixed(width: 400, height: 300))
    }
}
