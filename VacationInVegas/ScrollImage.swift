//
//  ScrollImage.swift
//  VacationInVegas
//
//  Created by Nasir on 09/10/24.
//

import SwiftUI

struct ScrollImage: View {
    let image: ImageResource
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
                .scrollTransition{content, phase in
//                    talking about the content of whatever we're scrollig and phase is like what phase of scroll is it in, top/middle/bottom
                    content.scaleEffect(phase.isIdentity ? 1:0.5)
                        .opacity(phase.isIdentity ? 1: 0.5)
                }
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .symbolEffect(.pulse)
        }
        .padding()
    }
}

#Preview {
    ScrollImage(image: .bellagio)
}
