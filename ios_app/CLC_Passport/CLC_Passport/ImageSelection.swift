//
//  ImageValidationStart.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 05.01.22.
//

import SwiftUI

struct ImageSelection: View {

    @State private var isShowCamera = false
    @State private var image = UIImage()
    @Binding var rootIsActive : Bool

    var body: some View {
        VStack(spacing: 10) {
            Text("Image Preview").font(.headline)

            Image(uiImage: image)
                .resizable().scaledToFill().frame(minWidth: 0, maxWidth: .infinity).edgesIgnoringSafeArea(.all)

            if (image.size.width != 0) {
                NavigationLink(destination: ImageValidation(image: image, rootIsActive: self.$rootIsActive)) {
                    Text("Start prediction").font(.headline)
                }.isDetailLink(false).disabled(false).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.green).foregroundColor(.white).cornerRadius(20).padding(.horizontal).contentShape(RoundedRectangle(cornerRadius: 20))
            } else {
                NavigationLink(destination: ImageValidation(image: image, rootIsActive: self.$rootIsActive)) {
                    Text("Start prediction").font(.headline)
                }.isDetailLink(false).disabled(true).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.gray).foregroundColor(.white).cornerRadius(20).padding(.horizontal).contentShape(RoundedRectangle(cornerRadius: 20))
            }
            Button(action: {
                self.isShowCamera = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))

                    Text("Camera")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.blue).foregroundColor(.white).cornerRadius(20).padding(.horizontal)
            }
        }.sheet(isPresented: $isShowCamera) {
            ImagePicker(selectedImage: $image, sourceType: .camera)
        }
        .navigationTitle("Image Selection")
    }
}
