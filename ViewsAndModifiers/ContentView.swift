//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Izaan Saleem on 25/01/2024.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .foregroundStyle(.white)
            .background(.blue.gradient)
            .clipShape(.buttonBorder)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.white)
            .padding()
            .background(.indigo.gradient)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(
                0..<rows, id: \.self
            ) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}


struct LargeTitleText: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        VStack {
            Text(text)
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Spacer()
            content
        }
    }
}

extension View {
    func createLargeTitle(of text: String) -> some View {
        modifier(LargeTitleText(text: text))
    }
}



struct ContentView: View {
    var body: some View {
        VStack {
            CapsuleText(text: "Text from another struct")
            Text("Text from Title2")
                .modifier(Title())
            AngularGradient(colors: [.red, .green, .blue, .indigo, .brown, .red], center: .center)
                .frame(width: 300, height: 250)
                .clipShape(.rect(cornerRadius: 8))
                .watermarked(with: "Watermark text")
            
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.brown.gradient)
        .createLargeTitle(of: "This is titleText")
    }
}

#Preview {
    ContentView()
}
