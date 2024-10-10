//
//  PlaceList.swift
//  VacationInVegas
//
//  Created by Nasir on 09/10/24.
// Nasir 6:55 on udemy of content 12

import SwiftUI
import SwiftData
import MapKit

struct PlaceList: View {
    @Query(sort: \Place.name) private var places: [Place]
    @State private var showImages:Bool = false
    @State private var searchQuery: String = ""
    @State private var filterByIntrested:Bool = false
    @Namespace var namespace
    private var predicate: Predicate<Place> {
        #Predicate<Place>{
            //            switch (searchQuery.isEmpty, filterByIntrested) {
            //            case (false, true):
            //                return $0.name.localizedStandardContains(searchQuery) && $0.interested
            //            case (false, false):
            //                return $0.name.localizedStandardContains(searchQuery)
            //            case (true, true):
            //                return $0.interested
            //            case (true, false):
            //                return true
            //                }
            
            if !searchQuery.isEmpty && filterByIntrested{
                $0.name.localizedStandardContains(searchQuery) && $0.interested
            } else if !searchQuery.isEmpty && !filterByIntrested{
                $0.name.localizedStandardContains(searchQuery)
            } else if searchQuery.isEmpty && filterByIntrested{
                $0.interested
            }
            else {
                true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List((try? places.filter(predicate)) ?? places) { place in
                NavigationLink(value: place){
                    HStack {
                        place.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 7))
                            .frame(width: 100,height: 100)
                        Text(place.name)
                        Spacer()
                        if place.interested{
                            Image(systemName: "star.fill").foregroundStyle(.yellow)
                                .padding(.trailing)
                        }
                    }
                }
                .matchedTransitionSource(id: 1, in: namespace)
                .swipeActions(edge: .leading){
                    Button(place.interested ? "Interested" : "Not Interested", systemImage: "star"){
                        place.interested.toggle()
                    }
                    .tint(place.interested ? .yellow : .gray)
                }
            }
            .navigationTitle("Places")
            .searchable(text: $searchQuery, prompt: "Find a place")
            .animation(.default, value: searchQuery)
            .navigationDestination(for: Place.self){ place in
                MapView(place: place, position: .camera(MapCamera(centerCoordinate: place.location, distance: 1000, heading: 250, pitch: 80)))
                    .navigationTransition(.zoom(sourceID: 1, in: namespace))
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Show Images", systemImage: "photo"){
                        showImages.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading)
                {
                    Button("Filter", systemImage: filterByIntrested ? "star.fill" : "star"){
                        withAnimation{
                            filterByIntrested.toggle()
                        }
                    }
                    .tint(filterByIntrested ? .yellow : .blue)
                }
            }
            .sheet(isPresented: $showImages){
                //                $showImages gives both screens access to this property
                Scrolling()
            }
        }
    }
}

#Preview {
    PlaceList()
        .modelContainer(Place.preview)
}
