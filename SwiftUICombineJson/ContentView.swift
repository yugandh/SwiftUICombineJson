//
//  ContentView.swift
//  SwiftUICombineJson
//
//  Created by Yugandhar Kommineni on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.fetchUsers ?? []) { post in
                VStack {
                    Text(post.name)
                        .font(.headline)
                        .padding()
                    Text(post.company.name)
                        .font(.subheadline)
                        .padding()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
