//
//  Home.swift
//  Quiz-App
//
//  Created by Phong Le on 14/04/2021.
//

import SwiftUI


struct Home: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State private var show = false
    @ObservedObject var homeViewModel = HomeViewModel()

    var body: some View {
        VStack {
            VStack {
                Text("Quiz App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.purple)
                    .padding(.bottom)
                
                VStack(spacing: 10) {
                    Text("Choose the way")
                        .bold()
                    Text("you play!!!")
                        .bold()
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            LazyVGrid(columns: self.columns, spacing: 25) {
                ForEach(1...4, id: \.self) { i in
                    Button(action: { self.show.toggle() }) {
                        VStack(spacing: 10) {
                            Image("\(i)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                            
                            Text("SwiftUI Quiz")
                                .foregroundColor(.black)
                                .bold()
                            Text("LEVEL \(i)")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: self.$show) {
            QuestionView(showQuestion: self.$show, data: self.$homeViewModel.results)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
