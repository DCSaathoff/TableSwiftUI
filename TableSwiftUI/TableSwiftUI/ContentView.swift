//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Saathoff, Desarae C on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Paws N Go", neighborhood: "On Campus", desc: "This location is a small store in the middle of central campus, only a 3-5 minute walk from almost any building on the lower half of campus. It also provides students with a variety of snacks and drinks to hydrate them.", lat: 29.888670034063338, long: -97.94132618952085, imageName: "pawsngo"),
    Item(name: "Taylor Murphy, Lounge Area", neighborhood: "On Campus", desc: "This location is one of the most peaceful outdoor spaces on campus. Due to the area, it is in most students don't know it, and that results in only history majors populating the area and a less busy crowd compared to the Library.", lat: 29.889428316860062, long: -97.94142525576362, imageName: "taylormurphy"),
    Item(name: "Centenial, Computer Lab", neighborhood: "On Campus", desc: "This location is students' dream with both Mac and Windows computers at their fingertips. They are open for anyone to use and are a great space to work on group projects together or print PowerPoint before your next class.", lat: 29.889725433994098, long: -97.94008669274625, imageName: "commlab"),
    Item(name: "LBJ, Starbucks", neighborhood: "On Campus", desc: "This location is good because it is in an area that most students pass through. Because of that, it is also on the lower levels of the building next to other restaurants, providing food and hydration.", lat: 29.889023309303575, long: -97.94310038948146, imageName: "lbjstarbucks"),
    Item(name: "Old Main, Computer Lab", neighborhood: "On Campus", desc: "This location is an amazing resource for Mass Comm students. With it being a rather private and hidden area, DMI majors tend to know of its existence resulting in it mostly having space to work on your newest project. ", lat: 29.8894068731851, long: -97.93893590941295, imageName: "dmilab")
   
]
struct Item: Identifiable {
      let id = UUID()
      let name: String
      let neighborhood: String
      let desc: String
      let lat: Double
      let long: Double
      let imageName: String
  }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.888587717310582, longitude: -97.9411404990729), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                }
                .frame(height: 300)
                .padding(.bottom, -30)
                
                
                .listStyle(PlainListStyle())
                .navigationTitle("Sip N Study")
            }
        }
    }
}

struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Location: \(item.neighborhood)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                    }
                     .navigationTitle(item.name)
                     Spacer()
            Map(coordinateRegion: $region, annotationItems: [item]) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                }
                    .frame(height: 300)
                    .padding(.bottom, -30)
         }
      }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
