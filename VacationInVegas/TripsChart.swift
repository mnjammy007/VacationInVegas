//
//  ContentView.swift
//  VacationInVegas
//
//  Created by Nasir on 09/10/24.
//

import SwiftUI
import Charts

struct TripsChart{
    let place: String
    let rating: Int
    static let ratings: [SmapleRating] = [
        SmapleRating(place: "Bellagio", rating: 88),
        SmapleRating(place: "Paris", rating: 75),
        SmapleRating(place: "Treasure Island", rating: 33),
        SmapleRating(place: "Excalibur", rating: 99)
    ]
}

struct VegasChart: View {
    var body: some View {
        Chart(SmapleRating.ratings, id: \.place){rating in
            SectorMark(angle: .value("Ratings", rating.rating), innerRadius: .ratio(0.5), angularInset: 1)
                .cornerRadius(7)
                .foregroundStyle(by:.value("Place", rating.place))
        }
        .padding()
        .frame(height: 500)
    }
}

#Preview {
    TripsChart()
}
