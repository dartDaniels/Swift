//
//  ContentView.swift
//  TrainingSwiftUI
//
//  Created by Данила Казмирук on 25.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Rectangle().fill(.clear)
                    .frame(maxWidth: .infinity)
                VStack {
                    Text("Today")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(y: 4)
                    Text("Wednesday").font(.title3)
                    Text("june 26")
                }.frame(maxWidth: .infinity, maxHeight: 40)
                
                Image(systemName: "calendar")
                    .padding(.trailing, 28)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 56)
            VStack {
                Text("hello world")
                HStack {
                    Text("235 cal left")
                        .lineSpacing(10.0)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .font(.custom("XL", size: 25))
                    Image(systemName: "arrow.up")
                    Spacer()
                    Text("Add Food")
                        .lineSpacing(10.0)
                        .padding(10)
                        .font(.custom("XL", size: 25))
                        .background(Color(#colorLiteral(red: 0.8810713887, green: 0.4309601188, blue: 0.4063382447, alpha: 1)))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                        .cornerRadius(10.0)
                        
                }
                
            }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .padding(EdgeInsets(top: 20, leading: 18, bottom: 0, trailing: 16))
                //.border(Color.black)
                Spacer()
        }.frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0.77279526, green: 0.5147067308, blue: 0.547732234, alpha: 0.9)))
        // test 1
        
        
        
        
        
        //test 2
        //fsfsfdsfdsfd
    }
}

#Preview {
    ContentView()
}
