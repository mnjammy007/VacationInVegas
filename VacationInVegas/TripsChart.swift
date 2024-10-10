//
//  ContentView.swift
//  VacationInVegas
//
//  Created by Nasir on 09/10/24.
//

import SwiftUI
import Charts

struct SmapleTripRating{
    let trip: Int
    let rating: Int
    static let ratings: [SmapleTripRating] = [
        SmapleTripRating(trip: 1, rating: 55),
        SmapleTripRating(trip: 2, rating: 27),
        SmapleTripRating(trip: 3, rating: 67),
        SmapleTripRating(trip: 4, rating: 72),
        SmapleTripRating(trip: 5, rating: 81),
    ]
}

struct TripsChart: View {
    var body: some View {
        Chart(
            SmapleTripRating.ratings,
            id: \.trip) { rating in
            BarMark(
                x: .value(
                    "Year",
                    rating.trip
                ),
                y: .value(
                    "Rating",
                    rating.rating
                )
            )
            LinePlot(
                x: "Years",
                y: "Ratings"
            ) {x in
                return x * 6 + 50
            }
            .foregroundStyle(.purple)
        }
        .chartXScale(domain: 1...5)
        .chartYScale(domain: 1...100)
        .padding()
    }
}

#Preview {
    TripsChart()
}
