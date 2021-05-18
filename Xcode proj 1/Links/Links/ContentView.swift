//
//  ContentView.swift
//  Links
//
//  Created by Drole on 11/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            VStack{
                Text("open youtube channel")
                Text("")

                Link(destination: URL(string: "https://youtube.com/ViralVirusian")!, label: {
                    Text("open on Youtube")
                        .bold()
                })
                .frame(width: 250, height: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                Text("")

                Text("open google search")
                Text("")


                Link(destination: URL(string: "https://google.com/")!, label: {
                    Text("open Google")
                        .bold()
                })
                .frame(width: 250, height: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .navigationTitle("Links")
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}}


