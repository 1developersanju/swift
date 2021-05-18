//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Drole on 15/05/21.
//
import AVKit
import SwiftUI

struct ContentView: View {
    
    let url = URL(string: "https://www.youtube.com/watch?v=ckqvG0Rj35I")!
    
    var body: some View {
        NavigationView{
            VStack{
                VideoPlayer(player: AVPlayer(url: url))
                    .scaledToFill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
