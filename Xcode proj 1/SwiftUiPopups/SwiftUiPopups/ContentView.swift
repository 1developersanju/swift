//
//  ContentView.swift
//  SwiftUiPopups
//
//  Created by Drole on 12/05/21.
//

import PopupView
import SwiftUI

struct ContentView: View {
    
    @State var ishowingPopUp = false
    
    var body: some View {
        NavigationView{
            VStack{
                Button(action: {
                    self.ishowingPopUp = true
                }
                       , label: {
                    Text("Pop Ups")
                        .frame(width: 220,
                               height: 50,
                               alignment: .center)
                        .background(Color.yellow)
                        .cornerRadius(8)
                        .padding()
                    })
            }
            .popup(isPresented: $ishowingPopUp, type:.toast, position: .top, animation: .easeIn, autohideIn: 3, closeOnTap: true, closeOnTapOutside: false,view: {
                Toast()
            })
            .navigationTitle("TOASTS")
         
        }
    }
}

struct Toast : View {
    var body: some View{
        ZStack{
            Color.blue
            HStack {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Color.white)
                    .padding()
                Text("You have 4 new messages and 2 friend requests.")
                    .foregroundColor(.white)
            }
            .padding()
        }
        .cornerRadius(12)
        .padding()
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
