//
//  ResultView.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 17.01.22.
//

import SwiftUI

struct ResultView: View {

    var image: UIImage
    var result: String

    @Binding var shouldPopToRootView : Bool

    var body: some View {
        if result == "0" || result == "15" || result == "-15" {
            Text("Congratulations!").font(.title)
            Spacer()
            Text("Your Image is a valid Passphoto! It was \(result)° off angle.").font(.subheadline)
        } else {
            Text("Sorry :(").font(.title)
            Spacer()
            Text("Your Image is not a valid Passphoto. It was \(result)° off angle.").font(.subheadline)
        }
        Spacer()
        Text("Your Image").font(.headline)
        Image(uiImage: image)
            .resizable().scaledToFit()
            .navigationTitle("Result")
            .navigationBarBackButtonHidden(true)
        Button(action: { self.shouldPopToRootView = false } ){
            Text("Restart the process")
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.blue).foregroundColor(.white).cornerRadius(20).padding(.horizontal).contentShape(RoundedRectangle(cornerRadius: 20))
    }
}
