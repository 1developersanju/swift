//
//  ContentView.swift
//  WebView
//
//  Created by Drole on 06/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            SwiftUIWebView(url: URL.init(string: "https://www.addtim.com"))
                .navigationTitle("Addtim WebView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
