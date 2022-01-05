//
//  ContentView.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 05.01.22.
//

import SwiftUI

struct PassportIntro: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 50.0) {

                Text("CLC Passport App").font(.title)

                VStack(alignment: .leading, spacing: 15) {
                    Text("How to use the App").font(.headline)
                    Text("1. ").bold() + Text("Take a selfie of yourself.")
                    Text("2. ").bold() + Text("Make sure the background is white and your face is in good light.")
                    Text("3. ").bold() + Text("Start the processing flow via the button below.")
                    Text("4. ").bold() + Text("Our servers will test your image if it is a valid passport image and you will get confirmation if it is or not.").font(.body)
                }

                Spacer()

                NavigationLink(destination: ImageSelection()) {
                    Text("Start image validation").font(.headline)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.blue).foregroundColor(.white).cornerRadius(20).padding(.horizontal).contentShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                HStack {
                    Text("Alexander Karrer").font(.caption2).foregroundColor(.gray)
                    Text("Peter Jedinger").font(.caption2).foregroundColor(.gray)
                    Text("Christoph Plank").font(.caption2).foregroundColor(.gray)
                }
            }.padding()
        }
    }
}

struct Passport_Previews: PreviewProvider {
    static var previews: some View {
        PassportIntro()
.previewInterfaceOrientation(.portrait)
    }
}
