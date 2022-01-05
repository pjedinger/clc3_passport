//
//  ImageValidationStart.swift
//  CLC_Passport
//
//  Created by Alexander Karrer on 05.01.22.
//

import SwiftUI

struct ImageSelection: View {

    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()

    var body: some View {
        VStack(spacing: 10) {
            Text("Image Preview").font(.headline)

            Image(uiImage: image)
                .resizable().scaledToFill().frame(minWidth: 0, maxWidth: .infinity).edgesIgnoringSafeArea(.all)

            NavigationLink(destination: ImageValidation(image: image)) {
                Text("Start validation").font(.headline)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.green).foregroundColor(.white).cornerRadius(20).padding(.horizontal).contentShape(RoundedRectangle(cornerRadius: 20))
            
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))

                    Text("Camera")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50).background(Color.blue).foregroundColor(.white).cornerRadius(20).padding(.horizontal)
            }
        }.sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(selectedImage: $image, sourceType: .camera)
        }
        .navigationTitle("Image Selection")
    }
}


struct ImageSelection_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelection()
    }
}
