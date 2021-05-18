//
//  ContentView.swift
//  DisclosureGroup
//
//  Created by Drole on 14/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isExpanded = false
    @State var isPrivacyExpanded = false
    @State var isTermsExpanded = true
    @State var isProductExpanded = false
    @State var isProduct1Expanded = true
    @State var isProduct2Expanded = false
    @State var isProduct3Expanded = false
    @State var isProduct4Expanded = false
    @State var isProduct5Expanded = false


    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
            DisclosureGroup(
                "Legal Stuff",
                isExpanded: $isExpanded
            ) {
                DisclosureGroup(
                    "Terms and Services",
                    isExpanded: $isTermsExpanded
                ) {
                    Text(
                        "What’s covered in these termsWe know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use our services, and what we expect from you."
                    )
                        .multilineTextAlignment(.leading)
                }
                .padding()
                DisclosureGroup(
                    "Privacy Policy",
                    isExpanded: $isPrivacyExpanded
                ) {
                    Text(
                        "What’s covered in these termsWe know it’s tempting to skip these Terms of Service, but it’s important to establish what you can expect from us as you use our services, and what we expect from you."
                    )
                        .multilineTextAlignment(.leading)
                }
                .padding()
                
                    .multilineTextAlignment(.leading)
            }
            .padding()
                DisclosureGroup(
                    "Products",
                    isExpanded: $isProductExpanded
                ) {
                    DisclosureGroup(
                        "Product 1",
                        isExpanded: $isProduct1Expanded
                    ) {
                        Text(
                          "Product 1 and Public review of product 1"
                        )
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    DisclosureGroup(
                        "Product 2",
                        isExpanded: $isProduct2Expanded
                    ) {
                        Text(
                            "Product 2 and Public review of product 2"
                        )
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                        .multilineTextAlignment(.leading)
                    DisclosureGroup(
                        "Product 3",
                        isExpanded: $isProduct3Expanded
                    ) {
                        Text(
                            "Product 3 and Public review of product 3"
                        )
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                        .multilineTextAlignment(.leading)
                    DisclosureGroup(
                        "Product 4",
                        isExpanded: $isProduct4Expanded
                    ) {
                        Text(
                            "Product 4 and Public review of product 4"
                        )
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                        .multilineTextAlignment(.leading)
                    DisclosureGroup(
                        "Product 5",
                        isExpanded: $isProduct5Expanded
                    ) {
                        Text(
                            "Product 5 and Public review of product 5"
                        )
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                        .multilineTextAlignment(.leading)
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Disclosure Group")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
